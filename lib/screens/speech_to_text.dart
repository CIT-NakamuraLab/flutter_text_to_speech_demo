import 'package:flutter/material.dart';

import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_to_text.dart';

import '../widgets/bottom_tab.dart';
import './health_condition.dart';
import './take_hand.dart';
import './home_screen.dart';

class SpeechToText extends StatefulWidget {
  static const routeName = '/speech-to-text';
  const SpeechToText({super.key});

  @override
  State<SpeechToText> createState() => _SpeechToTextState();
}

class _SpeechToTextState extends State<SpeechToText> {
  String _currentLocaleId = "";
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  bool startStopFlag = true;
  stt.SpeechToText speech = stt.SpeechToText();

  // 音声認識開始
  Future<void> speak() async {
    bool available = await speech.initialize(
      onError: errorListener,
      onStatus: statusListener,
    );
    if (available) {
      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale.localeId ?? '';
      if (_currentLocaleId == "en_JP") {
        _currentLocaleId = "ja_JP";
      }
      speech.listen(onResult: resultListener, localeId: _currentLocaleId);
    } else {
      print("The user has denied the use of speech recognition.");
    }

    setState(
      () {
        startStopFlag = !startStopFlag;
      },
    );
  }

  // 音声入力停止
  Future<void> stop() async {
    speech.stop();
    setState(
      () {
        startStopFlag = !startStopFlag;
      },
    );
  }

  // エラーリスナー
  void errorListener(SpeechRecognitionError error) {
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  // ステータスリスナー
  void statusListener(String status) {
    setState(() {
      lastStatus = status;
    });
  }

  // リザルトリスナー
  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpeechToText'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: deviceHeight * 0.87,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Text(
                      '$lastWords',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(deviceHeight * 0.02),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: startStopFlag
                          ? FloatingActionButton(
                              heroTag: 'speak',
                              onPressed: speak,
                              child: const Icon(
                                Icons.play_arrow,
                              ),
                            )
                          : FloatingActionButton(
                              heroTag: 'stop',
                              onPressed: stop,
                              child: const Icon(
                                Icons.stop,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Theme.of(context).colorScheme.primary,
              height: deviceHeight * 0.13,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BottomTab(
                    transitionFunction: () {
                      Navigator.of(context).pop();
                    },
                    labelText: '戻る',
                    icon: Icons.undo,
                  ),
                  BottomTab(
                    transitionFunction: () => Navigator.of(context)
                        .popAndPushNamed(HealthCondition.routeName),
                    labelText: '健康状態',
                    icon: Icons.medical_services,
                  ),
                  BottomTab(
                    transitionFunction: () => Navigator.of(context)
                        .popAndPushNamed(TakeHand.routeName),
                    labelText: '取って',
                    icon: Icons.back_hand,
                  ),
                  BottomTab(
                    transitionFunction: () => Navigator.of(context)
                        .pushNamedAndRemoveUntil(
                            HomeScreen.routeName, (_) => false),
                    labelText: 'Top',
                    icon: Icons.home,
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
