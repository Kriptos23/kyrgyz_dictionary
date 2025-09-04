import 'package:flutter/material.dart';
import 'package:kyrgyz_dictionary/daily_words.dart';
import 'sozduk_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes:
      {
        '/':(context) => const SozdukScreen(),
        '/sozdor':(context) => const DailyWords(),
      },
    );
  }
}
