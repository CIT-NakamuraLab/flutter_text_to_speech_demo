import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:connect/main.dart';
import '../../lib/models/category_model.dart';
import 'dart:math' as math;

void main() {
  group("Widget test", () {
    Future<void> initScreen(WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
    }

    Future<void> addItem(WidgetTester tester) async {
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      expect(find.byKey(const Key("adding_edit_modal_see")), findsOneWidget);
      expect(find.byKey(const Key("adding_edit_modal_speack")), findsOneWidget);
      expect(find.byKey(const Key("adding_edit_modal_make")), findsOneWidget);
      await tester.enterText(
          find.byKey(const Key("adding_edit_modal_see")), "Hoge");
      await tester.enterText(
          find.byKey(const Key("adding_edit_modal_speack")), "HogeHoge");

      await tester.tap(find.byKey(const Key("adding_edit_modal_make")));
      await tester.pump();
    }

    testWidgets("1.home画面にてタブのボタンを押して画面遷移することができるのか",
        (WidgetTester tester) async {
      await initScreen(tester);

      expect(find.text("飲み物"), findsOneWidget);

      // iconが適切か確認
      expect(find.byIcon(Icons.home_outlined), findsNothing);
      expect(find.byIcon(Icons.medical_services_outlined), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_alt_outlined), findsOneWidget);

      // iconを押して､画面遷移
      await tester.tap(find.byIcon(Icons.medical_services_outlined));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.medical_services_rounded), findsOneWidget);

      await tester.tap(find.byIcon(Icons.favorite_border));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.favorite_rounded), findsOneWidget);

      await tester.tap(find.byIcon(Icons.keyboard_alt_outlined));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.keyboard_alt_rounded), findsOneWidget);
    });
    testWidgets("2.ランダムなページに移動することができる", (WidgetTester tester) async {
      // その他ページが作成されていない?? categoryModel[6].title="その他"とは認識している
      var random = math.Random().nextInt(6);
      await initScreen(tester);

      // 画面遷移
      await tester.tap(find.byIcon(categoryModel[random].iconData));
      await tester.pump();

      // 画面遷移元に戻る
      Navigator.of(tester.element(find.byType(Navigator))).pop();
      await tester.pump();

      // 元のページが表示されていることを検証する
      expect(find.byIcon(categoryModel[random].iconData), findsOneWidget);
    });
    testWidgets("3. 画面遷移しカードを追加することができる", (WidgetTester tester) async {
      var random = math.Random().nextInt(6);
      await initScreen(tester);

      await tester.tap(find.byIcon(categoryModel[random].iconData));
      await tester.pump();

      expect(find.text(categoryModel[random].title), findsOneWidget);
      await tester.pump();
      expect(find.byIcon(Icons.add), findsOneWidget);

      await addItem(tester);

      expect(find.text("Hoge"), findsOneWidget);
    });
  });
}
