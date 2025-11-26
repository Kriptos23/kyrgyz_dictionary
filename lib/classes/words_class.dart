import 'package:flutter/material.dart';

class Words{
  ///This is Words class that we use in our flipcards

  String? word;//words itself
  String? rusTrans;//translation
  String? engTrans;//translation
  String? img;//image of word, not yet implemented
  bool isCorrectlyAnswered;
  Color changeColorIfRight;


  Words({required this.word, required this.rusTrans, required this.img, this.isCorrectlyAnswered=false, this.changeColorIfRight
  = Colors.blue});


}