import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../widgets/bottom_tab.dart';
import '../screens/health_condition.dart';
import '../screens/home_screen.dart';
import '../screens/paint_screen.dart';
import '../widgets/generate_Grid.dart';

class TakeHand extends StatelessWidget {
  static const routeName = '/take-hand';
  const TakeHand({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    final deviceWidth = MediaQuery.of(context).size.width;

    final FlutterTts flutterTts = FlutterTts();

    Future<void> speak(String speakText) async {
      await flutterTts.setLanguage('ja-JP');
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.setVolume(1.0);
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(speakText);
    }

    Widget generateGrid(String labelText, String speakText) {
      return GestureDetector(
        onTap: () {
          speak(speakText);
        },
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Colors.blue.shade700,
              width: 5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Icon(
                    Icons.back_hand,
                    color: Colors.blue.shade700,
                  ),
                ),
                Text(
                  labelText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Icon(
                    Icons.volume_up,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '取って欲しいもの',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(
              right: 10,
            ),
            child: Icon(
              Icons.back_hand,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: deviceHeight * 0.87,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 5 / 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    children: const [
                      GenerateGrid(
                          labelText: '紙とペン',
                          speakText: '紙とペンを取ってください',
                          routeName: routeName),
                      GenerateGrid(
                          labelText: 'つえ',
                          speakText: 'つえを取ってください',
                          routeName: routeName),
                      GenerateGrid(
                          labelText: 'めがね',
                          speakText: 'めがねを取ってください',
                          routeName: routeName),
                      GenerateGrid(
                          labelText: '新聞',
                          speakText: '新聞を取ってください',
                          routeName: routeName),
                      GenerateGrid(
                          labelText: '薬',
                          speakText: '薬を取ってください',
                          routeName: routeName),
                      GenerateGrid(
                          labelText: 'リモコン',
                          speakText: 'リモコンを取ってください',
                          routeName: routeName),
                      GenerateGrid(
                          labelText: 'ティッシュ',
                          speakText: 'ティッシュを取ってください',
                          routeName: routeName),
                      GenerateGrid(
                          labelText: 'タオル',
                          speakText: 'タオルを取ってください',
                          routeName: routeName),
                      GenerateGrid(
                          labelText: 'マスク',
                          speakText: 'マスクを取ってください',
                          routeName: routeName),
                      GenerateGrid(
                          labelText: '財布',
                          speakText: '財布を取ってください',
                          routeName: routeName),
                      GenerateGrid(
                          labelText: '靴下',
                          speakText: '靴下を取ってください',
                          routeName: routeName),
                      GenerateGrid(
                          labelText: '上着',
                          speakText: '上着を取ってください',
                          routeName: routeName),
                    ],
                  ),
                  SizedBox(
                    height: deviceHeight * 0.08,
                    width: deviceWidth * 0.7,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushNamed(PaintScreen.routeName),
                      child: ListTile(
                        leading: const Icon(
                          Icons.arrow_circle_right,
                          color: Colors.white,
                          size: 30,
                        ),
                        title: const Text(
                          '手書きする',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.draw,
                          color: Colors.white,
                          size: 30,
                        ),
                        tileColor: Colors.blue.shade300,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: deviceHeight * 0.13,
            color: Theme.of(context).colorScheme.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BottomTab(
                  transitionFunction: () => Navigator.of(context).pop(),
                  labelText: '戻る',
                  icon: Icons.undo,
                ),
                BottomTab(
                  transitionFunction: () => Navigator.of(context)
                      .pushNamed(HealthCondition.routeName),
                  labelText: '健康状態',
                  icon: Icons.medical_services,
                ),
                BottomTab(
                  transitionFunction: () => Navigator.of(context)
                      .pushNamedAndRemoveUntil(
                          HomeScreen.routeName, (route) => false),
                  labelText: 'Top',
                  icon: Icons.home,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
