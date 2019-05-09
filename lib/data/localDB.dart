import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reafel_app/models/eventDB_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "HeartWave_DB1.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Events ("
          "id TEXT PRIMARY KEY,"
          "date TEXT,"
          "time TEXT,"
          "location TEXT,"
          "duration DOUBLE,"
          "symptoms ARRAY,"
          "activity TEXT,"
          "notes TEXT,"
          "source TEXT,"
          "completed BOOLEAN"
          ")");

    });
  }

  /*newEvent(Event newEvent) async {
    final db = await database;
    var res = await db.insert("Event", newEvent.toJson());
    return res;
  }*/

  newEvent (Event newEvent) async {
    final db = await database;
    var res = await db.rawInsert(
        "INSERT Into Events (id, date)"
            " VALUES (${newEvent.id},${newEvent.date})");
    return res;
  }


  getAllEvents() async {
    final db = await database;
    var res = await db.query("Events");
    List<Event> list =
    res.isNotEmpty ? res.map((c) => Event.fromJson(c)).toList() : [];
    return list;
  }


}

