import 'package:flutter/material.dart';
import 'package:text_to_speech_demo/widgets/output_list.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});
  static const routeName = "/favorite-screen";

  @override
  Widget build(BuildContext context) {
    return OutputList();
  }
}
