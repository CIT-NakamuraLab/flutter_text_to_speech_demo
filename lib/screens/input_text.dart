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

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    final deviceWidth = MediaQuery.of(context).size.width;
    int buttonIndex = 0;

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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int j = 0;
                          j < JapaneseModel.hiragana[buttonIndex].length;
                          j++) ...{
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (int k = 0;
                                k <
                                    JapaneseModel
                                        .hiragana[buttonIndex][j].length;
                                k++) ...{
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: SizedBox(
                                  width: deviceWidth * 0.15,
                                  child: FloatingActionButton(
                                    heroTag: JapaneseModel.hiragana[buttonIndex]
                                        [j][k],
                                    backgroundColor: Colors.pink,
                                    onPressed: () {
                                      _inputTextController.text += JapaneseModel
                                          .hiragana[buttonIndex][j][k];
                                    },
                                    child: Text(
                                      JapaneseModel.hiragana[buttonIndex][j][k],
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
                ),
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
                          heroTag: 'dakuten',
                          onPressed: () {
                            // 最後の1文字を取得
                            final lastChar = _inputTextController.text
                                .substring(
                                    _inputTextController.text.length - 1);

                            // 最後の1文字"以外"を取得
                            final firstStr = _inputTextController.text
                                .substring(
                                    0, _inputTextController.text.length - 1);

                            // 最後の1文字が格納されているindexを取得
                            final List<int> lastCharList =
                                InputButton.getHiragana(lastChar);

                            try {
                              // TODO プログラム可読性の悪さを修正
                              _inputTextController.text = lastCharList[0] == 2
                                  ? firstStr +
                                      JapaneseModel.hiragana[lastCharList[0]]
                                          [lastCharList[1]][lastCharList[2]]
                                  : firstStr +
                                      JapaneseModel
                                              .hiragana[lastCharList[0] + 1]
                                          [lastCharList[1]][lastCharList[2]];
                            } catch (e) {
                              // 入力された文字が濁点の付いている文字の場合
                              _inputTextController.text = firstStr +
                                  JapaneseModel.hiragana[lastCharList[0] - 1]
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
