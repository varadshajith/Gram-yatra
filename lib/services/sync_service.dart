import 'package:connectivity_plus/connectivity_plus.dart';
import 'db_service.dart';
import 'firestore_service.dart';
import 'package:flutter/foundation.dart';

class SyncService {
  static final SyncService instance = SyncService._init();

  SyncService._init();

  /// Attempts to sync unsynced data from local SQLite to Firestore.
  /// Disregards if offline or the device has no unsynced items.
  Future<void> syncUnsyncedItineraries() async {
    try {
      final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();

      // Return immediately if there is no internet connection
      if (connectivityResult.contains(ConnectivityResult.none) && connectivityResult.length == 1) {
        debugPrint('Currently offline. Itineraries will be saved locally.');
        return;
      }

      final unsynced = await DbService.instance.getUnsyncedItineraries();

      if (unsynced.isEmpty) {
        return; // Nothing to sync
      }

      for (var itinerary in unsynced) {
        final id = itinerary['id'].toString();
        final title = itinerary['title'].toString();
        final content = itinerary['content'].toString();

        await FirestoreService.instance.saveItinerary(title, content);

        // Mark synced internally
        await DbService.instance.markItinerarySynced(id);
        debugPrint('Synced itinerary $id successfully.');
      }
    } catch (e) {
      debugPrint('Sync failed heavily, will try again later: $e');
    }
  }
}
