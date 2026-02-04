import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Screens/learning_words_template_screen.dart';
import '../classes/words_class.dart';
import '../list_of_words.dart';

class CircleButton extends StatelessWidget {
  final MainAxisAlignment alignment;
  String difficulty;
  String level;
  final List<Words> listOfWords;

  final uid = FirebaseAuth.instance.currentUser!.uid;

  CircleButton({super.key, required this.difficulty, required this.level, required this.listOfWords, required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        InkWell(
          child: Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                level,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => LearningWordsTemplateScreen(listOfWords: listOfWords,
              difficulty: difficulty, level: level, uid: uid,)));
          },
        ),
      ],
    );
  }
}