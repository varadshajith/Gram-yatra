import 'package:shared_preferences/shared_preferences.dart';
// TODO: Varad — add 'flutter_tts: ^4.0.2' to pubspec.yaml, then uncomment:
// import 'package:flutter_tts/flutter_tts.dart';
// TODO: Varad — add 'cloud_functions: ^4.6.0' to pubspec.yaml, then uncomment:
// import 'package:cloud_functions/cloud_functions.dart';

/// Audio Guide Service — 3-layer cached TTS for POI summaries.
///
/// Cache flow: memory (instant) → SharedPreferences (30-day TTL) → Firebase Cloud Function.
/// Once a summary is fetched, Gemini is never called again for that place.
///
/// Yug's scope: map_screen.dart, POI data, Google Maps integration.
/// Firebase Cloud Function → Yash's branch (yashodhan).
/// pubspec.yaml deps → Varad's branch (varad).
class AudioGuideService {
  static final AudioGuideService _instance = AudioGuideService._internal();
  factory AudioGuideService() => _instance;
  AudioGuideService._internal();

  // TODO: Uncomment once flutter_tts is in pubspec.yaml
  // final FlutterTts _tts = FlutterTts();
  // TODO: Uncomment once cloud_functions is in pubspec.yaml
  // final FirebaseFunctions _functions = FirebaseFunctions.instance;

  // In-memory cache — survives the session, zero network cost
  final Map<String, String> _memoryCache = {};

  bool _isSpeaking = false;
  bool get isSpeaking => _isSpeaking;

  // ─── Initialise TTS once ───────────────────────────────────────────────────
  Future<void> init() async {
    // TODO: Uncomment once flutter_tts is in pubspec.yaml
    // await _tts.setLanguage('en-IN');
    // await _tts.setSpeechRate(0.42);
    // await _tts.setVolume(1.0);
    // await _tts.setPitch(1.05);
    //
    // _tts.setCompletionHandler(() {
    //   _isSpeaking = false;
    // });
    //
    // _tts.setErrorHandler((msg) {
    //   _isSpeaking = false;
    // });
  }

  // ─── Main entry point ──────────────────────────────────────────────────────
  Future<String> getSummary({
    required String placeId,
    required String name,
    String? description,
    String? category,
    double? lat,
    double? lng,
  }) async {
    // 1. Check memory cache (fastest — zero network)
    if (_memoryCache.containsKey(placeId)) {
      return _memoryCache[placeId]!;
    }

    // 2. Check local persistent cache (survives app restarts)
    final localSummary = await _getLocalCache(placeId);
    if (localSummary != null) {
      _memoryCache[placeId] = localSummary;
      return localSummary;
    }

    // 3. Call Firebase Cloud Function
    // TODO: Uncomment once cloud_functions is in pubspec.yaml + Yash deploys function
    // try {
    //   final result = await _functions
    //       .httpsCallable(
    //         'generatePlaceSummary',
    //         options: HttpsCallableOptions(
    //           timeout: const Duration(seconds: 15),
    //         ),
    //       )
    //       .call({
    //     'placeId': placeId,
    //     'name': name,
    //     'description': description ?? '',
    //     'category': category ?? '',
    //     'lat': lat ?? 0.0,
    //     'lng': lng ?? 0.0,
    //   });
    //
    //   final summary = result.data['summary'] as String;
    //   _memoryCache[placeId] = summary;
    //   await _saveLocalCache(placeId, summary);
    //   return summary;
    // } catch (e) {
    //   // Fall through to fallback
    // }

    // 4. Fallback — never leave user with nothing
    final fallback = _generateFallback(name, category);
    _memoryCache[placeId] = fallback;
    await _saveLocalCache(placeId, fallback);
    return fallback;
  }

  // ─── Speak / Stop ──────────────────────────────────────────────────────────
  Future<void> speak(String text) async {
    if (_isSpeaking) {
      await stop();
      return;
    }
    _isSpeaking = true;
    // TODO: Uncomment once flutter_tts is in pubspec.yaml
    // await _tts.speak(text);
    // For now, just mark as done since TTS isn't available
    _isSpeaking = false;
  }

  Future<void> stop() async {
    _isSpeaking = false;
    // TODO: Uncomment once flutter_tts is in pubspec.yaml
    // await _tts.stop();
  }

  // ─── Local cache (SharedPreferences) ───────────────────────────────────────
  Future<String?> _getLocalCache(String placeId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'summary_$placeId';
    final saved = prefs.getString(key);
    if (saved == null) return null;

    // Expire after 30 days
    final savedAt = prefs.getInt('${key}_ts') ?? 0;
    final age = DateTime.now().millisecondsSinceEpoch - savedAt;
    if (age > const Duration(days: 30).inMilliseconds) {
      await prefs.remove(key);
      await prefs.remove('${key}_ts');
      return null;
    }
    return saved;
  }

  Future<void> _saveLocalCache(String placeId, String summary) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'summary_$placeId';
    await prefs.setString(key, summary);
    await prefs.setInt('${key}_ts', DateTime.now().millisecondsSinceEpoch);
  }

  // ─── Fallback summaries by category ────────────────────────────────────────
  String _generateFallback(String name, String? category) {
    switch (category?.toLowerCase()) {
      case 'pilgrimage':
        return '$name is a sacred site in Nashik, drawing devotees from across India. '
            'It holds deep spiritual significance and offers a peaceful atmosphere for reflection and prayer.';
      case 'nature':
        return '$name is a beautiful natural attraction in the Nashik region. '
            'A perfect escape from the city, offering fresh air and stunning scenery.';
      case 'food':
        return '$name is a popular food destination in Nashik, known for its authentic flavours. '
            'Food lovers visiting Nashik should not miss this iconic spot.';
      case 'adventure':
        return '$name is an exciting adventure destination near Nashik. '
            'Ideal for outdoor activities and exploring the natural landscape of the Sahyadris.';
      case 'history':
        return '$name is a historically significant site in Nashik. '
            'It offers visitors a window into the rich cultural heritage of this ancient city.';
      default:
        return '$name is a notable destination in Nashik worth exploring. '
            'It offers a unique experience and a glimpse into the character of this historic city.';
    }
  }

  void dispose() {
    // TODO: Uncomment once flutter_tts is in pubspec.yaml
    // _tts.stop();
  }
}
