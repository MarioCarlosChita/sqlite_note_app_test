import 'package:sqlite_app/core/exception.dart';
import 'package:sqlite_app/services/database_service.dart';

import '../model/note.dart';

abstract class INoteRepository {
  Future<bool> save(Note note);

  Future<List<Note>> notes();
}

class NoteRepositoryImpl implements INoteRepository {
  NoteRepositoryImpl({required this.dbService});
  final DatabaseService dbService;

  @override
  Future<bool> save(Note note) async {
    final db = await dbService.openDb();
    try {
      // int response = await db.insert('note', note.toMap());
      int response = await db.transaction((txn) async {
         int id  = await txn.rawInsert('INSERT INTO notes(name) VALUES ("${note.name}")');
         return id;
      });

      int hasConflict = 0;
      return response != hasConflict;
    } catch (ex) {
      throw InsertErrorException(message: ex.toString());
    } finally {
      await db.close();
    }
  }

  @override
  Future<List<Note>> notes() {
     try{

     }
  }
}
