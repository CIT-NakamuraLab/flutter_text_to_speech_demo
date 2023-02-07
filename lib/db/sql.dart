import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class Sql {
  static Future<void> createTables(sql.Database database) async {
    print("createTables\n");

    // await database.execute("""DROP TABLE IF EXISTS items""");

    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        categories TEXT,
        favorite INTEGER NOT NULL DEFAULT 0,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP )""");
  }

  static Future<sql.Database> db() async {
    // print("db\n");
    // var databasesPath = await sql.getDatabasesPath();
    // String path = databasesPath + 'dev.db';
    // print(path);
    // await sql.deleteDatabase(path);

    return sql.openDatabase(
      'Arigatou.db',
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
    final db = await Sql.db();
    final data = {
      'title': title,
      'description': description,
      'categories': categories,
      'favorite': 0,
    };
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    // print("id" + id.toString());
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems(
      {required String categories}) async {
    // print("getItems\n");
    // print("categories:" + categories);
    final db = await Sql.db();
    return db.query(
      'items',
      where: 'categories = ?',
      whereArgs: [categories],
      orderBy: "id",
    );
  }

  static Future<List<Map<String, dynamic>>> getFavoriteItems(
      //   {
      //   required int favorite,
      // }
      ) async {
    final db = await Sql.db();
    return db.query(
      'items',
      where: 'favorite = 1',
      orderBy: "id",
    );
  }

  static Future<List<Map<String, dynamic>>> getAllItems() async {
    // print("getAllItem");
    final db = await Sql.db();
    return db.query(
      'items',
      orderBy: "id",
    );
  }

  // where id
  static Future<List<Map<String, dynamic>>> getItem({
    required int id,
  }) async {
    final db = await Sql.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem({
    required int id,
    required String title,
    required String description,
    required String categories,
  }) async {
    final db = await Sql.db();

    final data = {
      'title': title,
      'description': description,
      'categories': categories,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);
    // print(Sql());
    return result;
  }

  static Future<int> updateItemFavorite({
    required int id,
    required int favorite,
  }) async {
    final db = await Sql.db();
    final data = {
      'favorite': favorite,
      'createdAt': DateTime.now().toString(),
    };
    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);

    return result;
  }

  static Future<void> deleteItem({required int id}) async {
    final db = await Sql.db();
    try {
      await db.delete("items");
      // await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<List<Map<String, dynamic>>> refreshAndInitJournals(
      {required String category}) async {
    final data = await Sql.getItems(
      categories: category,
    );
    // print("Sql\n");
    print("refreshAndInitJournals :$data");
    return data;
  }

  static Future<List<Map<String, dynamic>>> refreshAndFavoriteJournals() async {
    final data = await Sql.getFavoriteItems(
        // favorite: favorite,
        );
    // print("Sql\n");
    print("refreshAndFavoriteJournals :$data");
    return data;
  }
}
