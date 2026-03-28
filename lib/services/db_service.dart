import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'sync_service.dart';

class DbService {
  static final DbService instance = DbService._init();
  static Database? _database;

  DbService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('places_v2.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    // Bumping version to 2 to bypass old grammar entirely
    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('DROP TABLE IF EXISTS places');
        await db.execute('DROP TABLE IF EXISTS itineraries');
        await _createDB(db, newVersion);
      },
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE places (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  lat REAL,
  lng REAL,
  category TEXT,
  description TEXT,
  photoUrl TEXT
)
''');

    await db.execute('''
CREATE TABLE itineraries (
  id TEXT PRIMARY KEY,
  title TEXT,
  content TEXT,
  synced INTEGER,
  createdAt INTEGER
)
''');

    await _seedDatabase(db);
  }

  Future<void> _seedDatabase(Database db) async {
    try {
      final String response = await rootBundle.loadString('assets/data/places.json');
      final List<dynamic> data = json.decode(response);

      for (var place in data) {
        await db.insert('places', {
          'name': place['name'],
          'lat': place['lat'],
          'lng': place['lng'],
          'category': place['category'],
          'description': place['description'],
          'photoUrl': place['photoUrl'],
        });
      }
    } catch (e) {
      // JSON might not exist during tests, fail silently 
    }
  }

  // Task 1 Methods for Places
  Future<List<Map<String, dynamic>>> getAllPlaces() async {
    final db = await instance.database;
    return await db.query('places');
  }

  Future<List<Map<String, dynamic>>> getPlacesByCategory(String category) async {
    final db = await instance.database;
    return await db.query(
      ('places'),
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  // Task 1 Methods for Itineraries
  Future<void> saveItinerary(String title, String content) async {
    final db = await instance.database;
    final id = DateTime.now().microsecondsSinceEpoch.toString();

    await db.insert('itineraries', {
      'id': id,
      'title': title,
      'content': content,
      'synced': 0,
      'createdAt': DateTime.now().millisecondsSinceEpoch,
    });

    // Fire off sync attempt immediately
    SyncService.instance.syncUnsyncedItineraries();
  }

  Future<List<Map<String, dynamic>>> getItineraries() async {
    final db = await instance.database;
    return await db.query('itineraries', orderBy: 'createdAt DESC');
  }

  // Helper for Sync Service to query unsynced items
  Future<List<Map<String, dynamic>>> getUnsyncedItineraries() async {
    final db = await instance.database;
    return await db.query('itineraries', where: 'synced = ?', whereArgs: [0]);
  }

  // Helper for Sync Service to mark item synced
  Future<void> markItinerarySynced(String id) async {
    final db = await instance.database;
    await db.update(
      'itineraries',
      {'synced': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
