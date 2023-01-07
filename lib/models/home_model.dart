import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

class HomeModel extends ChangeNotifier {
  shakeGesture(BuildContext context) {
    ShakeDetector.autoStart(onPhoneShake: () {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: const Text('正常にシェイクを検知しました。'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          });
    });
  }
}
