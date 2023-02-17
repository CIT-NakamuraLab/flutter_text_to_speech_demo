import 'package:connect/models/opinion.dart';
import 'package:flutter/material.dart';
import '../app_function.dart';

class EditIcon extends StatelessWidget {
  final int? id;
  final Opinion cardItem;
  final Function refreshItems;
  final String routeName;
  const EditIcon({
    super.key,
    required this.cardItem,
    required this.refreshItems,
    required this.id,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: GestureDetector(
        child: const Icon(Icons.edit),
        onTap: () {
          AppFunction.modal(
            context: context,
            id: id,
            category: cardItem.categories,
            cardItem: cardItem,
            refreshItems: refreshItems,
            routeName: routeName,
          );
        },
        onLongPress: () {
          AppFunction.modal(
            context: context,
            id: id,
            category: cardItem.categories,
            cardItem: cardItem,
            refreshItems: refreshItems,
            routeName: routeName,
          );
        },
      ),
    );
    ;
  }
}
