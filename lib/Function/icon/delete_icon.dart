import 'package:flutter/material.dart';
import '../../models/opinion.dart';
import '../../widgets/delete_dialog.dart';

class DeleteIcon extends StatelessWidget {
  final int index;
  final Function refreshItems;
  final String routeName;
  final int id;
  final Opinion cardItem;
  const DeleteIcon({
    Key? key,
    required this.index,
    required this.refreshItems,
    required this.routeName,
    required this.id,
    required this.cardItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        child: const Icon(Icons.delete),
        onTap: () {
          showDialog(
            context: context,
            builder: (_) {
              return DeleteDialog(
                id: id,
                index: index,
                cardItem: cardItem,
                refreshJournals: refreshItems,
                category: cardItem.categories,
                routeName: routeName,
              );
            },
          );
        },
        onLongPress: () {
          showDialog(
            context: context,
            builder: (_) {
              return DeleteDialog(
                id: id,
                index: index,
                cardItem: cardItem,
                refreshJournals: refreshItems,
                category: cardItem.categories,
                routeName: routeName,
              );
            },
          );
        },
      ),
    );
  }
}
