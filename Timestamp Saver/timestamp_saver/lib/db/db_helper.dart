import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'timestamp_model.dart';

class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String NAME = 'timestamp';
  static const String TABLE = 'Timestamp_Table';
  static const String DB_NAME = 'timestamps.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //String path = join(documentsDirectory.path, DB_NAME);
    String path = "/data/data/com.example.timestamp_saver/databases/timestamps.db";
    print("Database Path: $path");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db
        .execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $NAME TEXT)");
  }

  Future<TimeStampModel> save(TimeStampModel timeStamp) async {
    var dbClient = await db;
    timeStamp.id = await dbClient.insert(TABLE,timeStamp.toJson());
    return timeStamp;
    /*
    await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + timeStamp.name + "')";
      return await txn.rawInsert(query);
    });
    */
  }

  Future<List<TimeStampModel>> getTimeStampModels() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [ID, NAME]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<TimeStampModel> timeStamps = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        timeStamps.add(TimeStampModel.fromJson(maps[i]));
      }
    }
    return timeStamps;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  
  Future<int> update(TimeStampModel timeStamp) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, timeStamp.toJson(),
        where: '$ID = ?', whereArgs: [timeStamp.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}