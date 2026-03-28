import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import '../utils/api_keys.dart';
import 'db_service.dart';

/// Fetches places from OpenTripMap with SQLite and local asset fallback.
class PlacesApiService {
  static const String _baseUrl = 'https://api.opentripmap.com/0.1/en/places/radius';
  
  // Nashik coordinates and params
  static const double _lat = 19.9975;
  static const double _lon = 73.7898;
  static const int _radius = 30000;
  static const String _kinds = 'religion,natural,cultural';

  /// Fetches places from API. If it fails, checks local SQLite DB, then fallback JSON.
  static Future<List<Map<String, dynamic>>> fetchPlaces() async {
    try {
      final uri = Uri.parse(
        '$_baseUrl?radius=$_radius&lon=$_lon&lat=$_lat&kinds=$_kinds&format=json&apikey=${ApiKeys.openTripMapKey}'
      );
      
      final response = await http.get(uri).timeout(const Duration(seconds: 10));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final places = data.cast<Map<String, dynamic>>();
        
        return places;
      } else {
        throw Exception('Failed to load places from API');
      }
    } catch (e) {
      debugPrint('API fetch failed: $e. Falling back to offline data.');
      return _getFallbackData();
    }
  }

  static Future<List<Map<String, dynamic>>> _getFallbackData() async {
    // 1. Try reading from SQLite cache
    final localPlaces = await DbService.instance.getAllPlaces();
    if (localPlaces.isNotEmpty) {
      return localPlaces;
    }

    // 2. If SQLite is empty, fall back to bundled assets JSON
    try {
      final String jsonString = await rootBundle.loadString('assets/data/places.json');
      final List<dynamic> data = json.decode(jsonString);
      final places = data.cast<Map<String, dynamic>>();
      
      return places;
    } catch (e) {
      debugPrint('Error loading asset fallback: $e');
      return [];
    }
  }
}
