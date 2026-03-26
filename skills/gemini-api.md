# skills/gemini-api.md — Gemini API Guide (Yash)
> Read CLAUDE.md and AGENTS.md first.

## Your Job
Wire the Plan Builder form → Firebase Function → Gemini API → display 3 plan cards in Flutter.

## Architecture
```
Flutter form → HTTP POST → Firebase Function → Gemini API → JSON response → Flutter cards
```
NEVER call Gemini directly from Flutter. Always go through Firebase Function.

## Firebase Function (functions/index.js)
```javascript
const { onRequest } = require("firebase-functions/v2/https");
const { GoogleGenerativeAI } = require("@google/generative-ai");

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);

exports.generatePlan = onRequest(async (req, res) => {
  res.set("Access-Control-Allow-Origin", "*");
  if (req.method === "OPTIONS") { res.status(204).send(""); return; }

  const { vibe, budget, hours } = req.body;

  const prompt = `
You are a local Nashik travel expert. Generate exactly 3 day plans for a tourist.

Input:
- Vibe: ${vibe} (options: spiritual, foodie, adventure, romantic, family)
- Budget: ${budget} (options: budget, mid, luxury)
- Time available: ${hours} hours

Respond ONLY with a valid JSON array, no markdown, no explanation:
[
  {
    "name": "Plan name (creative, Nashik-flavored)",
    "tagline": "One line description",
    "stops": ["Stop 1", "Stop 2", "Stop 3"],
    "estimatedCost": "₹500-800",
    "highlights": "What makes this plan special"
  }
]
Generate exactly 3 plans. Only JSON. No extra text.
  `;

  try {
    const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });
    const result = await model.generateContent(prompt);
    const text = result.response.text();
    const plans = JSON.parse(text);
    res.json({ success: true, plans });
  } catch (e) {
    // Fallback hardcoded plans if Gemini fails
    res.json({ success: true, plans: fallbackPlans(vibe) });
  }
});

function fallbackPlans(vibe) {
  return [
    {
      name: "The Pilgrim's Path",
      tagline: "Sacred Nashik in half a day",
      stops: ["Trimbakeshwar Temple", "Panchavati Ghats", "Kalaram Temple"],
      estimatedCost: "₹200-400",
      highlights: "Experience the spiritual heart of Nashik"
    },
    {
      name: "Wine & Dine",
      tagline: "Nashik's finest flavors",
      stops: ["Sula Vineyards", "Soma Wine Village", "Nashik Rd food street"],
      estimatedCost: "₹1500-2500",
      highlights: "India's wine capital at its best"
    },
    {
      name: "Hidden Nashik",
      tagline: "Where locals actually go",
      stops: ["Pandavleni Caves", "Dugarwadi Waterfall", "Old Nashik bazaar"],
      estimatedCost: "₹300-600",
      highlights: "Off the tourist trail"
    }
  ];
}
```

## Flutter — Call the Function
```dart
// lib/services/plan_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class PlanService {
  // Replace with your actual Firebase Function URL
  static const String _functionUrl =
      'https://us-central1-YOUR_PROJECT.cloudfunctions.net/generatePlan';

  Future<List<Map<String, dynamic>>> generatePlans({
    required String vibe,
    required String budget,
    required int hours,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_functionUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'vibe': vibe, 'budget': budget, 'hours': hours}),
      );
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['plans']);
    } catch (e) {
      debugPrint('PlanService: $e');
      return []; // Tanvi shows empty state
    }
  }
}
```

## Flutter — Display Plan Cards
```dart
// In plan_builder_screen.dart — wire to Tanvi's UI
// After form submit:
setState(() => _isLoading = true);
final plans = await PlanService().generatePlans(
  vibe: _selectedVibe,
  budget: _selectedBudget,
  hours: _selectedHours,
);
setState(() {
  _plans = plans;
  _isLoading = false;
});
```

## Deploy Function
```bash
cd functions
npm install @google/generative-ai
firebase functions:secrets:set GEMINI_API_KEY
firebase deploy --only functions
```

## Important
- Always test with fallback first (comment out Gemini call) before wiring real API
- The JSON parsing is the most fragile part — always have fallback plans ready
- Judges WILL ask if it's a real API call — make sure it is
