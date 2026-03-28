import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import '../utils/api_keys.dart';
import 'cache_service.dart';

class GeminiService {
  Future<String> generatePlan({
    required List<String> preferences,
    required int days,
    required String budget,
  }) async {
    final connectivityResultList = await Connectivity().checkConnectivity();
    final bool isOffline = connectivityResultList.contains(ConnectivityResult.none) && connectivityResultList.length == 1;

    if (isOffline) {
      // Offline Flow
      final cachedPlans = await CacheService.instance.getLastItineraries();
      if (cachedPlans.isNotEmpty) {
        return cachedPlans.last;
      }
      return 'No cached plans available offline. Please connect to the internet to generate a custom itinerary.';
    }

    // Online Flow
    final url = Uri.parse('${ApiKeys.backendUrl}/generate-plan');
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'preferences': preferences,
          'days': days,
          'budget': budget,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final planString = data['plan'] ?? 'No plan returned';

        // Cache the newly generated plan
        await CacheService.instance.saveItinerary(planString);

        return planString;
      } else {
        throw Exception('Failed to generate plan: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Fallback in case of server failure even if theoretically online
      final cachedPlans = await CacheService.instance.getLastItineraries();
      if (cachedPlans.isNotEmpty) {
        return cachedPlans.last; // Fallback to last local plan perfectly!
      }
      throw Exception('Network error or backend issue: $e');
    }
  }
}
