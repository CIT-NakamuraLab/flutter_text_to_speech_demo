import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './providers/paint_provider.dart';
import './models/home_model.dart';
import './screens/home_screen.dart';
import './screens/health_condition.dart';
import './screens/paint_screen.dart';
import './screens/take_hand.dart';
import './screens/title_screen.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PaintProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeModel(),
        )
      ],
      child: MaterialApp(
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
          home: const TitleScreen(),
          routes: {
            HomeScreen.routeName: (context) => HomeScreen(),
            HealthCondition.routeName: (context) => const HealthCondition(),
            PaintScreen.routeName: (context) => const PaintScreen(),
            TakeHand.routeName: (context) => const TakeHand(),
          }),
    );
  }
}
