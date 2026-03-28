import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static final CacheService instance = CacheService._init();
  static const String _key = 'cached_plans';

  CacheService._init();

  Future<void> saveItinerary(String jsonPlan) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> plans = prefs.getStringList(_key) ?? [];

    plans.add(jsonPlan);

    // Keep only the last 5
    if (plans.length > 5) {
      plans = plans.sublist(plans.length - 5);
    }

    await prefs.setStringList(_key, plans);
  }

  Future<List<String>> getLastItineraries() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }
}
