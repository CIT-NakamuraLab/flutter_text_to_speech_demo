import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../widgets/bottom_tab.dart';
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
                  _generateCaterory('どうされましたか?', Icons.vaccines),
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 3 / 2,
                    ),
                    children: [
                      generateGrid('痛い', '痛いです'),
                      generateGrid('苦しい', '苦しいです'),
                      generateGrid('かゆい', 'かゆいです'),
                      generateGrid('めまい', 'めまいがします'),
                      generateGrid('不安', '不安です'),
                      generateGrid('吐き気', '吐き気がします'),
                    ],
                  ),
                  _generateCaterory('どこが?', Icons.where_to_vote),
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 3 / 2,
                    ),
                    children: [
                      generateGrid('頭が', '頭が'),
                      generateGrid('目が', '目が'),
                      generateGrid('耳が', '耳が'),
                      generateGrid('歯が', '歯が'),
                      generateGrid('肺が', '肺が'),
                      generateGrid('腹が', '腹が'),
                      generateGrid('腰が', '腰が'),
                      generateGrid('足が', '足が'),
                    ],
                  ),
                  _generateCaterory('どうしたい?', Icons.where_to_vote),
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 5 / 2,
                    ),
                    children: [
                      generateGrid('病院に行きたい', '病院に行きたいです'),
                      generateGrid('薬を飲みたい', '薬を飲みたいです'),
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
                    children: [
                      generateGrid('今すぐ', '今すぐ'),
                      generateGrid('様子を見て', '様子を見て'),
                      generateGrid('明日', '明日'),
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
