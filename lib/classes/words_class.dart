import 'package:flutter/material.dart';

class Words{
  ///This is Words class that we use in our flipcards

  static const Color constContainerBackColor = Color(0xFF272727);

  String? word;//words itself
  String? rusTrans;//translation
  String? engTrans;//translation
  String? img;//image of word, not yet implemented
  bool isCorrectlyAnswered;
  Color changeColorIfRight;
  Color containerFrontColor;
  String transcription;


  Words({required this.word, required this.rusTrans, required this.img, this.isCorrectlyAnswered=false, this.changeColorIfRight
  = Colors.blue, this.containerFrontColor = Colors.white, required this.transcription
  });



}