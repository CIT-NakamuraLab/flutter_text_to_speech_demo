import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';
  final FlutterTts flutterTts = FlutterTts();

  HomeScreen({super.key});

  Future<void> _speak(String speakText) async {
    await flutterTts.setLanguage('ja-JP');
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(speakText);
  }

  Widget _generateList(
    BuildContext context,
    String titleText,
    IconData icon,
    String speakText,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        left: 15,
        right: 15,
        bottom: 7.5,
      ),
      child: ListTile(
        tileColor: Theme.of(context).colorScheme.secondary,
        leading: Icon(
          icon,
          size: 35,
          color: Colors.white,
        ),
        title: Text(
          titleText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 24,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 35,
              width: 35,
              child: IconButton(
                onPressed: () {
                  _speak(speakText);
                },
                icon: const Icon(Icons.volume_up),
              ),
            ),
            const Text(
              'Click',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            )
          ],
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.blue,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: deviceHeight * 0.18,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(
            height: deviceHeight * 0.7,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _generateList(context, 'ありがとう',
                      Icons.sentiment_very_satisfied_outlined, 'ありがとうございます'),
                  _generateList(context, 'すいません', Icons.boy, 'すいません'),
                  _generateList(
                      context, 'のどが渇いた', Icons.free_breakfast, '喉が渇きました'),
                  _generateList(
                      context, 'エアコン', Icons.wind_power, 'エアコンを操作してください'),
                  _generateList(context, 'トイレ', Icons.wc, 'トイレに行きたいです'),
                  _generateList(context, '取ってください', Icons.back_hand, '取ってください'),
                  _generateList(context, '具合が悪い',
                      Icons.sentiment_very_dissatisfied_outlined, '具合が悪いです'),
                ],
              ),
            ),
          ),
          Container(
            height: deviceHeight * 0.12,
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: Container(
                        width: 85,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.medical_services,
                              color: Colors.white,
                            ),
                            Text(
                              '健康状態',
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
                        width: 85,
                        height: 60,
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
                        width: 85,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.draw,
                              color: Colors.white,
                            ),
                            Text(
                              'メモ',
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
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Theme.of(context).colorScheme.primary,
      //   selectedItemColor: Theme.of(context).colorScheme.secondary,
      //   unselectedItemColor: Colors.white,
      //   type: BottomNavigationBarType.fixed,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.medical_services),
      //       label: 'ホーム',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.abc),
      //       label: '健康状態',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.medical_services),
      //       label: '取って',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.abc),
      //       label: 'LE',
      //     ),
      //   ],
      // ),
    );
  }
}
