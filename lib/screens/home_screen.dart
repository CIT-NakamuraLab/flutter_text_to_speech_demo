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
    refreshJournals();
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
              title: const TopBar(),
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
                          child: Stack(
                            children: [
                              OutputList(),
                              GestureDetector(
                                dragStartBehavior: DragStartBehavior.down,
                                onPanUpdate: ((details) {
                                  position = details.localPosition;
                                  setState(() {});
                                }),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: position.dx,
                                      top: position.dy,
                                      child: FloatingActionButton(
                                        heroTag: "add",
                                        child: const Icon(Icons.add),
                                        onPressed: () => _modal(null),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
