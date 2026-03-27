import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiKeys {
  static String get openTripMapKey => dotenv.env['OPENTRIPMAP_API_KEY'] ?? '';
}