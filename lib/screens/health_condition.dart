import 'package:flutter/material.dart';
import '../widgets/top_Bar.dart';
import '../widgets/generate_grid.dart';
import '../widgets/generate_caterory.dart';
import '../widgets/shake.dart';

class HealthCondition extends StatefulWidget {
  static const routeName = '/health-condition';
  const HealthCondition({super.key});

  @override
  State<HealthCondition> createState() => _HealthConditionState();
}

class _HealthConditionState extends State<HealthCondition> {
  @override
  void initState() {
    super.initState();
    Shake.detector.startListening();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Shake.detector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const TopBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: deviceHeight * 0.87,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const GenerateCaterory(
                      text: 'どうされましたか?',
                      icon: Icons.vaccines,
                      routeName: HealthCondition.routeName,
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
                          routeName: HealthCondition.routeName,
                        ),
                        GenerateGrid(
                          labelText: '苦しい',
                          speakText: '苦しいです',
                          routeName: HealthCondition.routeName,
                        ),
                        GenerateGrid(
                          labelText: 'かゆい',
                          speakText: 'かゆいです',
                          routeName: HealthCondition.routeName,
                        ),
                        GenerateGrid(
                          labelText: 'めまい',
                          speakText: 'めまいがします',
                          routeName: HealthCondition.routeName,
                        ),
                        GenerateGrid(
                          labelText: '不安',
                          speakText: '不安です',
                          routeName: HealthCondition.routeName,
                        ),
                        GenerateGrid(
                          labelText: '吐き気',
                          speakText: '吐き気がします',
                          routeName: HealthCondition.routeName,
                        ),
                      ],
                    ),
                    const GenerateCaterory(
                      text: 'どこが?',
                      icon: Icons.where_to_vote,
                      routeName: HealthCondition.routeName,
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
                          routeName: HealthCondition.routeName,
                        ),
                        GenerateGrid(
                          labelText: '目が',
                          speakText: '目が',
                          routeName: HealthCondition.routeName,
                        ),
                        GenerateGrid(
                          labelText: '耳が',
                          speakText: '耳が',
                          routeName: HealthCondition.routeName,
                        ),
                        GenerateGrid(
                          labelText: '歯が',
                          speakText: '歯が',
                          routeName: HealthCondition.routeName,
                        ),
                        GenerateGrid(
                          labelText: '肺が',
                          speakText: '肺が',
                          routeName: HealthCondition.routeName,
                        ),
                        GenerateGrid(
                          labelText: '腹が',
                          speakText: '腹が',
                          routeName: HealthCondition.routeName,
                        ),
                        GenerateGrid(
                          labelText: '腰が',
                          speakText: '腰が',
                          routeName: HealthCondition.routeName,
                        ),
                        GenerateGrid(
                          labelText: '足が',
                          speakText: '足が',
                          routeName: HealthCondition.routeName,
                        ),
                      ],
                    ),
                    const GenerateCaterory(
                      text: 'どうしたい?',
                      icon: Icons.where_to_vote,
                      routeName: HealthCondition.routeName,
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
                          routeName: HealthCondition.routeName,
                        ),
                        GenerateGrid(
                          labelText: '薬を飲みたい',
                          speakText: '薬を飲みたいです',
                          routeName: HealthCondition.routeName,
                        ),
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
                          routeName: HealthCondition.routeName,
                        ),
                        GenerateGrid(
                          labelText: '様子を見て',
                          speakText: '様子を見て',
                          routeName: HealthCondition.routeName,
                        ),
                        GenerateGrid(
                          labelText: '明日',
                          speakText: '明日',
                          routeName: HealthCondition.routeName,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
