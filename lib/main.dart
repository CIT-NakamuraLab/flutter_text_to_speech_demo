import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../screens/home_screen.dart';
import '../screens/tabs_screen.dart';
import './screens/health_condition_screen.dart';
import './screens/title_screen.dart';
import './screens/input_text.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text To Speech Demo',
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.redAccent[100],
          onPrimary: Colors.grey[850],
          inversePrimary: Colors.white,
          secondary: Colors.greenAccent,
          onSecondary: Colors.green[300],
          background: const Color.fromARGB(255, 252, 239, 217),
          error: Colors.red,
        ),
      ),
      home: const TitleScreen(),
      routes: {
        TabsScreen.routeName: (context) => const TabsScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        HealthConditionScreen.routeName: (context) =>
            const HealthConditionScreen(),
        InputText.routeName: (context) => const InputText(),
      },
    );
  }
}
