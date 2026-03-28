import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'db_service.dart';

class FirestoreService {
  static final FirestoreService instance = FirestoreService._init();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  FirestoreService._init();

  String? get _userId => FirebaseAuth.instance.currentUser?.uid;

  Future<void> saveItinerary(String title, String content) async {
    final uid = _userId;
    if (uid == null) {
      await DbService.instance.saveItinerary(title, content);
      return;
    }
    try {
      await _db.collection('users').doc(uid).collection('itineraries').add({
        'title': title,
        'content': content,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to save itinerary to Firestore: $e');
    }
  }

  Stream<QuerySnapshot> getUserItineraries() {
    final uid = _userId;
    if (uid == null) {
      return const Stream.empty();
    }
    return _db.collection('users').doc(uid).collection('itineraries')
              .orderBy('createdAt', descending: true)
              .snapshots();
  }

  Future<void> saveFavouritePlace(Map<String, dynamic> placeData) async {
    final uid = _userId;
    if (uid == null) {
      await DbService.instance.saveFavouritePlace(placeData);
      return;
    }
    try {
      await _db.collection('users').doc(uid).collection('favourites').add({
        ...placeData,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to save favourite to Firestore: $e');
    }
  }

  Stream<QuerySnapshot> getUserFavourites() {
    final uid = _userId;
    if (uid == null) {
      return const Stream.empty();
    }
    return _db.collection('users').doc(uid).collection('favourites')
              .orderBy('createdAt', descending: true)
              .snapshots();
  }

  Future<void> saveTripHistory(Map<String, dynamic> tripData) async {
    final uid = _userId;
    if (uid == null) {
      await DbService.instance.saveTripHistory(tripData);
      return;
    }
    try {
      await _db.collection('users').doc(uid).collection('trips').add({
        ...tripData,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to save trip to Firestore: $e');
    }
  }

  Stream<QuerySnapshot> getUserTrips() {
    final uid = _userId;
    if (uid == null) {
      return const Stream.empty();
    }
    return _db.collection('users').doc(uid).collection('trips')
              .orderBy('createdAt', descending: true)
              .snapshots();
  }

  Future<void> saveUserProfile(String name, String email, String photoUrl) async {
    final uid = _userId;
    if (uid == null) return;
    try {
      await _db.collection('users').doc(uid).collection('profile').doc('userData').set({
        'name': name,
        'email': email,
        'photoUrl': photoUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to save user profile to Firestore: $e');
    }
  }
}
