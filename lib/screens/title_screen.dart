import 'package:flutter/material.dart';

import './home_screen.dart';

class TitleScreen extends StatefulWidget {
  const TitleScreen({super.key});

  @override
  State<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return HomeScreen();
          },
          transitionDuration: const Duration(seconds: 1),
          reverseTransitionDuration: const Duration(seconds: 1),
          transitionsBuilder: ((context, animation, secondaryAnimation, child) {
            final color = ColorTween(
              begin: Colors.transparent,
              end: Colors.black,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: const Interval(
                0.0,
                0.5,
                curve: Curves.easeInOut,
              ),
            ));
            final opacity = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: const Interval(
                0.5,
                1.0,
                curve: Curves.easeInOut,
              ),
            ));
            return AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Container(
                  color: color.value,
                  child: Opacity(
                    opacity: opacity.value,
                    child: child,
                  ),
                );
              },
              child: child,
            );
          }),
        ),
      ),
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
