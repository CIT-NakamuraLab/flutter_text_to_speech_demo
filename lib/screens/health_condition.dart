import 'package:flutter/material.dart';

import '../widgets/generate_grid.dart';
import '../widgets/generate_caterory.dart';

class HealthCondition extends StatelessWidget {
  static const routeName = '/health-condition';
  const HealthCondition({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;

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
                        routeName: routeName,
                      ),
                      GenerateGrid(
                        labelText: 'かゆい',
                        speakText: 'かゆいです',
                        routeName: routeName,
                      ),
                      GenerateGrid(
                        labelText: 'めまい',
                        speakText: 'めまいがします',
                        routeName: routeName,
                      ),
                      GenerateGrid(
                        labelText: '不安',
                        speakText: '不安です',
                        routeName: routeName,
                      ),
                      GenerateGrid(
                        labelText: '吐き気',
                        speakText: '吐き気がします',
                        routeName: routeName,
                      ),
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
                        routeName: routeName,
                      ),
                      GenerateGrid(
                        labelText: '目が',
                        speakText: '目が',
                        routeName: routeName,
                      ),
                      GenerateGrid(
                        labelText: '耳が',
                        speakText: '耳が',
                        routeName: routeName,
                      ),
                      GenerateGrid(
                        labelText: '歯が',
                        speakText: '歯が',
                        routeName: routeName,
                      ),
                      GenerateGrid(
                        labelText: '肺が',
                        speakText: '肺が',
                        routeName: routeName,
                      ),
                      GenerateGrid(
                        labelText: '腹が',
                        speakText: '腹が',
                        routeName: routeName,
                      ),
                      GenerateGrid(
                        labelText: '腰が',
                        speakText: '腰が',
                        routeName: routeName,
                      ),
                      GenerateGrid(
                        labelText: '足が',
                        speakText: '足が',
                        routeName: routeName,
                      ),
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
                        routeName: routeName,
                      ),
                      GenerateGrid(
                        labelText: '薬を飲みたい',
                        speakText: '薬を飲みたいです',
                        routeName: routeName,
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
                        routeName: routeName,
                      ),
                      GenerateGrid(
                        labelText: '様子を見て',
                        speakText: '様子を見て',
                        routeName: routeName,
                      ),
                      GenerateGrid(
                        labelText: '明日',
                        speakText: '明日',
                        routeName: routeName,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
