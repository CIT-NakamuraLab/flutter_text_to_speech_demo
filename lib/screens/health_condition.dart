import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HealthCondition extends StatelessWidget {
  static const routeName = '/health-condition';
  const HealthCondition({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    // MediaQuery.of(context).padding.bottom;
    // final deviceHeight =
    // MediaQuery.of(context).size.height - AppBar().preferredSize.height;

    final FlutterTts flutterTts = FlutterTts();

    Future<void> _speak(String speakText) async {
      await flutterTts.setLanguage('ja-JP');
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.setVolume(1.0);
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(speakText);
    }

    Widget _generateGrid(String text, String speakText) {
      return GestureDetector(
        onTap: () {
          _speak(speakText);
        },
        child: Card(
          elevation: 3,
          shape: const RoundedRectangleBorder(
            side: BorderSide(
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
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 3 / 2,
                      ),
                      children: [
                        _generateGrid('痛い', '痛いです'),
                        _generateGrid('苦しい', '苦しいです'),
                        _generateGrid('かゆい', 'かゆいです'),
                        _generateGrid('めまい', 'めまいがします'),
                        _generateGrid('不安', '不安です'),
                        _generateGrid('吐き気', '吐き気がします'),
                      ],
                    ),
                  ),
                  _generateCaterory('どこが?', Icons.where_to_vote),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 3 / 2,
                      ),
                      children: [
                        _generateGrid('頭が', '頭が'),
                        _generateGrid('目が', '目が'),
                        _generateGrid('耳が', '耳が'),
                        _generateGrid('歯が', '歯が'),
                        _generateGrid('肺が', '肺が'),
                        _generateGrid('腹が', '腹が'),
                        _generateGrid('腰が', '腰が'),
                        _generateGrid('足が', '足が'),
                      ],
                    ),
                  ),
                  _generateCaterory('どうしたい?', Icons.where_to_vote),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 5 / 2,
                      ),
                      children: [
                        _generateGrid('病院に行きたい', '病院に行きたいです'),
                        _generateGrid('薬を飲みたい', '薬を飲みたいです'),
                      ],
                    ),
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
                      _generateGrid('今すぐ', '今すぐ'),
                      _generateGrid('様子を見て', '様子を見て'),
                      _generateGrid('明日', '明日'),
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
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: deviceHeight * 0.12,
                    height: deviceHeight * 0.08,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.undo,
                          color: Colors.white,
                        ),
                        Text(
                          '戻る',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    width: deviceHeight * 0.12,
                    height: deviceHeight * 0.08,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.back_hand,
                          color: Colors.white,
                        ),
                        Text(
                          '取って',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    width: deviceHeight * 0.12,
                    height: deviceHeight * 0.08,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        Text(
                          'Top',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
