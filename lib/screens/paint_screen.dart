import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_to_speech_demo/providers/paint_provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:whiteboardkit/drawing_controller.dart';
import 'package:whiteboardkit/whiteboard.dart';
import 'package:whiteboardkit/whiteboard_style.dart';

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

    Widget generateSelectColor(String colorText, Color colorData) {
      return GestureDetector(
        onTap: () {},
        child: Container(
          height: deviceWidth * 0.1,
          width: deviceWidth * 0.1,
          color: colorData,
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  colorText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

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
        child: Column(
          children: [
            Expanded(
              child: Whiteboard(
                controller: controller,
                style: const WhiteboardStyle(
                  toolboxColor: Colors.amber,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
