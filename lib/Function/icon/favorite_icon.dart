import 'package:flutter/material.dart';
import '../../models/opinion.dart';
import '../app_function.dart';

class FavoriteIcon extends StatelessWidget {
  final int index;
  final Function refreshItems;
  final String routeName;
  final int id;
  final Opinion cardItem;
  const FavoriteIcon({
    Key? key,
    required this.index,
    required this.refreshItems,
    required this.routeName,
    required this.id,
    required this.cardItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppFunction.updateFavorite(
          cardItem: cardItem,
          id: id,
          refreshItems: refreshItems,
          routeName: routeName,
        );
      },
      onLongPress: () {
        AppFunction.updateFavorite(
          cardItem: cardItem,
          id: id,
          refreshItems: refreshItems,
          routeName: routeName,
        );
      },
      child: Icon(
        cardItem.favorite != 0 ? Icons.favorite_rounded : Icons.favorite_border,
        color: AppFunction.isDarkMode(context)
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
