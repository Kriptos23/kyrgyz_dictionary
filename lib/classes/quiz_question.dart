import 'package:kyrgyz_dictionary/classes/firebase_image.dart';

class QuizQuestion{
  final String correctName;
  final List<FirebaseImage> options;

  QuizQuestion({required this.correctName, required this.options});

}

String prettyName(String rawName) {
  return rawName
      .replaceAll('.png', '')
      .replaceAll('_', ' ')
      .toLowerCase();
}