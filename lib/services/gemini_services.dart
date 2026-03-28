import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/api_keys.dart';

class GeminiDirectService {
  Future<List<Map<String, dynamic>>> generatePlan({
    required int hours,
    required int budget,
    required String preferences,
    required String groupType,
    required String crowdLevel,
    required double lat,
    required double lng,
  }) async {
    final apiKey = ApiKeys.groqApiKey;
    final prompt = '''You are a local travel planner for Nashik, India.
Plan a trip for someone with:
- Available time: $hours hours
- Budget: ₹$budget
- Preferences: $preferences
- Group type: $groupType
- Crowd tolerance: $crowdLevel

Return ONLY a JSON array, no explanation, no extra text.
Each item must have exactly these fields:
{"place": "Place name", "duration": "1.5 hours", "cost": 200, "best_time": "Early morning", "tip": "One local tip"}
Only include real places in Nashik. Give 3 to 6 stops.''';

    try {
      final response = await http.post(
        Uri.parse('https://api.groq.com/openai/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'llama-3.3-70b-versatile',
          'messages': [{'role': 'user', 'content': prompt}],
          'temperature': 0.7,
        }),
      );
      final data = jsonDecode(response.body);
      final text = data['choices'][0]['message']['content'] as String;
      final cleaned = text.replaceAll('```json', '').replaceAll('```', '').trim();
      final List<dynamic> parsed = jsonDecode(cleaned);
      return parsed.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }
}
