import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/botttom_nav_bar_widget.dart';
import 'package:kyrgyz_dictionary/list_of_words.dart';
import 'package:kyrgyz_dictionary/widgets/flip_cards_widget.dart';

import 'daily_words_template_screen.dart';

class DailyWords extends StatefulWidget {
  const DailyWords({super.key});

  @override
  State<DailyWords> createState() => _DailyWordsState();
}

class _DailyWordsState extends State<DailyWords> {
  BottomNavBar bottomNavBarWidget = BottomNavBar(1);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: bottomNavBarWidget.buildBottomNavBar(context, setState),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DailyWordsTemplateScreen(listOfWords: easyWords1,), // replace with your screen class
                  ),
                );
              },
              child: Text("Go to next screen"),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DailyWordsTemplateScreen(listOfWords: easyWords2,), // replace with your screen class
                  ),
                );
              },
              child: Text("Go to next screen"),
            ),

          ],
        ),
      ),
    );
  }
}
