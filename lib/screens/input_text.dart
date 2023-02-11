import 'package:flutter/material.dart';
import 'package:text_to_speech_demo/widgets/top_bar.dart';
import '../widgets/shake.dart';
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
  void initState() {
    super.initState();
    Shake.detector.startListening();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Shake.detector.stopListening();
    super.dispose();
  }

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

    bool isDarkMode(BuildContext context) {
      final Brightness brightness = MediaQuery.platformBrightnessOf(context);
      return brightness == Brightness.dark;
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
                            elevation: 5,
                            backgroundColor: isDarkMode(context)
                                ? Colors.grey[800]
                                : Theme.of(context).colorScheme.primary,
                            shape: const CircleBorder(),
                            minimumSize: const Size(50, 50),
                            maximumSize: const Size(100, 100),
                          ),
                          child: Text(
                            type[i][j][0],
                            style: TextStyle(
                              fontSize: deviceWidth * 0.07,
                              color: isDarkMode(context)
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const TopBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                height: deviceHeight * 0.10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 0.2),
                ),
                child: SingleChildScrollView(
                  child: TextFormField(
                    controller: _inputTextController,
                    enabled: false,
                    maxLines: null,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.62,
                child: generateButtons(currentType),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                height: deviceHeight * 0.10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InputTextButton(
                      buttonFunction: onPlayButton,
                      buttonChild: Icon(
                        Icons.play_arrow,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    InputTextButton(
                      buttonFunction: onDakutenButton,
                      buttonChild: Text(
                        '"',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    InputTextButton(
                      buttonFunction: onChangeButton,
                      buttonChild: Text(
                        'ア',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    InputTextButton(
                      buttonFunction: onDeleteButton,
                      buttonChild: Icon(
                        Icons.backspace,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    InputTextButton(
                      buttonFunction: onClearButton,
                      buttonChild: Icon(
                        Icons.delete,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
