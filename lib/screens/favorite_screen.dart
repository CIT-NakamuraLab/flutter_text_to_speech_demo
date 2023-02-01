import 'package:flutter/material.dart';
import '../widgets/text_to_speech.dart';
import '../widgets/adding_edit_modal.dart';
import '../db/sql.dart';
import '../widgets/delete_dialog.dart';
import '../widgets/top_bar.dart';
import '../widgets/shake.dart';
import '../models/sample_model.dart';

class FavoriteScreen extends StatefulWidget {
  static const String routeName = "/favorite-screen";
  const FavoriteScreen({
    super.key,
  });

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool _loadedData = true;
  List<Map<String, dynamic>> cardItems = [];

  void initState() {
    // TODO: implement initState
    Shake.detector.startListening();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    // initState -> didChangeDependencies
    // initStateにはcontextが作成されていないため
    if (_loadedData) {
      // final routeArgs =
      //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      // final String category = routeArgs["category"]!;
      // iconData = routeArgs["iconData"]!;
      // categoryTitle = routeArgs["title"]!;
      print("didChangeDependencies");
      await initData();
      await refreshItems();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Shake.detector.stopListening();
    super.dispose();
  }

  Future<void> initData() async {
    final db = await Sql.getAllItems();
    print(db.isEmpty);
    if (db.isEmpty) {
      SAMPLE_DATA.map(
        (data) async {
          await Sql.createItem(
              title: data.title,
              description: data.description,
              categories: data.categories);
        },
      ).toList();
    }
  }

  Future<void> refreshItems() async {
    print("refreshItems");
    final data = await Sql.refreshAndFavoriteJournals();
    setState(() {
      cardItems = data;
      _loadedData = false;
    });
  }

  void _modal({required int? id, required String category}) {
    // 宣言しているcategoryを引数とする理由は､lateであるため､buildまでにinitializedしていないためnull

    showModalBottomSheet(
      context: context,
      elevation: 20,
      isScrollControlled: true,
      builder: (context) {
        return AddingEditModal(
          id: id,
          category: category,
          journals: cardItems,
          refreshJournals: refreshItems,
          routeName: FavoriteScreen.routeName,
        );
      },
    );
  }

  Future<void> _updateFavorite(
      {required int id, required int index, required String category}) async {
    int favorite = cardItems[index]["favorite"];
    if (cardItems[index]["favorite"] == 0) {
      favorite = 1;
    } else {
      favorite = 0;
    }
    await Sql.updateItemFavorite(id: id, favorite: favorite);
    refreshItems();
  }

  void buttonTapProcess(int index) {
    TextToSpeech.speak(
      cardItems[index]["description"],
    );
  }

  final notCardItem = "お気に入りカードが存在しません";

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const TopBar(),
      ),
      body: cardItems.isEmpty
          ? Center(
              child: TextButton(
                onPressed: () async {
                  await refreshItems();
                  cardItems.isEmpty
                      ? TextToSpeech.speak(notCardItem)
                      : TextToSpeech.speak("お気に入り情報を更新しました");
                },
                child: Text(
                  notCardItem,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            )
          : RefreshIndicator(
              onRefresh: () async {
                TextToSpeech.speak("お気に入り情報を更新しました");
                await refreshItems();
              },
              child: ListView.builder(
                itemCount: cardItems.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      left: 15,
                      right: 15,
                      bottom: 7.5,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        TextToSpeech.speak(
                          cardItems[index]["description"],
                        );
                      },
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () => buttonTapProcess(index),
                          onLongPress: () => buttonTapProcess(index),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            leading: GestureDetector(
                              onTap: () => _updateFavorite(
                                index: index,
                                id: cardItems[index]["id"],
                                category: cardItems[index]["categories"],
                              ),
                              onLongPress: () => _updateFavorite(
                                index: index,
                                id: cardItems[index]["id"],
                                category: cardItems[index]["categories"],
                              ),
                              child: Icon(
                                cardItems[index]["favorite"] != 0
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            title: Text(
                              cardItems[index]["title"],
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            tileColor: Colors.white,
                            // Theme.of(context).colorScheme.secondary,
                            trailing: SizedBox(
                              // width:100になるように iPhone14 Pro MAX width:430/3.4
                              width: deviceWidth / 3.9,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 0),
                                    child: GestureDetector(
                                      child: const Icon(Icons.edit),
                                      onTap: () {
                                        _modal(
                                          id: cardItems[index]['id'],
                                          category: cardItems[index]
                                              ["categories"],
                                        );
                                      },
                                      onLongPress: () {
                                        _modal(
                                          id: cardItems[index]['id'],
                                          category: cardItems[index]
                                              ["categories"],
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 0),
                                    child: GestureDetector(
                                      child: const Icon(Icons.delete),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) {
                                            return DeleteDialog(
                                              index: index,
                                              journals: cardItems,
                                              refreshJournals: refreshItems,
                                              category: cardItems[index]
                                                  ["categories"],
                                              routeName:
                                                  FavoriteScreen.routeName,
                                            );
                                          },
                                        );
                                      },
                                      onLongPress: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) {
                                            return DeleteDialog(
                                              index: index,
                                              journals: cardItems,
                                              refreshJournals: refreshItems,
                                              category: cardItems[index]
                                                  ["categories"],
                                              routeName:
                                                  FavoriteScreen.routeName,
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
