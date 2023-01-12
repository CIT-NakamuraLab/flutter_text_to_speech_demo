import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SqlCrud {
  static Future<void> createTables(sql.Database database) async {
    print("createTables\n");
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    print("db\n");
    return sql.openDatabase(
      'hoge.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(
      {required String title, required String? descrption}) async {
    final db = await SqlCrud.db();

    final data = {'title': title, 'description': descrption};
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    print("id:" + id.toString());
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    print("getItems\n");
    final db = await SqlCrud.db();
    return db.query('items', orderBy: "id");
  }

  // where id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SqlCrud.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(
      int id, String title, String? descrption) async {
    final db = await SqlCrud.db();

    final data = {
      'title': title,
      'description': descrption,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);
    print(SqlCrud());
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SqlCrud.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
