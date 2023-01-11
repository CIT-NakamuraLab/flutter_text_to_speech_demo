import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:whiteboardkit/drawing_controller.dart';
import 'package:whiteboardkit/whiteboard.dart';
import 'package:whiteboardkit/whiteboard_style.dart';

import '../widgets/bottom_tab.dart';
import './health_condition.dart';
import './take_hand.dart';
import './home_screen.dart';
import './speech_to_text.dart';

class PaintScreen extends StatefulWidget {
  static const routeName = '/paint-screen';
  const PaintScreen({super.key});

  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  late DrawingController controller;

  @override
  void initState() {
    // TODO
    controller = DrawingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '手で書いてください',
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
              Icons.draw,
            ),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: deviceHeight * 0.7,
                width: deviceWidth,
                child: Whiteboard(
                  controller: controller,
                  style: const WhiteboardStyle(
                    toolboxColor: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.87 - deviceHeight * 0.7,
              ),
              Container(
                height: deviceHeight * 0.13,
                color: Theme.of(context).colorScheme.primary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BottomTab(
                      transitionFunction: () => Navigator.of(context)
                          .pushNamed(HealthCondition.routeName),
                      labelText: '健康状態',
                      icon: Icons.medical_services,
                    ),
                    BottomTab(
                      transitionFunction: () =>
                          Navigator.of(context).pushNamed(TakeHand.routeName),
                      labelText: '取って',
                      icon: Icons.back_hand,
                    ),
                    BottomTab(
                      transitionFunction: () => Navigator.of(context)
                          .pushNamed(SpeechToText.routeName),
                      labelText: '音声認識',
                      icon: Icons.volume_up,
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
        ),
      ),
    );
  }
}
