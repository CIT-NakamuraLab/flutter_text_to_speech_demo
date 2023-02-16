import 'dart:io';
import 'package:connect/models/opinion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../db/sql.dart';

class DeleteDialog extends StatelessWidget {
  final int index;
  // final List<Map<String, dynamic>> journals;
  final Opinion cardItem;
  final Function refreshJournals;
  final String category;
  final String routeName;
  final int id;
  const DeleteDialog({
    super.key,
    required this.index,
    required this.cardItem,
    required this.refreshJournals,
    required this.category,
    required this.id,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? AlertDialog(
            title: const Text("削除しますか?"),
            content: Text(cardItem.title),
            actions: [
              TextButton(
                  onPressed: () {
                    Sql.deleteItem(id: id);
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
              cardItem.title,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Sql.deleteItem(id: id);
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
