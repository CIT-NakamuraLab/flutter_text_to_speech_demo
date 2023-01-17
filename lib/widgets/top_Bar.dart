import 'package:flutter/material.dart';
import '../widgets/text_to_speech.dart';

class TopBar extends StatefulWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  final TextEditingController _controller = TextEditingController();
  var name = "";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'お名前入力',
                  fillColor: Colors.white,
                  filled: true,
                ),
                onChanged: ((value) {
                  setState(() {
                    name = value;
                  });
                }),
              ),
            ),
          ),
        ),
        const Text(
          'さん来てください',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        GestureDetector(
          onTap: () {
            name.isEmpty
                ? TextToSpeech.speak("誰か来てください")
                : TextToSpeech.speak('$nameさん来てください');
          },
          child: Column(
            children: [
              const Icon(
                Icons.screen_rotation,
                color: Colors.black,
              ),
              Text(
                'スマホを振ってください',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.redAccent[700],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
