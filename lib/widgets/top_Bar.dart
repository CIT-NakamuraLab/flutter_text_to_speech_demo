import 'package:flutter/material.dart';

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
                decoration: InputDecoration(
                    labelText: 'お名前入力',
                    fillColor: Colors.grey[100],
                    filled: true,
                    labelStyle: const TextStyle(
                      color: Colors.blue,
                    )),
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 5,
          ),
          child: Text(
            '来てください',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Column(
          children: [
            Icon(
              Icons.screen_rotation,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            Text(
              '振ってください',
              style: TextStyle(
                fontSize: 10,
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ],
    );
  }
}
