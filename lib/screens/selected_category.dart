import 'dart:io';
import 'package:connect/Function/icon/edit_icon.dart';
import 'package:connect/Function/icon/floating_add_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Function/app_function.dart';
import '../models/opinion.dart';
import '../db/sql.dart';
import '../provider/state_provider.dart';
import '../widgets/text_to_speech.dart';
import '../widgets/shake.dart';
import '../widgets/delete_dialog.dart';
import '../Function/icon/delete_icon.dart';

class SelectedCategory extends ConsumerStatefulWidget {
  static const routeName = "/selected-category";
  final String category;
  final String title;
  final IconData iconData;

  const SelectedCategory({
    super.key,
    required this.category,
    required this.title,
    required this.iconData,
  });

  @override
  ConsumerState<SelectedCategory> createState() => _SelectedCategoryState();
}

class _SelectedCategoryState extends ConsumerState<SelectedCategory> {
  late String categoryTitle;
  late List<Opinion> detailsItem;
  late IconData iconData;
  late String category;

  List<Map<String, dynamic>> cardItems = [];
  late Opinion cardItem;
  @override
  void initState() {
    // TODO: implement initState
    Shake.detector.startListening();
    category = widget.category;
    iconData = widget.iconData;
    categoryTitle = widget.title;
    print("initState");
    refreshItems(category: category);
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    // initState -> didChangeDependencies
    // initStateにはcontextが作成されていないため
    final isloading = ref.watch(initloadProvider);
    if (isloading) {
      await AppFunction.initData();
      await refreshItems(category: category);
      ref.watch(initloadProvider.notifier).state = !isloading;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Shake.detector.stopListening();
    super.dispose();
  }

  Future<void> refreshItems({required String category}) async {
    final data = await Sql.refreshAndInitJournals(category: category);
    ref.watch(dataProvider.notifier).state = [...data];
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
      routeName: SelectedCategory.routeName,
      id: cardItems[index]["id"],
      cardItem: cardItem,
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
      routeName: SelectedCategory.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    cardItems = ref.watch(dataProvider);
    final isloading = ref.watch(initloadProvider);
    final deviceHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    Opinion cardItem;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          leading: IconButton(
            icon: Platform.isIOS
                ? const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
            onPressed: () {
              // ここで任意の処理
              TextToSpeech.speak("1つ前のページに戻りました");
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            categoryTitle,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ),
        body: isloading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.9,
                      child: RefreshIndicator(
                        onRefresh: () async {
                          TextToSpeech.speak("情報を更新しました");
                          await refreshItems(category: category);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 10,
                          ),
                          child: ListView.builder(
                            itemCount: cardItems.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: () => AppFunction.buttonTapProcess(
                                        cardItems[index]["description"]),
                                    onLongPress: () =>
                                        AppFunction.buttonTapProcess(
                                            cardItems[index]["description"]),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      leading: IconButton(
                                        onPressed: () {
                                          cardItem = Opinion(
                                            title: cardItems[index]["title"],
                                            description: cardItems[index]
                                                ["description"],
                                            categories: category,
                                            favorite: cardItems[index]
                                                ["favorite"],
                                          );
                                          AppFunction.updateFavorite(
                                            cardItem: cardItem,
                                            id: cardItems[index]["id"],
                                            refreshItems: refreshItems,
                                            routeName:
                                                SelectedCategory.routeName,
                                          );
                                        },
                                        icon: Icon(
                                          cardItems[index]["favorite"] != 0
                                              ? Icons.favorite_rounded
                                              : Icons.favorite_border,
                                          color: AppFunction.isDarkMode(context)
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .inversePrimary
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                        ),
                                      ),
                                      title: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          cardItems[index]["title"],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                          ),
                                          key: const Key(
                                              "selected_category_title"),
                                        ),
                                      ),
                                      trailing: Wrap(
                                        alignment: WrapAlignment.start,
                                        children: [
                                          editProcess(index),
                                          deleteProcess(index),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
        floatingActionButton: FloatingAddIcon(
          category: category,
          refreshItems: refreshItems,
          routeName: SelectedCategory.routeName,
        ));
  }
}
