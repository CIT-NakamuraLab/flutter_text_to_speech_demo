import 'package:flutter/material.dart';

class GenerateCaterory extends StatelessWidget {
  final String text, routeName;
  final IconData icon;
  const GenerateCaterory({
    super.key,
    required this.text,
    required this.icon,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      height: deviceHeight * 0.07,
      color: Colors.green[300],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.help,
              size: 36,
              color: Colors.white,
            ),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Icon(
              icon,
              size: 36,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
    ;
  }
}
