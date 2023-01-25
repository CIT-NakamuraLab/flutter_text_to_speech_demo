import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:text_to_speech_demo/screens/favorite_screen.dart';
import 'package:text_to_speech_demo/screens/tabs_screen.dart';

import './screens/home_screen.dart';
import './screens/health_condition_screen.dart';
import './screens/paint_screen.dart';
import 'screens/take_hand_screen.dart';
import './screens/title_screen.dart';
import 'screens/speech_to_text_screen.dart';
import 'screens/input_text_screen.dart';
import './screens/favorite_screen.dart';

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
        HealthConditionScreen.routeName: (context) =>
            const HealthConditionScreen(),
        // PaintScreen.routeName: (context) => const PaintScreen(),
        TakeHandScreen.routeName: (context) => const TakeHandScreen(),
        SpeechToTextScreen.routeName: (context) => const SpeechToTextScreen(),
        InputTextScreen.routeName: (context) => const InputTextScreen(),
        FavoriteScreen.routeName: (context) => const FavoriteScreen(),
      },
    );
  }
}
