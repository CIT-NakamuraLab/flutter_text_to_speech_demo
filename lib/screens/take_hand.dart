import 'package:flutter/material.dart';

import '../db/sqlCrud.dart';
import '../widgets/delete_Dialog.dart';
import '../widgets/text_to_speech.dart';

import '../widgets/adding_edit_modal.dart';

class TakeHand extends StatefulWidget {
  static const routeName = '/take-hand';
  const TakeHand({super.key});

  @override
  State<TakeHand> createState() => _TakeHandState();
}

class _TakeHandState extends State<TakeHand> {
  final category = TakeHand.routeName.toString().replaceAll("/", "");

  List<Map<String, dynamic>> _journals = [];
  bool _isLoading = true;
  Future<void> refreshJournals() async {
    final data = await SqlCrud.refreshAndInitJournals(category: category);
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '取って欲しいもの',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(
              right: 10,
            ),
            child: Icon(
              Icons.back_hand,
            ),
          )
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
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
                            TextToSpeech.speak(_journals[index]["description"]);
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              leading: const Icon(
                                Icons.volume_up,
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
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          elevation: 20,
                                          isScrollControlled: true,
                                          builder: (context) {
                                            return AddingEditModal(
                                              id: _journals[index]['id'],
                                              category: category,
                                              journals: _journals,
                                              refreshJournals: refreshJournals,
                                            );
                                          },
                                        );
                                      },
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
                  ),
                ),
              ],
            ),
    );
  }
}
