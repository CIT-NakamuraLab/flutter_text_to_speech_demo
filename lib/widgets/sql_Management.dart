import '../db/sqlCrud.dart';

class SqlManagement {
  static Future<void> addItem(
      String title, String description, Function refreshJournals) async {
    await SqlCrud.createItem(title: title, descrption: description);
    refreshJournals();
  }

  static Future<void> updateItem(int id, String title, String description,
      Function refreshJournals) async {
    await SqlCrud.updateItem(id, title, description);
    refreshJournals();
  }

  static Future<void> deleteItem(int id, Function refreshJournals) async {
    await SqlCrud.deleteItem(id);
    refreshJournals();
  }
}
