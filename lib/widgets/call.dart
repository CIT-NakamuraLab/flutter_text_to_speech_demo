import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomeModel extends ChangeNotifier {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> _speak(String speakText) async {
    await flutterTts.setLanguage('ja-JP');
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(speakText);
  }

  final String call = "助けてください";

  shakeGesture(BuildContext context) {
    ShakeDetector.autoStart(
      onPhoneShake: () {
        _speak(call);
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(call),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
