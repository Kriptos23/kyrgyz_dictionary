import 'package:flutter/material.dart';
import '../widgets/botttom_nav_bar_widget.dart';
import 'package:kyrgyz_dictionary/list_of_words.dart';

import 'daily_words_template_screen.dart';

class DailyWords extends StatefulWidget {
  const DailyWords({super.key});

  @override
  State<DailyWords> createState() => _DailyWordsState();
}

class _DailyWordsState extends State<DailyWords> {

  // BottomNavBar bottomNavBarWidget = BottomNavBar(1);
  int? counter1;

  int ifNullCounter(int count){
    return count;
    }

  int? test;
  late int counter2;
  late int counter3;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
      Scaffold(
        // bottomNavigationBar: bottomNavBarWidget.buildBottomNavBar(context, setState),//Bottom NavBar object that we created
        // ourselves
        body:
        Column(
          children: [
            InkWell(
              onTap: () async {
                   final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DailyWordsTemplateScreen(listOfWords: easyWords1, rightAnswersCounter: counter1 ?? 0),
                      // replace with your screen
                      // class
                    ),
                  );
                   if (result != null) {
                     setState(() {
                       counter1 = result; // store it in a variable in your first screen
                     });
                   }
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.green,
                child: Text("Level 1\n${counter1??0}/10"),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final counter = Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DailyWordsTemplateScreen(listOfWords: easyWords1, rightAnswersCounter: ifNullCounter
                      (counter2),
                    ), //
                    // replace with your
                    // screen
                    // class
                  ),
                );
              },
              child: const Text("Go to next screen"),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DailyWordsTemplateScreen(listOfWords: easyWords2, rightAnswersCounter: counter3,
                      //rightAnswersCounter: counter2,
                  ), //
                    // replace with your screen class
                  ),
                );
              },
              child: const Text("Go to next screen"),
            ),
            Text('$counter1', style: const TextStyle(fontSize: 20, color: Colors.red),),
          ],
        ),
      ),
    );
  }
}
