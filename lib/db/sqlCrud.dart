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
    required String? descrption,
    required String categories,
  }) async {
    final db = await SqlCrud.db();

    final data = {
      'title': title,
      'description': descrption,
      'categories': categories,
    };
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    print("id:" + id.toString());
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
    required String? descrption,
    required String categories,
  }) async {
    final db = await SqlCrud.db();

    final data = {
      'title': title,
      'description': descrption,
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

    if (data.isEmpty) {
      print("Empty");
      // Keyで管理しないと無限に増加
      await SqlCrud.createItem(
        title: "ありがとう",
        descrption: "ありがとうございます",
        categories: "home-screen",
      );
      await SqlCrud.createItem(
        title: "すいません",
        descrption: "すいません",
        categories: "home-screen",
      );
      await SqlCrud.createItem(
        title: "のどがかわきました",
        descrption: "のどが､かわきました",
        categories: "home-screen",
      );
      await SqlCrud.createItem(
        title: "エアコン",
        descrption: "エアコンを操作してください",
        categories: "home-screen",
      );
      await SqlCrud.createItem(
        title: "トイレ",
        descrption: "トイレに行きたいです",
        categories: "home-screen",
      );
      await SqlCrud.createItem(
        title: "ぐあいがわるいです",
        descrption: "具合が悪いです",
        categories: "home-screen",
      );
      await SqlCrud.createItem(
        title: "かみとペン",
        descrption: "紙とペンをとってください",
        categories: "take-hand",
      );
      await SqlCrud.createItem(
        title: "めがね",
        descrption: "めがねをとってください",
        categories: "take-hand",
      );
      await SqlCrud.createItem(
        title: "しんぶん",
        descrption: "新聞をとってください",
        categories: "take-hand",
      );
      await SqlCrud.createItem(
        title: "クスリ",
        descrption: "クスリをとってください",
        categories: "take-hand",
      );
      await SqlCrud.createItem(
        title: "リモコン",
        descrption: "リモコンをとってください",
        categories: "take-hand",
      );
      await SqlCrud.createItem(
        title: "ティッシュ",
        descrption: "ティッシュをとってください",
        categories: "take-hand",
      );
      await SqlCrud.createItem(
        title: "タオル",
        descrption: "タオルをとってください",
        categories: "take-hand",
      );
      await SqlCrud.createItem(
        title: "マスク",
        descrption: "マスクをとってください",
        categories: "take-hand",
      );
      await SqlCrud.createItem(
        title: "さいふ",
        descrption: "さいふをとってください",
        categories: "take-hand",
      );
      await SqlCrud.createItem(
        title: "くつした",
        descrption: "くつしたをとってください",
        categories: "take-hand",
      );
      await SqlCrud.createItem(
        title: "うわぎ",
        descrption: "うわぎをとってください",
        categories: "take-hand",
      );

      refreshAndInitJournals(category: category);
      // setState(() {
      //   _journals = data;
      //   _isLoading = false;
      // });
    }
    // print(data);
    return data;
  }
}
