class ApiKeys {
  // TODO: Replace with your actual OpenTripMap API key
  // You can register for a free key at https://opentripmap.io/product
  static const String openTripMapKey = 'YOUR_API_KEY_HERE';
  static const String backendUrl = String.fromEnvironment(
    'BACKEND_URL',
    defaultValue: 'http://10.0.2.2:3000',
  );
  
  static const String weatherApiKey = 'd7cf90b2b80fe93fb42cb810776bd090'; // Use generic fallback for hackathon
}
