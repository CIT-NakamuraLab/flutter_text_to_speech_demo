import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:text_to_speech_demo/screens/tabs_screen.dart';

import './screens/home_screen.dart';
import './screens/health_condition.dart';
import './screens/paint_screen.dart';
import './screens/take_hand.dart';
import './screens/title_screen.dart';
import './screens/speech_to_text.dart';
import './screens/input_text.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text To Speech Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.redAccent[100],
          secondary: Colors.greenAccent,
          background: Colors.greenAccent[100],
          error: Colors.red,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.amber,
        ),
      ),
      // home: const TitleScreen(),
      initialRoute: TabsScreen.routeName,
      routes: {
        TabsScreen.routeName: (context) => const TabsScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        HealthCondition.routeName: (context) => const HealthCondition(),
        PaintScreen.routeName: (context) => const PaintScreen(),
        TakeHand.routeName: (context) => const TakeHand(),
        SpeechToText.routeName: (context) => const SpeechToText(),
        InputText.routeName: (context) => const InputText(),
      },
    );
  }
}
