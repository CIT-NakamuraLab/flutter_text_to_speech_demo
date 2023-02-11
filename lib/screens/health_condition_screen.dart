import 'package:flutter/material.dart';
import 'package:text_to_speech_demo/models/health_condition_model.dart';
import '../widgets/top_bar.dart';
import '../widgets/shake.dart';
import '../widgets/generate_caterory.dart';

class HealthConditionScreen extends StatefulWidget {
  static const routeName = '/health-condition';
  const HealthConditionScreen({super.key});

  @override
  State<HealthConditionScreen> createState() => _HealthConditionScreenState();
}

class _HealthConditionScreenState extends State<HealthConditionScreen> {
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

  List<Widget> method(String keyword) {
    List<Widget> out = [];

    for (var element in healthConditionModel) {
      if (element["keyword"] == keyword) {
        out.add(element["output"]);
      }
    }
    return out;
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
                      routeName: HealthConditionScreen.routeName,
                    ),
                    GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 3 / 2,
                      ),
                      children: method("condition"),
                    ),
                    const GenerateCaterory(
                      text: 'どこが?',
                      icon: Icons.where_to_vote,
                      routeName: HealthConditionScreen.routeName,
                    ),
                    GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 3 / 2,
                      ),
                      children: method("bodySite"),
                    ),
                    const GenerateCaterory(
                      text: 'どうしたい?',
                      icon: Icons.where_to_vote,
                      routeName: HealthConditionScreen.routeName,
                    ),
                    GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 5 / 2,
                      ),
                      children: method("howHarf"),
                    ),
                    GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 3 / 2,
                      ),
                      children: method("howThreePart"),
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
