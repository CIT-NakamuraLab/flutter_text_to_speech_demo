import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../screens/selected_category.dart';
import '../widgets/text_to_speech.dart';

class HomeFunction {
  static void selectedCategory({
    required BuildContext context,
    required int index,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        settings: const RouteSettings(name: "SelectedCategory"),
        builder: (context) => SelectedCategory(
          category: categoryModel[index].category,
          iconData: categoryModel[index].iconData,
          title: categoryModel[index].title,
        ),
      ),
    );
  }

  static void buttonTapProcess(int index) {
    TextToSpeech.speak(
      "${categoryModel[index].title}ページに移動しました",
    );
  }
}
