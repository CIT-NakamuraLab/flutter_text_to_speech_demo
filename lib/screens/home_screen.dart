import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:text_to_speech_demo/db/sqlCrud.dart';

import './health_condition.dart';
import './take_hand.dart';
import './paint_screen.dart';
import './speech_to_text.dart';
import '../widgets/bottom_tab.dart';
import '../widgets/call.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> _speak(String speakText) async {
    await flutterTts.setLanguage('ja-JP');
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(speakText);
  }

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  var name = "";

  List<Map<String, dynamic>> _journals = [];
  bool _isLoading = true;

  // データを引っ張る
  Future<void> _refreshJournals() async {
    final data = await SqlCrud.getItems();
    if (data.isEmpty) {
      print("empty");
      await SqlCrud.createItem(title: "ありがとう", descrption: "ありがとうございます");
      await SqlCrud.createItem(title: "すいません", descrption: "すいません");
      await SqlCrud.createItem(title: "のどがかわきました", descrption: "のどが､かわきました");
      await SqlCrud.createItem(title: "エアコン", descrption: "エアコンを操作してください");
      await SqlCrud.createItem(title: "トイレ", descrption: "トイレに行きたいです");
      await SqlCrud.createItem(title: "ぐあいがわるいです", descrption: "具合が悪いです");
      _refreshJournals();
    } else {
      print("notEmpty");
    }
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  void _showForm(int? id) async {
    if (id != null) {
      final existingJournal =
          _journals.firstWhere((element) => element["id"] == id);
      _titleController.text = existingJournal["title"];
      _descriptionController.text = existingJournal["description"];
    }
    showModalBottomSheet(
      context: context,
      elevation: 20,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            // this will prevent the soft keyboard from covering the text fields
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(hintText: "みることば"),
                  controller: _titleController,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: const InputDecoration(hintText: "いうことば"),
                  controller: _descriptionController,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (id == null) {
                      await _addItem();
                    } else {
                      await _updateItem(id);
                    }
                    _titleController.text = "";
                    _descriptionController.text = "";
                  },
                  child: id == null ? const Text("さくせい") : const Text("こうしん"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _addItem() async {
    await SqlCrud.createItem(
        title: _titleController.text, descrption: _descriptionController.text);
    _refreshJournals();
  }

  Future<void> _updateItem(int id) async {
    await SqlCrud.updateItem(
        id, _titleController.text, _descriptionController.text);
    _refreshJournals();
  }

  Future<void> _deleteItem(int id) async {
    await SqlCrud.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('さくじょしました!'),
    ));
    _refreshJournals();
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    // 追加するI/Oになる際には､reload回数が52回まで増加
    // 内40回程度がtitle widgetの変更だった
    final deviceHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    final deviceWidth = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider<HomeModel>(
      create: (context) => HomeModel()
        ..shakeGesture(
          context,
        ),
      child: Consumer<HomeModel>(
        builder: (context, value, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: Form(
                        child: TextFormField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            labelText: 'お名前入力',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          onChanged: ((value) {
                            setState(() {
                              name = value;
                            });
                          }),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'さん来てください',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      name.isEmpty
                          ? _speak("誰か来てください")
                          : _speak('$nameさん来てください');
                    },
                    child: Column(
                      children: [
                        const Icon(
                          Icons.screen_rotation,
                          color: Colors.black,
                        ),
                        Text(
                          'スマホを振ってください',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.redAccent[700],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
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
                                  _speak(_journals[index]["description"]);
                                },
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
                                  tileColor:
                                      Theme.of(context).colorScheme.secondary,
                                  trailing: SizedBox(
                                    // width:100になるように iPhone14 Pro MAX width:430/3.4
                                    width: deviceWidth / 3.9,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.edit),
                                            onPressed: () => _showForm(
                                                _journals[index]['id']),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () => _deleteItem(
                                                _journals[index]['id']),
                                          ),
                                        ]),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: deviceHeight * 0.13,
                        color: Theme.of(context).colorScheme.primary,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            BottomTab(
                              transitionFunction: () => Navigator.of(context)
                                  .pushNamed(HealthCondition.routeName),
                              labelText: '健康状態',
                              icon: Icons.medical_services,
                            ),
                            BottomTab(
                              transitionFunction: () => Navigator.of(context)
                                  .pushNamed(TakeHand.routeName),
                              labelText: '取って',
                              icon: Icons.back_hand,
                            ),
                            BottomTab(
                              transitionFunction: () => Navigator.of(context)
                                  .pushNamedAndRemoveUntil(
                                      PaintScreen.routeName,
                                      ((route) => false)),
                              labelText: 'メモ',
                              icon: Icons.draw,
                            ),
                            BottomTab(
                              transitionFunction: () => Navigator.of(context)
                                  .pushNamed(SpeechToText.routeName),
                              labelText: '音声認識',
                              icon: Icons.volume_up,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            floatingActionButton: Padding(
              padding: EdgeInsets.only(
                  top: 0, left: 0, right: 0, bottom: deviceHeight * 0.16),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () => _showForm(null),
                  heroTag: "add",
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
