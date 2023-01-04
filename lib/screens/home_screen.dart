import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import './health_condition.dart';

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
      child: GestureDetector(
        onTap: () {
          _speak(speakText);
        },
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
            children: const [
              Icon(
                Icons.volume_up,
                color: Colors.white,
              ),
              Text(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: Form(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'お名前入力',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
              ),
            ),
            const Text(
              'さん来てください',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Column(
              children: [
                const Icon(
                  Icons.screen_rotation,
                  color: Colors.black,
                ),
                Text(
                  'スマホを振ってください',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.redAccent[700],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: deviceHeight * 0.87,
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
            height: deviceHeight * 0.13,
            color: Theme.of(context).colorScheme.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .pushNamed(HealthCondition.routeName),
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
          ),
        ],
      ),
    );
  }
}
