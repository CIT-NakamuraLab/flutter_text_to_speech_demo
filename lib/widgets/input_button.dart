import '../models/japanese_model.dart';

class InputButton {
  static List<int> getHiragana(String hiragana) {
    // TODO ハードコーディングの修正
    switch (hiragana) {
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
    switch (hiragana) {
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

    for (int i = 0; i < JapaneseModel.hiragana.length; i++) {
      for (int j = 0; j < JapaneseModel.hiragana[i].length; j++) {
        for (int k = 0; k < JapaneseModel.hiragana[i][j].length; k++) {
          if (JapaneseModel.hiragana[i][j][k] == hiragana) {
            final List<int> newList = [];
            newList.add(i);
            newList.add(j);
            newList.add(k);
            return newList;
          }
        }
      }
    }
    return [0, 0, 1];
  }
}
