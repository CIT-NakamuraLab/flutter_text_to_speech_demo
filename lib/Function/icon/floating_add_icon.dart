import 'package:connect/Function/app_function.dart';
import 'package:flutter/material.dart';

class FloatingAddIcon extends StatelessWidget {
  final String category;
  final Function refreshItems;
  final String routeName;
  const FloatingAddIcon({
    super.key,
    required this.category,
    required this.refreshItems,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "add",
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
      onPressed: () {
        AppFunction.modal(
            id: null,
            category: category,
            cardItem: null,
            refreshItems: refreshItems,
            context: context,
            routeName: routeName);
      },
    );
  }
}
