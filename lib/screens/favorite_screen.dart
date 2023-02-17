import 'package:connect/Function/icon/delete_icon.dart';
import 'package:connect/Function/icon/edit_icon.dart';
import 'package:connect/Function/icon/favorite_icon.dart';
import 'package:connect/models/opinion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Function/app_function.dart';
import '../provider/state_provider.dart';
import '../widgets/text_to_speech.dart';
import '../db/sql.dart';
import '../widgets/delete_dialog.dart';
import '../widgets/top_bar.dart';
import '../widgets/shake.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  static const String routeName = "/favorite-screen";
  const FavoriteScreen({
    super.key,
  });

  @override
  ConsumerState<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  List<Map<String, dynamic>> cardItems = [];
  late Opinion cardItem;

  void initState() {
    // TODO: implement initState
    Shake.detector.startListening();
    refreshItems();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    // initState -> didChangeDependencies
    // initStateにはcontextが作成されていないため
    final isLoading = ref.watch(initloadProvider);
    if (isLoading) {
      print("didChangeDependencies");
      await AppFunction.initData();
      await refreshItems();
      ref.watch(initloadProvider.notifier).state = !isLoading;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Shake.detector.stopListening();
    super.dispose();
  }

  Future<void> refreshItems() async {
    final data = await Sql.refreshAndFavoriteJournals();
    ref.watch(dataProvider.notifier).state = data;
  }

  void buttonTapProcess(int index) {
    cardItems = ref.watch(dataProvider);
    TextToSpeech.speak(
      cardItems[index]["description"],
    );
  }

  Widget favoriteProcess(int index) {
    cardItems = ref.watch(dataProvider);
    cardItem = Opinion(
      title: cardItems[index]["title"],
      description: cardItems[index]["description"],
      categories: cardItems[index]["categories"],
      favorite: cardItems[index]["favorite"],
    );
    return FavoriteIcon(
      cardItem: cardItem,
      index: index,
      refreshItems: refreshItems,
      routeName: FavoriteScreen.routeName,
      id: cardItems[index]["id"],
    );
  }

  Widget editProcess(int index) {
    cardItems = ref.watch(dataProvider);
    cardItem = Opinion(
      title: cardItems[index]["title"],
      description: cardItems[index]["description"],
      categories: cardItems[index]["categories"],
      favorite: cardItems[index]["favorite"],
    );
    return EditIcon(
      cardItem: cardItem,
      refreshItems: refreshItems,
      id: cardItems[index]["id"],
      routeName: FavoriteScreen.routeName,
    );
  }

  Widget deleteProcess(int index) {
    cardItems = ref.watch(dataProvider);
    cardItem = Opinion(
      title: cardItems[index]["title"],
      description: cardItems[index]["description"],
      categories: cardItems[index]["categories"],
      favorite: cardItems[index]["favorite"],
    );
    return DeleteIcon(
        index: index,
        refreshItems: refreshItems,
        routeName: FavoriteScreen.routeName,
        id: cardItems[index]["id"],
        cardItem: cardItem);
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final cardItems = ref.watch(dataProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const TopBar(),
      ),
      body: cardItems.isEmpty
          ? AppFunction.favoriteUpdate(context, refreshItems, false)
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
                            leading: favoriteProcess(index),
                            title: Text(
                              cardItems[index]["title"],
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            trailing: SizedBox(
                              // width:100になるように iPhone14 Pro MAX width:430/3.4
                              width: deviceWidth / 3.9,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  editProcess(index),
                                  deleteProcess(index),
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
