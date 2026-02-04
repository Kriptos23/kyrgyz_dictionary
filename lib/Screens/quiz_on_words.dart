import 'dart:math';
import 'package:flutter/material.dart';

import '../classes/firebase_image.dart';
import '../classes/quiz_question.dart';
import '../classes/words_class.dart';
import '../services/firestore_cloud_database.dart';

class QuizOnWords extends StatefulWidget {
  final List<Words> listOfWords;

  const QuizOnWords({
    super.key,
    required this.listOfWords,
  });

  @override
  State<QuizOnWords> createState() => _QuizOnWordsState();
}

class _QuizOnWordsState extends State<QuizOnWords> {
  late List<FirebaseImage> images;//List of images which include name and url of images, not actual images
  late List<QuizQuestion> questions;//We are gonna created questions based on listOfWords
  int currentIndex = 0;//This we use to iterate through questions

  bool isLoading = true;//show Circular Loading widget if false

  @override
  void initState() {
    super.initState();
    _load();
  }

  // 🔹 ОДНА загрузка
  Future<void> _load() async {//loads our list of FirebaseImages
    final images = await getUrl(widget.listOfWords);//This function returns list of FirebaseImages based on given ListOfWords

    questions = buildQuestions(images);//Based of images we build Questions
    currentIndex = 0;//just to update and start from zero

    setState(() {
      isLoading = false;//since we got our image urls we set to false
    });
  }

  List<QuizQuestion> buildQuestions(List<FirebaseImage> images) {//This function takes list of FirebaseImages and transforms
    // them into List of QuizQuestions, which consist of answer and list of options
    images.shuffle(); // 🔥 ОДИН раз
    ///Ask why we shuffle here

    return images.map((correct) {//here we map our images list to create a QuizQuestion list
      final wrong = images
          .where((img) => img.name != correct.name)
          .toList()
        ..shuffle();//List of shuffled FirebaseImages wrong options for the QuizQuestion

      final options = [
        correct,
        ...wrong.take(3),
      ]..shuffle();//We add correct answer FirebaseImage to the three wrong answers

      return QuizQuestion(
        correctName: prettyName(correct.name),//prettyName is a function which takes raw name(ex: snow_leopard.png) and
        // transforms it into nice looking one
        ///I am not sure how exactly am I gonna implement localization here
        options: options,
      );//We return a single QuizQuestion with correct name(answer) and three wrong answers, since we are mapping, it will
      // iterate through the list and give us a new list
    }).toList();//convert to List after mapping
  }

  QuizQuestion get currentQuestion => questions[currentIndex];//Returns a current QuizQuestion

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());//shows up only at the beginning(I believe)
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 🔹 Слово Word which we are gonna use as the
        Text(
          "Найди Слово: ${currentQuestion.correctName}",
          style: const TextStyle(fontSize: 28, color: Colors.white),
        ),

        GridView.builder(
          shrinkWrap: true,
          itemCount: currentQuestion.options.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            final img = currentQuestion.options[index];

            return GestureDetector(
              onTap: () => _checkAnswer(img),
              child: Image.network(img.url),
            );
          },
        ),
      ],
    );
  }

  // 🔹 Проверка ответа
  void _checkAnswer(FirebaseImage img) {
    final isCorrect =
        prettyName(img.name) == currentQuestion.correctName;

    if (!isCorrect) {
      _showDialog('WRONG ❌', false);
      return;
    }

    // ✅ правильный
    if (currentIndex == questions.length - 1) {
      Navigator.pop(context);
      // _showDialog('QUIZ FINISHED 🎉', true);
    } else {
      _showDialog('RIGHT ✅', true);
    }
  }

  void _showDialog(String title, bool canGoNext) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);

              if (!canGoNext) return;

              setState(() {
                currentIndex++;
              });
            },
            child: Text(canGoNext ? 'Next' : 'Try again'),
          ),
        ],
      ),
    );
  }
}
