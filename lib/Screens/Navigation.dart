import 'package:flutter/material.dart';
import 'package:kyrgyz_dictionary/Screens/Authenticate/my_profile.dart';
import 'package:kyrgyz_dictionary/Screens/Fun%20Box/fun_box.dart';
import 'package:kyrgyz_dictionary/Screens/daily_words_screen.dart';
import 'package:kyrgyz_dictionary/Screens/sozduk_screen.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    SozdukScreen(),
    DailyWords(),
    FunBox(),
    MyProfile(),
  ];

  void _onTabTapped(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.amber,
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.blueGrey,
        selectedItemColor: Colors.blue,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "ИИ Переводчик"),
          BottomNavigationBarItem(icon: Icon(Icons.book_online), label: "Окуу"),
          BottomNavigationBarItem(icon: Icon(Icons.videogame_asset), label: "FunBox"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Профиль"),
        ],
      ),
    );
  }
}
