import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class GeminiService {
  final _model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: dotenv.env['GEMINI_API_KEY'] ?? '',
  );

  Future<List<Map<String, dynamic>>> generatePlan({
    required int hours,
    required int budget,
    required String preferences,
    required String groupType,
    required String crowdLevel,
    required double lat,
    required double lng,
  }) async {
    final prompt = '''
You are a local travel planner for Nashik, India.

Plan a trip for someone with:
- Available time: $hours hours
- Budget: ₹$budget
- Preferences: $preferences
- Group type: $groupType
- Crowd tolerance: $crowdLevel
- Current location: lat $lat, lng $lng

Return ONLY a JSON array, no explanation, no extra text.
Each item in the array must have exactly these fields:
{
  "place": "Place name",
  "duration": "1.5 hours",
  "cost": 200,
  "best_time": "Early morning before 8am",
  "tip": "One local tip here"
}

Only include real places in Nashik. Give 3 to 6 stops based on available time.
''';

    try {
      final response = await _model.generateContent([Content.text(prompt)]);
      final text = response.text ?? '';

      // Clean the response and parse JSON
      final cleaned = text
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();

      final List<dynamic> parsed = jsonDecode(cleaned);
      return parsed.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }
}