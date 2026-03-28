import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiKeys {
  static String get openTripMapKey => dotenv.env['OPENTRIPMAP_API_KEY'] ?? '';
  
  static const String backendUrl = String.fromEnvironment(
    'BACKEND_URL',
    defaultValue: 'http://10.0.2.2:3000',
  );
  
  static const String weatherApiKey = 'd7cf90b2b80fe93fb42cb810776bd090'; // Use generic fallback for hackathon
}
