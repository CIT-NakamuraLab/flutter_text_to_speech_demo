import 'package:flutter/material.dart';

class PaintProvider with ChangeNotifier {
  int selectIndex = 0;
  int penWidth = 1;

  Color get getColor {
    switch (selectIndex) {
      case 0:
        return Colors.black;
      case 1:
        return Colors.red;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.green;
      case 4:
        return Colors.yellow;
      case 5:
        return Colors.orange;
      case 6:
        return Colors.white;
      default:
        return Colors.black;
    }
  }

  void setSelectIndex(int index) {
    selectIndex = index;
    notifyListeners();
  }

  int get getPenWidth {
    return penWidth;
  }

  void setPenWidth(int width) {
    penWidth = width;
    notifyListeners();
  }
}
