import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './providers/paint_provider.dart';
import './screens/home_screen.dart';
import './screens/health_condition.dart';
import './screens/paint_screen.dart';
import './screens/take_hand.dart';

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
          home: const MyHomePage(),
          routes: {
            HomeScreen.routeName: (context) => HomeScreen(),
            HealthCondition.routeName: (context) => const HealthCondition(),
            PaintScreen.routeName: (context) => const PaintScreen(),
            TakeHand.routeName: (context) => const TakeHand(),
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                '伝えたい気持ちをサポートする',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '音声会話補助アプリ',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'comecome',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
