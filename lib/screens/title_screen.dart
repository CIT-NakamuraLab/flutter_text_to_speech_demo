import 'package:flutter/material.dart';
import '../screens/tabs_screen.dart';

class TitleScreen extends StatefulWidget {
  const TitleScreen({super.key});

  @override
  State<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen> {
  Future<void> pageTransition() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const TabsScreen();
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
    );
  }

  @override
  void initState() {
    super.initState();
    pageTransition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 229, 137, 127),
      body: Center(
        child: Image.asset("assets/images/app/talk_support_icon.png"),
      ),
    );
  }
}
