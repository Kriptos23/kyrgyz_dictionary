import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyrgyz_dictionary/Screens/quiz_on_words.dart';

import '../Screens/learning_words_template_screen.dart';
import '../classes/words_class.dart';
import '../list_of_words.dart';

class CircleButton extends StatelessWidget {
  final MainAxisAlignment alignment;
  String difficulty;
  String level;
  final List<Words> listOfWords;
  final int game;

  final uid = FirebaseAuth.instance.currentUser!.uid;

  CircleButton({super.key, required this.difficulty, required this.level, required this.listOfWords, required this.alignment,
    required this.game});

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
          onTap: () async {
            // 1️⃣ Show loading dialog
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
            );

            try {
              final imagePaths =
              listOfWords.map((word) => word.img!).toList();

              // 2️⃣ Preload images (parallel = faster)
              await Future.wait(
                imagePaths.map((path) async {
                  final ref = FirebaseStorage.instance.ref().child(path);
                  final url = await ref.getDownloadURL();
                  await precacheImage(NetworkImage(url), context);
                }),
              );

              if (!context.mounted) return;

              // 3️⃣ Close loading dialog
              Navigator.of(context).pop();

              // 4️⃣ Navigate
              switch(game){
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LearningWordsTemplateScreen(
                        listOfWords: listOfWords,
                        difficulty: difficulty,
                        level: level,
                        uid: uid,
                      ),
                    ),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuizOnWords(
                        listOfWords: listOfWords,
                        // difficulty: difficulty,
                        // level: level,
                        // uid: uid,
                      ),
                    ),
                  );
                  break;
              }

            } catch (e) {
              Navigator.of(context).pop(); // ensure dialog closes
              debugPrint('Image preload error: $e');
            }
          },

        ),
      ],
    );
  }
}