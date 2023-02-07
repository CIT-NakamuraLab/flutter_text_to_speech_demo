import 'package:flutter/material.dart';
import 'package:text_to_speech_demo/screens/selected_category.dart';
import 'package:text_to_speech_demo/widgets/top_Bar.dart';
import '../models/category_model.dart';
import '../widgets/text_to_speech.dart';

class Home extends StatelessWidget {
  static const routeName = "/home";
  const Home({super.key});

  void selectedCategory({
    required BuildContext context,
    required int index,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        settings: const RouteSettings(name: "SelectedCategory"),
        builder: (context) => SelectedCategory(
          category: CATEGORY_DATA[index].category,
          iconData: CATEGORY_DATA[index].iconData,
          title: CATEGORY_DATA[index].title,
        ),
      ),
    );
    // Navigator.of(context).pushNamed(SelectedCategory.routeName, arguments: {
    //   "category": category,
    //   "title": title,
    //   "iconData": iconData,
    // });
  }

  void buttonTapProcess(int index) {
    TextToSpeech.speak(
      "${CATEGORY_DATA[index].title}ページに移動しました",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const TopBar(),
      ),
      body: SizedBox(
        child: ListView.builder(
          itemCount: CATEGORY_DATA.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                elevation: 5,
                // color: CATEGORY_DATA[index].color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: CATEGORY_DATA[index].color,
                    width: 3,
                  ),
                ),
                child: Ink(
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    leading: Icon(
                      CATEGORY_DATA[index].iconData,
                      // color: CATEGORY_DATA[index].color,
                      size: 50,
                    ),
                    title: Align(
                      alignment: Alignment.center,
                      child: Text(
                        CATEGORY_DATA[index].title,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    trailing: const Icon(Icons.volume_up),
                    onLongPress: () {
                      buttonTapProcess(index);
                      selectedCategory(
                        context: context,
                        index: index,
                      );
                    },
                    onTap: () {
                      buttonTapProcess(index);
                      selectedCategory(
                        context: context,
                        index: index,
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
