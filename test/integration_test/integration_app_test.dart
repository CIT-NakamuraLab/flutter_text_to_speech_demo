import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:connect/models/health_condition_model.dart';
import 'package:connect/models/category_model.dart';
import 'package:connect/main.dart' as app;
import 'dart:math' as math;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("Widget test", () {
    Future<void> initScreen(WidgetTester tester) async {
      app.main();
      // 初期画面で2秒待つためテストでは､3秒待ちその後描画する
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
    }

    Future<void> addEditItem({
      required WidgetTester tester,
      required String title,
      required String description,
      required String titleKey,
      required String descriptionKey,
      required String makeUpdateKey,
    }) async {
      expect(find.byKey(Key(titleKey)), findsOneWidget);
      expect(find.byKey(Key(descriptionKey)), findsOneWidget);
      expect(find.byKey(Key(makeUpdateKey)), findsOneWidget);
      await tester.enterText(find.byKey(Key(titleKey)), title);
      await tester.enterText(find.byKey(Key(descriptionKey)), description);

      await tester.tap(find.byKey(Key(makeUpdateKey)));
      await tester.pumpAndSettle();
    }

    testWidgets("1.home画面にてボタンを押して画面遷移することができるのか", (WidgetTester tester) async {
      await initScreen(tester);

      //
      expect(find.text("飲み物"), findsOneWidget);
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
      var random = math.Random().nextInt(6);

      await initScreen(tester);

      // 画面遷移
      await tester.tap(find.byIcon(categoryModel[random].iconData));
      await tester.pumpAndSettle();

      // 画面遷移元に戻る
      Navigator.of(tester.element(find.byType(Navigator))).pop();
      await tester.pumpAndSettle();

      // 元のページが表示されていることを検証する
      expect(find.text(categoryModel[random].title), findsOneWidget);
    });
    testWidgets("3. 画面遷移しカードを追加することができる", (WidgetTester tester) async {
      var random = math.Random().nextInt(6);
      await initScreen(tester);

      await tester.tap(find.byIcon(categoryModel[random].iconData));
      await tester.pumpAndSettle();

      // アイコンがあるか確認+押してモーダルを表示
      expect(find.byIcon(Icons.add), findsOneWidget);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      await addEditItem(
        tester: tester,
        title: "Hoge",
        description: "HogeHoge",
        titleKey: "adding_edit_modal_see",
        descriptionKey: "adding_edit_modal_speack",
        makeUpdateKey: "adding_edit_modal_make",
      );

      // Hogeを確認するため
      await tester.drag(find.byType(ListView), const Offset(0.0, -10000.0));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.text("Hoge"), findsOneWidget);
      await tester.tap(find.text("Hoge"));
    });
    testWidgets("4. 3.にて作成したHogeを用いて編集する", (WidgetTester tester) async {
      var random = math.Random().nextInt(6);

      await initScreen(tester);

      await tester.tap(find.byIcon(categoryModel[random].iconData));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await addEditItem(
        tester: tester,
        title: "Hoge",
        description: "HogeHoge",
        titleKey: "adding_edit_modal_see",
        descriptionKey: "adding_edit_modal_speack",
        makeUpdateKey: "adding_edit_modal_make",
      );

      // カードが有ると読み込まれない可能性があるため一番下にスクロール
      await tester.drag(find.byType(ListView), const Offset(0.0, -10000.0));
      await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.byIcon(Icons.edit).last, findsOneWidget);

      // 編集モーダルを開く
      await tester.tap(find.byIcon(Icons.edit).last);
      await tester.pumpAndSettle();

      await addEditItem(
        tester: tester,
        title: "title",
        description: "description",
        titleKey: "adding_edit_modal_see",
        descriptionKey: "adding_edit_modal_speack",
        makeUpdateKey: "adding_edit_modal_update",
      );
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.text("title"), findsOneWidget);
      await tester.tap(find.text("title"));
    });

    testWidgets("5. Fugaを削除する", (WidgetTester tester) async {
      var random = math.Random().nextInt(6);

      await initScreen(tester);
      await tester.tap(find.byIcon(categoryModel[random].iconData));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await addEditItem(
        tester: tester,
        title: "Fuga",
        description: "FugaFuga",
        titleKey: "adding_edit_modal_see",
        descriptionKey: "adding_edit_modal_speack",
        makeUpdateKey: "adding_edit_modal_make",
      );
      await tester.drag(find.byType(ListView), const Offset(0.0, -10000.0));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.byIcon(Icons.delete).last, findsOneWidget);
      expect(find.text("Fuga"), findsOneWidget);

      await tester.tap(find.byIcon(Icons.delete).last);
      await tester.pumpAndSettle();

      expect(find.text("削除しますか?"), findsOneWidget);
      expect(find.text("します"), findsOneWidget);
      expect(find.text("しません"), findsOneWidget);

      await tester.tap(find.text("しません"));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text("Fuga"), findsOneWidget);

      await tester.tap(find.byIcon(Icons.delete).last);
      await tester.pumpAndSettle();

      await tester.tap(find.text("します"));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expectSync(find.text("Fuga"), findsNothing);
    });

    testWidgets("6. イルカをカードに追加し､お気に入りに登録する｡その後､お気に入りページにいるかが存在しているか確認する",
        (WidgetTester tester) async {
      var random = math.Random().nextInt(6);

      await initScreen(tester);
      await tester.tap(find.byIcon(categoryModel[random].iconData));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await addEditItem(
        tester: tester,
        title: "イルカ",
        description: "イルカ",
        titleKey: "adding_edit_modal_see",
        descriptionKey: "adding_edit_modal_speack",
        makeUpdateKey: "adding_edit_modal_make",
      );
      await tester.drag(find.byType(ListView), const Offset(0.0, -10000.0));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.text("イルカ"), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border).last, findsOneWidget);

      await tester.tap(find.byIcon(Icons.favorite_border).last);
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.favorite_rounded).last, findsOneWidget);

      Navigator.of(tester.element(find.byType(Navigator))).pop();
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.favorite_border).last);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.text("イルカ"), findsOneWidget);
    });
    testWidgets("7. 入力画面に行きボタンを「おはよう」を入力して再生し削除する",
        (WidgetTester tester) async {
      await initScreen(tester);
      expect(find.byIcon(Icons.keyboard_alt_outlined), findsOneWidget);
      await tester.tap(find.byIcon(Icons.keyboard_alt_outlined));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
      expect(find.byIcon(Icons.delete), findsOneWidget);

      final List hello = ["お", "は", "よ", "う"];
      for (var i = 0; i < hello.length; i++) {
        expect(find.text(hello[i]), findsOneWidget);
        await tester.tap(find.text(hello[i]));
        await tester.pumpAndSettle(const Duration(seconds: 1));
      }

      await tester.tap(find.byIcon(Icons.play_arrow));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();
    });

    testWidgets("8. 健康画面に行きボタンを全て押す", (WidgetTester tester) async {
      await initScreen(tester);
      await tester.tap(find.byIcon(Icons.medical_services_outlined));
      await tester.pumpAndSettle();
      for (var element in healthConditionModel) {
        expect(find.text(element["label"]), findsOneWidget);
        await tester.tap(find.text(element["label"]));
        await tester.pump(const Duration(seconds: 1));
      }
    });
  });
}
