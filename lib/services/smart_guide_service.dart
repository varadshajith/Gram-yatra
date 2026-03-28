import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'gemma_service.dart';

class SmartGuideService {
  final GemmaService _gemma = GemmaService();
  String lastUsedModel = '';

  Future<String> getSummary({
    required String placeId,
    required String placeName,
    required String category,
    String? description,
  }) async {
    final cached = await _getCache(placeId);
    if (cached != null) {
      lastUsedModel = 'Cached';
      return cached;
    }

    // FIX: Corrected connectivity check
    final connectivityResultList = await Connectivity().checkConnectivity();
    final bool isOffline = connectivityResultList.length == 1 &&
        connectivityResultList.first == ConnectivityResult.none;

    String summary;

    if (!isOffline) {
      try {
        summary = await _gemma.generateStory(
          placeName: placeName,
          category: category,
          description: description,
        );
        lastUsedModel = 'Gemini';
      } catch (e) {
        summary = _buildFallback(placeName, category);
        lastUsedModel = 'Offline';
      }
    } else {
      summary = _buildFallback(placeName, category);
      lastUsedModel = 'Gemma • Offline';
    }

    await _saveCache(placeId, summary);
    return summary;
  }

  String _buildFallback(String name, String category) {
    return '$name is one of Nashik\'s most beloved destinations. '
        'Known for its $category character, it draws visitors from across India. '
        'A truly memorable stop on any Nashik itinerary.';
  }

  Future<String?> _getCache(String placeId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'smart_summary_$placeId';
    final saved = prefs.getString(key);
    if (saved == null) return null;
    final savedAt = prefs.getInt('${key}_ts') ?? 0;
    final age = DateTime.now().millisecondsSinceEpoch - savedAt;
    if (age > const Duration(days: 30).inMilliseconds) {
      await prefs.remove(key);
      await prefs.remove('${key}_ts');
      return null;
    }
    return saved;
  }

  Future<void> _saveCache(String placeId, String summary) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'smart_summary_$placeId';
    await prefs.setString(key, summary);
    await prefs.setInt('${key}_ts', DateTime.now().millisecondsSinceEpoch);
  }
}
