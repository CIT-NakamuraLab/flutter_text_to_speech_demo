import 'package:flutter/material.dart';

class InputTextButton extends StatelessWidget {
  final VoidCallback buttonFunction;
  final Widget buttonChild;
  const InputTextButton({
    super.key,
    required this.buttonFunction,
    required this.buttonChild,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => buttonFunction(),
      onLongPress: () => buttonFunction(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        shape: const CircleBorder(),
        minimumSize: const Size(50, 50),
        maximumSize: const Size(100, 100),
      ),
      child: buttonChild,
    );
  }
}
