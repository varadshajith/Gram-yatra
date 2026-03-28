import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GemmaService {
  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models';

  // FIX: Use gemma-3-1b-it which is available on Google AI Studio free tier
  // If this fails, fallback model is gemini-1.5-flash
  static const String _primaryModel = 'gemma-3-1b-it';
  static const String _fallbackModel = 'gemini-1.5-flash';

  Future<String> generateStory({
    required String placeName,
    required String category,
    String? description,
  }) async {
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';

    final prompt = '''
You are a local storyteller for Nashik, India.
Tell the story of "$placeName" in 3 warm sentences.
Category: $category
${description != null && description.isNotEmpty ? 'About: $description' : ''}
Under 80 words. Sound like a knowledgeable local friend.
No bullet points. Plain sentences only.
''';

    // Try Gemma first, fall back to Gemini if model not available
    for (final model in [_primaryModel, _fallbackModel]) {
      try {
        final response = await http
            .post(
              Uri.parse('$_baseUrl/$model:generateContent?key=$apiKey'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                'contents': [
                  {
                    'parts': [
                      {'text': prompt}
                    ]
                  }
                ],
                'generationConfig': {
                  'maxOutputTokens': 150,
                  'temperature': 0.8,
                },
              }),
            )
            .timeout(const Duration(seconds: 10));

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          return data['candidates'][0]['content']['parts'][0]['text']
              .toString()
              .trim();
        }
      } catch (_) {
        continue; // Try next model
      }
    }

    return _fallback(placeName, category);
  }

  String _fallback(String name, String category) {
    return '$name is one of Nashik\'s most cherished $category destinations. '
        'Visitors come from across India to experience its unique character. '
        'A place that stays with you long after your visit.';
  }
}