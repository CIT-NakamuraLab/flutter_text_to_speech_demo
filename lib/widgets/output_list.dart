import 'package:flutter/material.dart';
import '../widgets/text_to_speech.dart';
import '../widgets/adding_edit_modal.dart';
import '../db/sqlCrud.dart';
import '../widgets/delete_Dialog.dart';
import '../models/sample_model.dart';
import '../screens/home_screen.dart';

class OutputList extends StatefulWidget {
  const OutputList({
    super.key,
  });

  @override
  State<OutputList> createState() => _OutputListState();
}

class _OutputListState extends State<OutputList> {
  List<Map<String, dynamic>> _journals = [];
  bool _isLoading = true;
  bool _isCalled = false;
  final category = HomeScreen.routeName.toString().replaceAll("/", "");

  Future<void> refreshJournals() async {
    final List<Map<String, dynamic>> data;
    data = await SqlCrud.refreshAndInitJournals(category: category);

    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initData();
    refreshJournals();
  }

  void initData() async {
    final db = await SqlCrud.getAllItems();
    print(db.isEmpty);
    if (db.isEmpty) {
      SAMPLE_DATA.map(
        (Data) async {
          await SqlCrud.createItem(
              title: Data.title,
              description: Data.description,
              categories: Data.categories);
        },
      ).toList();
    }
  }

  void updatePosition(BuildContext context) {
    setState(() {});
  }

  void _modal(int? id) {
    showModalBottomSheet(
      context: context,
      elevation: 20,
      isScrollControlled: true,
      builder: (context) {
        return AddingEditModal(
          id: id,
          category: category,
          journals: _journals,
          refreshJournals: refreshJournals,
        );
      },
    );
  }

  void _updateFavorite({required int id, required int index}) async {
    int favorite = _journals[index]["favorite"];
    if (_journals[index]["favorite"] == 0) {
      favorite = 1;
    } else {
      favorite = 0;
    }
    await SqlCrud.updateItemFavorite(id: id, favorite: favorite);
    refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    final deviceWidth = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: _journals.length,
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
                _journals[index]["description"],
              );
            },
            child: Card(
              elevation: 5,
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: IconButton(
                  onPressed: () => _updateFavorite(
                    index: index,
                    id: _journals[index]["id"],
                  ),
                  icon: Icon(
                    _journals[index]["favorite"] != 0
                        ? Icons.favorite_rounded
                        : Icons.favorite_border,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: Text(
                  _journals[index]["title"],
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
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _modal(
                          _journals[index]['id'],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return DeleteDialog(
                                title: _journals[index]["title"],
                                index: index,
                                journals: _journals,
                                refreshJournals: refreshJournals,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
