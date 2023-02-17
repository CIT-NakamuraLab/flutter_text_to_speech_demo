import 'package:connect/models/opinion.dart';
import 'package:flutter/material.dart';
import '../screens/favorite_screen.dart';

import '../db/sql.dart';
import '../models/sample_model.dart';
import '../widgets/adding_edit_modal.dart';
import '../widgets/text_to_speech.dart';

class AppFunction {
  static bool isDarkMode(BuildContext context) {
    final Brightness brightness = MediaQuery.platformBrightnessOf(context);
    return brightness == Brightness.dark;
  }

  static Future<void> initData() async {
    final db = await Sql.getAllItems();
    if (db.isEmpty) {
      opinionModel.map(
        (data) async {
          await Sql.createItem(
              title: data.title,
              description: data.description,
              categories: data.categories);
        },
      ).toList();
    }
  }

  static Future<void> updateFavorite({
    required Opinion cardItem,
    required int id,
    required Function refreshItems,
    required String routeName,
  }) async {
    int favorite = cardItem.favorite;
    favorite == 0 ? favorite = 1 : favorite = 0;
    await Sql.updateItemFavorite(id: id, favorite: favorite);

    routeName == FavoriteScreen.routeName
        ? refreshItems()
        : refreshItems(category: cardItem.categories);
  }

  static void modal({
    required int? id,
    required String category,
    required Opinion? cardItem,
    required Function refreshItems,
    required BuildContext context,
    required routeName,
  }) {
    // 宣言しているcategoryを引数とする理由は､lateであるため､buildまでにinitializedしていないためnull
    showModalBottomSheet(
      context: context,
      elevation: 20,
      isScrollControlled: true,
      builder: (context) {
        return AddingEditModal(
          id: id,
          cardItem: cardItem,
          category: category,
          refreshJournals: refreshItems,
          routeName: routeName,
        );
      },
    );
  }

  static void buttonTapProcess(String description) {
    TextToSpeech.speak(description);
  }

  static Widget favoriteUpdate(
      BuildContext context, Function refreshItems, bool isEmpty) {
    return Center(
      child: TextButton(
        onPressed: () async {
          await refreshItems();
          isEmpty
              ? TextToSpeech.speak("お気に入りカードが存在しません")
              : TextToSpeech.speak("お気に入り情報を更新しました");
        },
        child: Text(
          "お気に入りカードが存在しません",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppFunction.isDarkMode(context)
                ? Theme.of(context).colorScheme.inversePrimary
                : Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
