import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../widgets/bottom_tab.dart';
import '../widgets/generate_Grid.dart';
import '../widgets/generate_Caterory.dart';
import './take_hand.dart';
import './home_screen.dart';

class HealthCondition extends StatelessWidget {
  static const routeName = '/health-condition';
  const HealthCondition({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;

    final FlutterTts flutterTts = FlutterTts();

    Future<void> speak(String speakText) async {
      await flutterTts.setLanguage('ja-JP');
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.setVolume(1.0);
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(speakText);
    }

    Widget generateGrid(String text, String speakText) {
      return GestureDetector(
        onTap: () {
          speak(speakText);
        },
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
              color: Colors.red,
              width: 5,
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    Widget _generateCaterory(String text, IconData icon) {
      return Container(
        width: double.infinity,
        height: deviceHeight * 0.07,
        color: Colors.green[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.help,
              size: 36,
              color: Colors.white,
            ),
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Icon(
              icon,
              size: 36,
              color: Colors.white,
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '健康状態',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: deviceHeight * 0.87,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const GenerateCaterory(
                    text: 'どうされましたか?',
                    icon: Icons.vaccines,
                    routeName: routeName,
                  ),
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 3 / 2,
                    ),
                    children: const [
                      GenerateGrid(
                        labelText: '痛い',
                        speakText: '痛いです',
                        routeName: routeName,
                      ),
                      GenerateGrid(
                          labelText: '苦しい',
                          speakText: '苦しいです',
                          routeName: routeName),
                      GenerateGrid(
                          labelText: 'かゆい',
                          speakText: 'かゆいです',
                          routeName: routeName),
                      GenerateGrid(
                          labelText: 'めまい',
                          speakText: 'めまいがします',
                          routeName: routeName),
                      GenerateGrid(
                          labelText: '不安',
                          speakText: '不安です',
                          routeName: routeName),
                      GenerateGrid(
                          labelText: '吐き気',
                          speakText: '吐き気がします',
                          routeName: routeName),
                    ],
                  ),
                  const GenerateCaterory(
                    text: 'どこが?',
                    icon: Icons.where_to_vote,
                    routeName: routeName,
                  ),
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 3 / 2,
                    ),
                    children: const [
                      GenerateGrid(
                          labelText: '頭が',
                          speakText: '頭が',
                          routeName: routeName),
                      GenerateGrid(
                          labelText: '目が',
                          speakText: '目が',
                          routeName: routeName),
                      GenerateGrid(
                          labelText: '耳が',
                          speakText: '耳が',
                          routeName: routeName),
                      GenerateGrid(
                          labelText: '歯が',
                          speakText: '歯が',
                          routeName: routeName),
                      GenerateGrid(
                          labelText: '肺が',
                          speakText: '肺が',
                          routeName: routeName),
                      GenerateGrid(
                          labelText: '腹が',
                          speakText: '腹が',
                          routeName: routeName),
                      GenerateGrid(
                          labelText: '腰が',
                          speakText: '腰が',
                          routeName: routeName),
                      GenerateGrid(
                          labelText: '足が',
                          speakText: '足が',
                          routeName: routeName),
                    ],
                  ),
                  const GenerateCaterory(
                    text: 'どうしたい?',
                    icon: Icons.where_to_vote,
                    routeName: routeName,
                  ),
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 5 / 2,
                    ),
                    children: const [
                      GenerateGrid(
                          labelText: '病院に行きたい',
                          speakText: '病院に行きたいです',
                          routeName: routeName),
                      GenerateGrid(
                          labelText: '薬を飲みたい',
                          speakText: '薬を飲みたいです',
                          routeName: routeName),
                    ],
                  ),
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 3 / 2,
                    ),
                    children: const [
                      GenerateGrid(
                          labelText: '今すぐ',
                          speakText: '今すぐ',
                          routeName: routeName),
                      GenerateGrid(
                          labelText: '様子を見て',
                          speakText: '様子を見て',
                          routeName: routeName),
                      GenerateGrid(
                          labelText: '明日',
                          speakText: '明日',
                          routeName: routeName),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Theme.of(context).colorScheme.primary,
            height: deviceHeight * 0.13,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BottomTab(
                  transitionFunction: () => Navigator.of(context).pop(),
                  labelText: '戻る',
                  icon: Icons.undo,
                ),
                BottomTab(
                  transitionFunction: () =>
                      Navigator.of(context).pushNamed(TakeHand.routeName),
                  labelText: '取って',
                  icon: Icons.back_hand,
                ),
                BottomTab(
                  transitionFunction: () => Navigator.of(context)
                      .pushNamedAndRemoveUntil(
                          HomeScreen.routeName, (_) => false),
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
