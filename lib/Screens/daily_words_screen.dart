import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth.dart';
import '../services/firestore_cloud_database.dart';
import '../widgets/botttom_nav_bar_widget.dart';
import 'package:kyrgyz_dictionary/list_of_words.dart';

import 'daily_words_template_screen.dart';

class DailyWords extends StatefulWidget {
  const DailyWords({super.key});

  @override
  State<DailyWords> createState() => _DailyWordsState();
}

class _DailyWordsState extends State<DailyWords> {
  late final DatabaseService databaseService;

  @override
  void initState(){
    super.initState();
    databaseService = DatabaseService(uid: uid);// initialize database service using late because we can not initialize
    _loadRightAnswersCounter('easy', 'level1',);
  }

  Future<void> _loadRightAnswersCounter(String difficulty, String level) async {
    final value = await databaseService.getLevelCounter(difficulty, level);
    setState(() {
      counterEasy1 = value;
    });
  }

  // BottomNavBar bottomNavBarWidget = BottomNavBar(1);
  AuthService _auth = AuthService();//auth obj from our self-made class to use sign-in functions
  final uid = FirebaseAuth.instance.currentUser!.uid;
  late int counterEasy1;

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
                      builder: (context) => DailyWordsTemplateScreen(listOfWords: easyWords1, difficulty: 'easy', level: 'level'
                          '1', uid: uid,
                      ),
                      // replace with your screen
                      // class
                    ),
                  );
                   if (result != null) {
                     setState(() async {
                       // counterEasy1 = await databaseService.getLevelCounter('easy', 'level1'); // store it in a variable in your first
                       // screen'
                       _loadRightAnswersCounter('easy', 'level1');
                     });
                   }
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.green,
                child: Text("Level 1\n${counterEasy1??0}/10"),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final counter = Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DailyWordsTemplateScreen(listOfWords: easyWords1, difficulty: 'easy', level: 'level'
                        '1', uid: uid,) //
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
                    builder: (context) => DailyWordsTemplateScreen(listOfWords: easyWords1, difficulty: 'easy', level: 'level'
                        '1', uid: uid,) //
                    // replace with your screen class
                  ),
                );
              },
              child: const Text("Go to next screen"),
            ),
            Text('$counterEasy1', style: const TextStyle(fontSize: 20, color: Colors.red),),
          ],
        ),
      ),
    );
  }
}
