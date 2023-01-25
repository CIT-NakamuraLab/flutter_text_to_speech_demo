import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import '../db/sqlCrud.dart';

class DeleteDialog extends StatelessWidget {
  final String title;
  final int index;
  final List<Map<String, dynamic>> journals;
  final Function refreshJournals;
  const DeleteDialog({
    super.key,
    required this.title,
    required this.index,
    required this.journals,
    required this.refreshJournals,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? AlertDialog(
            title: const Text("さくじょしますか?"),
            content: Text(title),
            actions: [
              TextButton(
                  onPressed: () {
                    SqlCrud.deleteItem(id: journals[index]['id']);
                    refreshJournals();
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
            content: Text(title),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  SqlCrud.deleteItem(id: journals[index]['id']);
                  refreshJournals();
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
