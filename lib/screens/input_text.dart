import 'package:flutter/material.dart';

import '../models/letter_model.dart';
import '../widgets/text_to_speech.dart';
import '../widgets/input_text_buttons.dart';

class InputText extends StatefulWidget {
  static const routeName = '/input-text';
  const InputText({super.key});

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  final _inputTextController = TextEditingController();
  final _types = [
    LetterModel.hiragana,
    LetterModel.katakana,
    LetterModel.alphabat
  ];

  // タイプ切り替えボタンを押した時に加算される
  int typeIndex = 0;
  // typeIndexを順番に格納する
  List<int> typeIndexies = [];
  // 現在のタイプ
  List<List<List<String>>> currentType = LetterModel.hiragana;
  // 濁点の付け替えをしたい文字のタイプ
  List<List<List<String>>> selectedType = LetterModel.hiragana;
  // 最後の1文字が格納されているindexを取得し、格納
  List<int> lastCharList = [];

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    final deviceWidth = MediaQuery.of(context).size.width;

    void onLetterButton(String text) {
      TextToSpeech.speak(text);
      setState(() {
        typeIndexies.add(typeIndex % 3);
      });
      _inputTextController.text += text;
    }

    void onPlayButton() {
      TextToSpeech.speak(_inputTextController.text);
    }

    void onDakutenButton() {
      if (_inputTextController.text.trim().isEmpty) {
        return;
      }

      // 最後の1文字を取得
      final lastLetter = _inputTextController.text
          .substring(_inputTextController.text.length - 1);

      // 最後の1文字のタイプを取得(0: 平仮名, 1: 片仮名, 2: アルファベット)
      final lastLetterTypeIndex = typeIndexies.last;

      // 最後の1文字以外を取得
      final firstString = _inputTextController.text
          .substring(0, _inputTextController.text.length - 1);

      setState(() {
        selectedType = _types[lastLetterTypeIndex];
      });

      // 最後の1文字が格納されているindexを取得
      setState(() {
        lastCharList = LetterModel.getListNum(selectedType, lastLetter);
      });

      try {
        _inputTextController.text = firstString +
            selectedType[lastCharList[0]][lastCharList[1]][lastCharList[2] + 1];
        TextToSpeech.speak(selectedType[lastCharList[0]][lastCharList[1]]
            [lastCharList[2] + 1]);
      } catch (e) {
        _inputTextController.text =
            firstString + selectedType[lastCharList[0]][lastCharList[1]][0];
        TextToSpeech.speak(selectedType[lastCharList[0]][lastCharList[1]][0]);
      }
    }

    void onChangeButton() {
      setState(() {
        typeIndex++;
        currentType = _types[typeIndex % 3];
      });
    }

    void onDeleteButton() {
      if (_inputTextController.text.trim().isEmpty) {
        return;
      }

      // 最後の1文字以外を取得
      final firstString = _inputTextController.text
          .substring(0, _inputTextController.text.length - 1);
      _inputTextController.text = firstString;
      setState(() {
        typeIndexies.removeLast();
      });
    }

    void onClearButton() {
      _inputTextController.text = '';
      setState(() {
        typeIndexies.clear();
      });
    }

    Widget generateButtons(List<List<List<String>>> type) {
      return SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < type.length; i++) ...{
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int j = 0; j < type[i].length; j++) ...{
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: SizedBox(
                        width: deviceWidth * 0.15,
                        child: ElevatedButton(
                          onPressed: () => onLetterButton(type[i][j][0]),
                          onLongPress: () => onLetterButton(type[i][j][0]),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            shape: const CircleBorder(),
                            minimumSize: const Size(50, 50),
                            maximumSize: const Size(100, 100),
                          ),
                          child: Text(
                            type[i][j][0],
                            style: TextStyle(
                              fontSize: deviceWidth * 0.07,
                              // fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  },
                ],
              ),
            },
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('InputText'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: deviceHeight * 0.2,
              child: TextFormField(
                controller: _inputTextController,
                enabled: false,
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: deviceHeight * 0.6,
              child: generateButtons(currentType),
            ),
            SizedBox(
              height: deviceHeight * 0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InputTextButton(
                    buttonFunction: onPlayButton,
                    buttonChild: const Icon(Icons.play_arrow),
                  ),
                  InputTextButton(
                    buttonFunction: onDakutenButton,
                    buttonChild: const Text('"'),
                  ),
                  InputTextButton(
                    buttonFunction: onChangeButton,
                    buttonChild: const Text('ア'),
                  ),
                  InputTextButton(
                    buttonFunction: onDeleteButton,
                    buttonChild: const Icon(Icons.backspace),
                  ),
                  InputTextButton(
                    buttonFunction: onClearButton,
                    buttonChild: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
