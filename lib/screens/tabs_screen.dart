import 'package:flutter/material.dart';
import 'package:text_to_speech_demo/screens/favorite_screen.dart';
import 'package:text_to_speech_demo/screens/home_screen.dart';
import 'package:text_to_speech_demo/screens/selected_category.dart';
import 'health_condition_screen.dart';
import './input_text.dart';
import './take_hand.dart';
import '../widgets/text_to_speech.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = "/tabsScreen";

  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;

  void _onTapScreen(int index) {
    setState(
      () {
        _selectedIndex = index;
        TextToSpeech.speak(
          "${_screenInfo[_selectedIndex]}画面に移動しました",
        );
      },
    );
  }

  final _screenNo = <Widget>[
    const HomeScreen(),
    const HealthConditionScreen(),
    const FavoriteScreen(),
    const InputText(),
  ];
  final _screenInfo = ["ホーム", "健康状態", "お気に入り", "入力"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        // List<Map<String, dynamic>> =>List<Widget> asにて変換　cast error
        screens: _screenNo,
        // screens: _screenInfo[_selectedIndex]["screen"],
        onItemSelected: (index) {
          _onTapScreen(index);
        },
        items: [
          PersistentBottomNavBarItem(
            inactiveIcon: const Icon(
              Icons.home_outlined,
            ),
            iconSize: 30,
            activeColorPrimary: Colors.white,
            icon: const Icon(Icons.home_rounded),
          ),
          PersistentBottomNavBarItem(
            inactiveIcon: const Icon(Icons.medical_services_outlined),
            icon: const Icon(Icons.medical_services_rounded),
            activeColorPrimary: Colors.white,
            iconSize: 30,
          ),
          PersistentBottomNavBarItem(
            inactiveIcon: const Icon(Icons.star_outline_outlined),
            icon: const Icon(Icons.star),
            iconSize: 30,
            activeColorPrimary: Colors.white,
          ),
          PersistentBottomNavBarItem(
            inactiveIcon: const Icon(Icons.keyboard_alt_outlined),
            icon: const Icon(Icons.keyboard_alt_rounded),
            iconSize: 30,
            activeColorPrimary: Colors.white,
          ),
        ],
        navBarStyle: NavBarStyle.style6,
        backgroundColor: Theme.of(context).colorScheme.primary,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
      ),
    );
  }
}
