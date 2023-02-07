import 'package:shake/shake.dart';
import '../widgets/top_bar.dart';
import './text_to_speech.dart';

class Shake {
  static ShakeDetector detector = ShakeDetector.waitForStart(
    onPhoneShake: () {
      if (TopBar.controller.text.isEmpty) {
        TextToSpeech.speak("誰か来てください");
      } else {
        TextToSpeech.speak("${TopBar.controller.text}さん来てください");
      }
    },
    minimumShakeCount: 2,
    shakeSlopTimeMS: 500,
    shakeCountResetTime: 3000,
    shakeThresholdGravity: 2.7,
  );
}
