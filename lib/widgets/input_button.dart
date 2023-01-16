import '../models/japanese_model.dart';

class InputButton {
  static List<int> getListNum(List<List<List<String>>> type, String char) {
    // TODO ハードコーディングの修正
    switch (char) {
      case 'ば':
        return [2, 0, 0];
      case 'び':
        return [2, 0, 1];
      case 'ぶ':
        return [2, 0, 2];
      case 'べ':
        return [2, 0, 3];
      case 'ぼ':
        return [2, 0, 4];
    }
    switch (char) {
      case 'ぱ':
        return [1, 5, 0];
      case 'ぴ':
        return [1, 5, 1];
      case 'ぷ':
        return [1, 5, 2];
      case 'ぺ':
        return [1, 5, 3];
      case 'ぽ':
        return [1, 5, 4];
    }
    switch (char) {
      case 'バ':
        return [2, 0, 0];
      case 'ビ':
        return [2, 0, 1];
      case 'ブ':
        return [2, 0, 2];
      case 'ベ':
        return [2, 0, 3];
      case 'ボ':
        return [2, 0, 4];
    }
    switch (char) {
      case 'パ':
        return [1, 5, 0];
      case 'ピ':
        return [1, 5, 1];
      case 'プ':
        return [1, 5, 2];
      case 'ペ':
        return [1, 5, 3];
      case 'ポ':
        return [1, 5, 4];
    }

    for (int i = 0; i < type.length; i++) {
      for (int j = 0; j < type[i].length; j++) {
        for (int k = 0; k < type[i][j].length; k++) {
          if (type[i][j][k] == char) {
            final List<int> newList = [i, j, k];
            return newList;
          }
        }
      }
    }
    return [0, 0, 1];
  }
}
