import 'package:flutter/material.dart';
import '../widgets/text_to_speech.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  static final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: Form(
              child: TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'お名前入力',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          ),
        ),
        const Text(
          '来てください',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        InkWell(
          onTap: () {
            controller.text.isEmpty
                ? TextToSpeech.speak("誰か来てください")
                : TextToSpeech.speak('${controller.text}さん来てください');
          },
          onLongPress: () {
            controller.text.isEmpty
                ? TextToSpeech.speak("誰か来てください")
                : TextToSpeech.speak('${controller.text}さん来てください');
          },
          child: Column(
            children: const [
              Icon(
                Icons.screen_rotation,
                color: Colors.black,
              ),
              Text(
                '振ってください',
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        )
      ],
    );
  }
}
