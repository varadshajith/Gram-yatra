import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirestoreService instance = FirestoreService._init();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  FirestoreService._init();

  // Save itinerary to Firestore (no userId)
  Future<void> saveItinerary(String title, String content) async {
    try {
      await _db.collection('itineraries').add({
        'title': title,
        'content': content,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to save to Firestore: $e');
    }
  }

  // Load itineraries from Firestore (no userId)
  Stream<QuerySnapshot> getItineraries() {
    return _db.collection('itineraries')
              .orderBy('createdAt', descending: true)
              .snapshots();
  }
}
