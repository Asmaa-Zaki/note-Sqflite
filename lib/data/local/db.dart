import 'package:sqflite/sqflite.dart';
import '../../model/note.dart';
import 'constants.dart';
class DbHelper{
  static final DbHelper dbHelper= DbHelper._instance();
  DbHelper._instance();

  //getPath
  Future<String> dbPath() async
  {
    String path= await getDatabasesPath();
    return path+"/"+dbName;
  }

  Future<Database> getDbInstance() async
  {
    String path= await dbPath();
    return openDatabase(path,
      version: dbVersion,
      onCreate: (db, version)=> onCreate(db)
    );
  }

  void onCreate(db) async
  {
    await db.execute("CREATE TABLE $tableName ($colId INTEGER PRIMARY KEY, $colTitle TEXT, $colText TEXT, $colDate TEXT, $colColor INTEGER)");
  }

  //
  Future<int> InsertToDB(Note note) async
  {
    Database db= await getDbInstance();
    return db.insert(tableName, note.toMap());
  }

  Future<List<Note>> getNotes() async
  {
    Database db= await getDbInstance();
    List<Map<String, dynamic>> query=
        await db.query(tableName);
    return query.map((e) => Note.fromMap(e)).toList();
  }

  Future<int> updateNotes(Note note) async{
    Database db = await getDbInstance();
    return db.update(tableName, note.toMap(),where:'$colId=?',whereArgs: [note.noteId]);
  }

  Future<int> deleteNote(int noteId) async {
    Database db = await getDbInstance();
    return db.delete(tableName,where: '$colId=?',whereArgs: [noteId]);
  }
}