import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiKeys {
  static String get openTripMapKey => dotenv.env['OPENTRIPMAP_API_KEY'] ?? '';
  
  static const String backendUrl = 'https://gram-yatra-production.up.railway.app';
  
  static const String weatherApiKey = 'd7cf90b2b80fe93fb42cb810776bd090'; // Use generic fallback for hackathon
}
