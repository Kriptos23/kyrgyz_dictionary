import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BottomNavBar{
  final int initialIndex;
  int _currentIndex;

  BottomNavBar(this.initialIndex) : _currentIndex = initialIndex;
  final List<String> _routes = ['/', '/sozdor'];
  void _onTabTapped(int index, BuildContext context, void Function(VoidCallback) updater) {
    if (index != _currentIndex) {
      updater((){
        _currentIndex = index;
      });
      Navigator.pushReplacementNamed(context, _routes[index]);
    }
  }

  Widget buildBottomNavBar(BuildContext context, void Function(VoidCallback) updater){
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap:(index) => _onTabTapped(index, context, updater),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "ИИ Переводчик"),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.chevron_up_square), label: "игра сөздөр"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "В разработке"),
      ],);
  }
}