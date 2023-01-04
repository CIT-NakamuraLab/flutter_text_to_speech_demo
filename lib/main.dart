import 'package:flutter/material.dart';

import './screens/home_screen.dart';
import './screens/health_condition.dart';

void main() {
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
        home: const MyHomePage(),
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          HealthCondition.routeName: (context) => const HealthCondition(),
        });
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
