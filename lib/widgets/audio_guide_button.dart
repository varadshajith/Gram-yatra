import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import '../services/audio_guide_service.dart';

/// Audio Guide Button — ONLINE mode powered by Gemini 1.5 Flash.
///
/// Appears in the map bottom sheet alongside StoryModeButton.
/// Uses Gemini 1.5 Flash for rich, detailed summaries when online.
/// Caches results in SharedPreferences so Gemini is called at most once per place.
/// Falls back gracefully when offline with a nudge toward Story Mode.
class AudioGuideButton extends StatefulWidget {
  final String placeId;
  final String placeName;
  final String category;
  final String? description;
  final double? lat;
  final double? lng;

  const AudioGuideButton({
    super.key,
    required this.placeId,
    required this.placeName,
    required this.category,
    this.description,
    this.lat,
    this.lng,
  });

  @override
  State<AudioGuideButton> createState() => _AudioGuideButtonState();
}

class _AudioGuideButtonState extends State<AudioGuideButton>
    with SingleTickerProviderStateMixin {
  final _audioGuide = AudioGuideService();

  bool _loading = false;
  bool _speaking = false;
  bool _offline = false;
  String? _summary;

  // Pulse animation while speaking
  late AnimationController _pulseController;

  // Gemini API config
  static const String _baseUrl =
      'https://generativelanguage.googleapis.com/v1beta/models';
  static const String _model = 'gemini-1.5-flash';

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
      lowerBound: 1.0,
      upperBound: 1.15,
    );
    _pulseController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  // ─── Check connectivity ───────────────────────────────────────────────────
  Future<bool> _isOnline() async {
    final result = await Connectivity().checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }

  // ─── Cache helpers ────────────────────────────────────────────────────────
  Future<String?> _getCached() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('audio_summary_${widget.placeId}');
  }

  Future<void> _saveCache(String summary) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('audio_summary_${widget.placeId}', summary);
  }

  // ─── Call Gemini 1.5 Flash ────────────────────────────────────────────────
  Future<String> _callGemini() async {
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';

    final prompt = '''
You are a professional audio tour guide for Nashik, Maharashtra, India.
Give a vivid, engaging 4-sentence spoken summary of "${widget.placeName}".
Category: ${widget.category}
${widget.description != null ? 'Description: ${widget.description}' : ''}
${widget.lat != null ? 'Location: ${widget.lat}, ${widget.lng}' : ''}
Keep it under 100 words. Use a warm, informative tone as if narrating a documentary.
No bullet points. No markdown. Plain spoken sentences only.
''';

    final response = await http
        .post(
          Uri.parse('$_baseUrl/$_model:generateContent?key=$apiKey'),
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
              'maxOutputTokens': 200,
              'temperature': 0.7,
            }
          }),
        )
        .timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['candidates'][0]['content']['parts'][0]['text']
          .toString()
          .trim();
    }
    throw Exception('Gemini API returned ${response.statusCode}');
  }

  // ─── Main tap handler ────────────────────────────────────────────────────
  Future<void> _onTap() async {
    // If currently speaking → stop
    if (_speaking) {
      await _audioGuide.stop();
      _pulseController.stop();
      _pulseController.value = 1.0;
      setState(() => _speaking = false);
      return;
    }

    setState(() {
      _loading = true;
      _offline = false;
    });

    // Check connectivity first
    if (!await _isOnline()) {
      setState(() {
        _loading = false;
        _offline = true;
      });
      return;
    }

    // Try cache first, then Gemini
    try {
      _summary ??= await _getCached();
      _summary ??= await _callGemini();

      // Cache the result
      await _saveCache(_summary!);

      setState(() {
        _loading = false;
        _speaking = true;
      });

      // Start pulse animation
      _pulseController.repeat(reverse: true);

      // Speak the summary
      await _audioGuide.speak(_summary!);

      // Done speaking
      _pulseController.stop();
      _pulseController.value = 1.0;
      if (mounted) setState(() => _speaking = false);
    } catch (e) {
      _pulseController.stop();
      _pulseController.value = 1.0;
      if (mounted) {
        setState(() {
          _loading = false;
          _offline = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // ── Main button ─────────────────────────────────────────────
            GestureDetector(
              onTap: _loading ? null : _onTap,
              child: Transform.scale(
                scale: _speaking ? _pulseController.value : 1.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: _speaking ? Colors.red : Colors.orange,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: (_speaking ? Colors.red : Colors.orange)
                            .withValues(alpha: 0.35),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_loading)
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2),
                        )
                      else
                        Icon(
                          _speaking
                              ? Icons.stop_rounded
                              : Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      const SizedBox(width: 8),
                      Text(
                        _speaking ? 'Stop' : 'Audio Guide',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            // ── Gemini • Online badge ───────────────────────────────────
            if (_speaking || _summary != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade300),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.cloud_rounded,
                      size: 12,
                      color: Colors.blue.shade700,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Gemini • Online',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),

        // ── Offline warning ───────────────────────────────────────────────
        if (_offline) ...[
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.amber.shade300),
            ),
            child: Row(
              children: [
                Icon(Icons.wifi_off_rounded,
                    size: 16, color: Colors.amber.shade800),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Go offline — use Story Mode instead',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.amber.shade900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],

        // ── Summary text box ──────────────────────────────────────────────
        if (_summary != null && !_speaking) ...[
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.orange.shade100),
            ),
            child: Text(
              _summary!,
              style: const TextStyle(fontSize: 13, height: 1.6),
            ),
          ),
        ],
      ],
    );
  }
}
