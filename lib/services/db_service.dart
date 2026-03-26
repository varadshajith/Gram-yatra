import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Local SQLite database service for caching offline places data.
class DbService {
  static final DbService instance = DbService._init();
  static Database? _database;

  DbService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('places.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE places (
  xid TEXT PRIMARY KEY,
  name TEXT,
  kinds TEXT,
  osm TEXT,
  dist REAL,
  lon REAL,
  lat REAL
)
''');
  }

  Future<void> insertPlaces(List<Map<String, dynamic>> places) async {
    final db = await instance.database;
    final batch = db.batch();
    for (final place in places) {
      batch.insert(
        'places',
        _mapToDbRow(place),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<Map<String, dynamic>>> getPlaces() async {
    final db = await instance.database;
    final result = await db.query('places', orderBy: 'dist ASC');
    return result;
  }

  Map<String, dynamic> _mapToDbRow(Map<String, dynamic> place) {
    return {
      'xid': place['xid']?.toString() ?? '',
      'name': place['name']?.toString() ?? 'Unknown',
      'kinds': place['kinds']?.toString() ?? '',
      'osm': place['osm']?.toString() ?? '',
      'dist': place['dist'] != null ? (place['dist'] as num).toDouble() : 0.0,
      'lon': place['point'] != null ? (place['point']['lon'] as num).toDouble() : 0.0,
      'lat': place['point'] != null ? (place['point']['lat'] as num).toDouble() : 0.0,
    };
  }
}
