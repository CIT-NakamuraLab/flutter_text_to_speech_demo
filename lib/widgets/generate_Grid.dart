import 'package:flutter/material.dart';

import './text_to_speech.dart';

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
    bool isDarkMode(BuildContext context) {
      final Brightness brightness = MediaQuery.platformBrightnessOf(context);
      return brightness == Brightness.dark;
    }

    final deviceWidth = MediaQuery.of(context).size.width;

    void buttonTapProcess() {
      TextToSpeech.speak(speakText);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: isDarkMode(context)
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.primary,
            width: 3,
          ),
        ),
        child: InkWell(
          onTap: () => buttonTapProcess(),
          onLongPress: () => buttonTapProcess(),
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
      ),
    );
  }
}
