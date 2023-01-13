import 'package:flutter/material.dart';
import './sql_Management.dart';

class CreateDialog extends StatelessWidget {
  final String title;
  final int index;
  final List<Map<String, dynamic>> journals;
  final Function refreshJournals;
  const CreateDialog({
    super.key,
    required this.title,
    required this.index,
    required this.journals,
    required this.refreshJournals,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("さくじょしますか?"),
      content: Text(title),
      actions: [
        TextButton(
            onPressed: () {
              SqlManagement.deleteItem(journals[index]['id'], refreshJournals);
              Navigator.of(context).pop();
            },
            child: const Text("します")),
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("しません")),
      ],
    );
  }
}
