import 'package:flutter/material.dart';
import 'package:text_to_speech_demo/main.dart';

import '../widgets/input_button.dart';
import '../models/japanese_model.dart';

class InputText extends StatefulWidget {
  static const routeName = '/input-text';
  const InputText({super.key});

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  final _inputTextKey = GlobalKey<FormState>();
  final _inputTextController = TextEditingController();

  int typeIndex = 0;
  List<List<List<String>>> currentType = JapaneseModel.hiragana;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    final deviceWidth = MediaQuery.of(context).size.width;

    List<int> lastCharList = [];

    Widget generateButtons(List<List<List<String>>> type) {
      return SingleChildScrollView(
        child: Column(
          children: [
            for (int j = 0; j < type[0].length; j++) ...{
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int k = 0; k < type[0][j].length; k++) ...{
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: SizedBox(
                        width: deviceWidth * 0.15,
                        child: FloatingActionButton(
                          heroTag: type[0][j][k],
                          backgroundColor: Colors.pink,
                          onPressed: () {
                            _inputTextController.text += type[0][j][k];
                          },
                          child: Text(
                            type[0][j][k],
                            style: TextStyle(
                              fontSize: deviceWidth * 0.07,
                              // fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    )
                  }
                ],
              ),
            }
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('InputText'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: deviceHeight * 0.2,
                child: Form(
                  key: _inputTextKey,
                  child: TextFormField(
                    enabled: false,
                    style: TextStyle(fontSize: deviceWidth * 0.05),
                    controller: _inputTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(10),
                    ),
                    onChanged: (value) {
                      print(_inputTextController.text);
                    },
                    maxLines: null,
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.6,
                child: (() {
                  switch (typeIndex % 3) {
                    case 0:
                      return generateButtons(JapaneseModel.hiragana);
                    case 1:
                      return generateButtons(JapaneseModel.katakana);
                    case 2:
                      return generateButtons(JapaneseModel.alphabet);
                  }
                })(),
              ),
              SizedBox(
                height: deviceHeight * 0.15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        width: deviceWidth * 0.15,
                        child: FloatingActionButton(
                          heroTag: 'changeType',
                          onPressed: () {
                            setState(() {
                              typeIndex++;
                            });
                          },
                          child: const Text('あ/ア/a'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        width: deviceWidth * 0.15,
                        child: FloatingActionButton(
                          heroTag: 'dakuten',
                          onPressed: () {
                            switch (typeIndex % 3) {
                              case 0:
                                setState(() {
                                  currentType = JapaneseModel.hiragana;
                                });
                                break;
                              case 1:
                                setState(() {
                                  currentType = JapaneseModel.katakana;
                                });
                                break;
                              case 2:
                                setState(() {
                                  currentType = JapaneseModel.alphabet;
                                });
                                break;
                            }

                            if (_inputTextController.text.trim().isEmpty) {
                              return;
                            }

                            // 最後の1文字を取得
                            final lastChar = _inputTextController.text
                                .substring(
                                    _inputTextController.text.length - 1);

                            // 最後の1文字"以外"を取得
                            final firstStr = _inputTextController.text
                                .substring(
                                    0, _inputTextController.text.length - 1);

                            // 最後の1文字が格納されているindexを取得
                            setState(() {
                              lastCharList =
                                  InputButton.getListNum(currentType, lastChar);
                            });

                            try {
                              // TODO プログラム可読性の悪さを修正
                              _inputTextController.text = lastCharList[0] == 2
                                  ? firstStr +
                                      currentType[lastCharList[0]]
                                          [lastCharList[1]][lastCharList[2]]
                                  : firstStr +
                                      currentType[lastCharList[0] + 1]
                                          [lastCharList[1]][lastCharList[2]];
                            } catch (e) {
                              // 入力された文字が濁点の付いている文字の場合
                              _inputTextController.text = firstStr +
                                  currentType[lastCharList[0] - 1]
                                      [lastCharList[1]][lastCharList[2]];
                            }
                          },
                          child: Text(
                            ' "/。',
                            style: TextStyle(
                              fontSize: deviceWidth * 0.04,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        width: deviceWidth * 0.15,
                        child: FloatingActionButton(
                          heroTag: 'remove',
                          onPressed: () {
                            if (_inputTextController.text.trim().isNotEmpty) {
                              final newTexts = _inputTextController.text
                                  .substring(
                                      0, _inputTextController.text.length - 1);
                              _inputTextController.text = newTexts;
                            }
                          },
                          child: const Icon(Icons.backspace),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        width: deviceWidth * 0.15,
                        child: FloatingActionButton(
                          heroTag: 'delete',
                          onPressed: () {
                            _inputTextController.text = '';
                          },
                          child: const Icon(Icons.delete),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
