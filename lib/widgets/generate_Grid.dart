import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class GenerateGrid extends StatelessWidget {
  final String labelText, speakText, routeName;
  const GenerateGrid({
    super.key,
    required this.labelText,
    required this.speakText,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    bool screenIcon = true;
    Color color = Colors.blue.shade700;
    if (routeName != "/take-hand") {
      screenIcon = false;
      color = Theme.of(context).colorScheme.primary;
    }

    final deviceWidth = MediaQuery.of(context).size.width;
    final FlutterTts flutterTts = FlutterTts();

    Future<void> speak(String speakText) async {
      await flutterTts.setLanguage('ja-JP');
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.setVolume(1.0);
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(speakText);
    }

    return GestureDetector(
      onTap: () {
        speak(speakText);
      },
      child: screenIcon
          ? Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: color,
                  width: 5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Icon(
                          Icons.back_hand,
                          color: color,
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        labelText,
                        style: TextStyle(
                          // Iphone 14 Pro max(width) 430 = 20(fontsize)* X
                          fontSize: deviceWidth / 21.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Icon(
                          Icons.volume_up,
                          color: color,
                        ),
                      ),
                    ]),
              ),
            )
          : Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: color,
                  width: 5,
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  labelText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: deviceWidth / 21.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
    );
  }
}
