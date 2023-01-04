import 'package:flutter/material.dart';

class BottomTab extends StatelessWidget {
  final String transition;
  final String labelText;
  const BottomTab({
    super.key,
    required this.transition,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    Widget _generateTab() {
      return GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(transition),
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
              const Icon(
                Icons.medical_services,
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
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(transition),
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
              children: const [
                Icon(
                  Icons.medical_services,
                  color: Colors.white,
                ),
                Text(
                  '健康状態',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            width: 85,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Colors.amber,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.back_hand,
                  color: Colors.white,
                ),
                Text(
                  '取って',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            width: 85,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Colors.amber,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.draw,
                  color: Colors.white,
                ),
                Text(
                  'メモ',
                  style: TextStyle(
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
