import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  static Future<void> speak(String speakText) async {
    final FlutterTts flutterTts = FlutterTts();
    await flutterTts.stop();
    await flutterTts.setLanguage('ja-JP');
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(speakText);
  }
}
