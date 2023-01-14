import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

import './text_to_speech.dart';

class HomeModel extends ChangeNotifier {
  final String call = "助けてください";

  shakeGesture(BuildContext context) {
    ShakeDetector.autoStart(
      onPhoneShake: () {
        TextToSpeech.speak(call);
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
