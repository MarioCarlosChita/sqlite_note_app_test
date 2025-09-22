import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseService {
  // Private constructor
  DatabaseService._internal();

  // The single instance (lazily initialized)
  static final DatabaseService _instance = DatabaseService._internal();

  // Public getter to access the singleton instance
  factory DatabaseService() {
    return _instance;
  }

  Future<Database> openDb() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'note.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY, name TEXT)',
        );
      },
      version: 1,
    );
  }
}