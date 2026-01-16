import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database? db;

  Future<Database> initDatabase() async {
    if (db != null) {
      return db!;
    } else {
      return await _getDatabase();
    }
  }

  Future<Database> _getDatabase() async {
    var dbPath = await getDatabasesPath();
    var path = join(dbPath, 'example.db');

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE "tb_notes" (
            "id"	INTEGER,
            "title"	TEXT,
            "subtitle"	TEXT,
            PRIMARY KEY("id" AUTOINCREMENT)
          );
      ''');
      },
    );
    return db!;
  }

  Future<void> insertData(String title, String subtitle) async {
    var openDb = await initDatabase();
    await openDb.insert('tb_notes', {'title': title, 'subtitle': subtitle});
  }

  Future<void> readData() async {
    var openDb = await initDatabase();
    var data = await openDb.query('tb_notes');

    debugPrint("Data from db : $data");
  }

  Future<void> deleteData(int id) async {
    var openDb = await initDatabase();
    await openDb.delete('tb_notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateData(int id, String title, String subtitle) async {
    var openDb = await initDatabase();
    await openDb.update(
      'tb_notes',
      {'title': title, 'subtitle': subtitle},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAllData() async {
    var openDb = await initDatabase();
    await openDb.delete('tb_notes');
  }
}
