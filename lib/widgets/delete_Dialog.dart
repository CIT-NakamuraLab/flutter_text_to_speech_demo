import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../db/sqlCrud.dart';

class DeleteDialog extends StatelessWidget {
  final int index;
  final List<Map<String, dynamic>> journals;
  final Function refreshJournals;
  final String category;
  const DeleteDialog({
    super.key,
    required this.index,
    required this.journals,
    required this.refreshJournals,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? AlertDialog(
            title: const Text("さくじょしますか?"),
            content: Text(journals[index]["title"]),
            actions: [
              TextButton(
                  onPressed: () {
                    SqlCrud.deleteItem(id: journals[index]['id']);
                    refreshJournals(category: category);
                    Navigator.of(context).pop();
                  },
                  child: const Text("します")),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("しません")),
            ],
          )
        : CupertinoAlertDialog(
            title: const Text("さくじょしますか?"),
            content: Text(journals[index]["title"]),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  SqlCrud.deleteItem(id: journals[index]['id']);
                  refreshJournals(
                    category: category,
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('します'),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('しません'),
              ),
            ],
          );
  }
}
