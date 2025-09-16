import 'package:flutter/material.dart';

class Words{
  String? word;
  String? rusTrans;
  String? img;
  bool isCorrectlyAnswered;
  Color changeColorIfRight;


  Words({required this.word, required this.rusTrans, required this.img, this.isCorrectlyAnswered=false, this.changeColorIfRight
  = Colors.blue});


}