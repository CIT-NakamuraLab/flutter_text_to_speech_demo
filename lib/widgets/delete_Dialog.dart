import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../db/sql.dart';

class DeleteDialog extends StatelessWidget {
  final int index;
  final List<Map<String, dynamic>> journals;
  final Function refreshJournals;
  final String category;
  final String routeName;
  const DeleteDialog(
      {super.key,
      required this.index,
      required this.journals,
      required this.refreshJournals,
      required this.category,
      required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? AlertDialog(
            title: const Text("削除しますか?"),
            content: Text(journals[index]["title"]),
            actions: [
              TextButton(
                  onPressed: () {
                    Sql.deleteItem(id: journals[index]['id']);
                    routeName == "/selected-category"
                        ? refreshJournals(category: category)
                        : refreshJournals();
                    Navigator.of(context).pop();
                  },
                  child: const Text("します")),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("しません")),
            ],
          )
        : CupertinoAlertDialog(
            title: const Text("削除しますか?"),
            content: Text(
              journals[index]["title"],
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Sql.deleteItem(id: journals[index]['id']);
                  routeName == "/selected-category"
                      ? refreshJournals(category: category)
                      : refreshJournals();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'します',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'しません',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          );
  }
}
