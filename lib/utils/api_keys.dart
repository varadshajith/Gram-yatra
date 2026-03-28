class ApiKeys {
  // OpenTripMap API key — replace with your actual key or use .env
  static const String openTripMapKey = 'YOUR_API_KEY_HERE';

  static const String backendUrl = String.fromEnvironment(
    'BACKEND_URL',
    defaultValue: 'https://gram-yatra-production.up.railway.app',
  );

  static const String weatherApiKey = 'd7cf90b2b80fe93fb42cb810776bd090'; // User generic fallback for hackathon
  static const String groqApiKey = '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';
}
