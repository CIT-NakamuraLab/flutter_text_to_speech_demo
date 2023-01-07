import 'dart:ffi';

import 'package:flutter/material.dart';

class BottomTab extends StatelessWidget {
  final VoidCallback transitionFunction;
  final String labelText;
  final IconData icon;
  const BottomTab(
      {super.key,
      required this.transitionFunction,
      required this.labelText,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: transitionFunction,
          child: Container(
            width: deviceHeight * 0.12,
            height: deviceHeight * 0.08,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Colors.amber,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                ),
                Text(
                  labelText,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
