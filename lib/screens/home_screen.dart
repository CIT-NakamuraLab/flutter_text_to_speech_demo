import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_to_speech_demo/db/sqlCrud.dart';
import 'package:text_to_speech_demo/models/sample_model.dart';
import 'package:text_to_speech_demo/widgets/output_list.dart';
import 'package:text_to_speech_demo/widgets/top_Bar.dart';

import '../widgets/delete_Dialog.dart';
import './health_condition.dart';
import './take_hand.dart';
import './input_text.dart';
import '../widgets/bottom_tab.dart';
import '../widgets/call.dart';
import '../widgets/text_to_speech.dart';
import '../widgets/adding_edit_modal.dart';
import './paint_screen.dart';
import 'package:shake/shake.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var name = "";

  List<Map<String, dynamic>> _journals = [];
  bool _isLoading = true;
  bool _isCalled = false;

  final category = HomeScreen.routeName.toString().replaceAll("/", "");

  Offset position = const Offset(0, 0);

  // // データを引っ張る
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
    Call.shakeGesture(context);
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

  void buttonTapProcess(int index) {
    TextToSpeech.speak(
      _journals[index]["description"],
    );
  }

  @override
  Widget build(BuildContext context) {
    // 追加するI/Oになる際には､reload回数が52回まで増加
    // 内40回程度がtitle widgetの変更だった
    final deviceHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    final deviceWidth = MediaQuery.of(context).size.width;
    setState(() {
      if (!_isCalled) {
        position = Offset(deviceWidth * 0.8, deviceHeight * 0.75);
      }
      _isCalled = true;
    });

    print(MediaQuery.of(context).size.height);
    print(MediaQuery.of(context).padding.top);
    print(AppBar().preferredSize.height);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: TopBar(),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: deviceHeight * 0.87,
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
                          child: Card(
                            elevation: 5,
                            child: InkWell(
                              onTap: () => buttonTapProcess(index),
                              onLongPress: () => buttonTapProcess(index),
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
                                                title: _journals[index]
                                                    ["title"],
                                                index: index,
                                                journals: _journals,
                                                refreshJournals:
                                                    refreshJournals,
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
            ),
    );
  }
}
