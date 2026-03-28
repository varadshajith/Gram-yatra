import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/api_keys.dart';

class WeatherService {
  static const double lat = 20.0059;
  static const double lng = 73.7897;

  Future<Map<String, dynamic>> fetchNashikWeather() async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lng&appid=${ApiKeys.weatherApiKey}&units=metric'
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final temp = data['main']['temp'].round();
        final condition = data['weather'][0]['main']; // e.g. "Clear", "Clouds"
        final icon = data['weather'][0]['icon'];

        return {
          'temp': temp,
          'condition': condition,
          'iconUrl': 'https://openweathermap.org/img/wn/$icon@2x.png',
        };
      }
    } catch (_) {
      // Return highly structured fallback if completely offline or missing keys
    }

    return {
      'temp': 28,
      'condition': 'Sunny',
      'iconUrl': 'https://openweathermap.org/img/wn/01d@2x.png',
    };
  }
}
