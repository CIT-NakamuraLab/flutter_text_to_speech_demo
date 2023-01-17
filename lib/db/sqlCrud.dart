import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SqlCrud {
  static Future<void> createTables(sql.Database database) async {
    print("createTables\n");
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        categories TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP )""");
  }

  static Future<sql.Database> db() async {
    print("db\n");
    return sql.openDatabase(
      'dev.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createItem({
    required String title,
    required String description,
    required String categories,
  }) async {
    final db = await SqlCrud.db();
    final data = {
      'title': title,
      'description': description,
      'categories': categories,
    };
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    print("id" + id.toString());
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems(
      {required String categories}) async {
    print("getItems\n");
    print("categories:" + categories);
    final db = await SqlCrud.db();
    return db.query(
      'items',
      where: 'categories = ?',
      whereArgs: [categories],
      orderBy: "id",
    );
  }

  static Future<List<Map<String, dynamic>>> getAllItems() async {
    print("getAllItem");
    final db = await SqlCrud.db();
    return db.query(
      'items',
      orderBy: "id",
    );
  }

  // where id
  static Future<List<Map<String, dynamic>>> getItem({
    required int id,
  }) async {
    final db = await SqlCrud.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem({
    required int id,
    required String title,
    required String? description,
    required String categories,
  }) async {
    final db = await SqlCrud.db();

    final data = {
      'title': title,
      'description': description,
      "categories": categories,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);
    print(SqlCrud());
    return result;
  }

  static Future<void> deleteItem({required int id}) async {
    final db = await SqlCrud.db();
    try {
      // await db.delete("items");
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<List<Map<String, dynamic>>> refreshAndInitJournals(
      {required String category}) async {
    final data = await SqlCrud.getItems(
      categories: category,
    );
    print("sqlCrud\n");
    print(data);
    return data;
  }
}
