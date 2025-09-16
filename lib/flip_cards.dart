import 'package:flip_card/flip_card.dart';
import 'package:kyrgyz_dictionary/Screens/words_class.dart';
import 'package:flutter/material.dart';


import 'package:kyrgyz_dictionary/list_of_words.dart';

List<FlipCard> buildFlipCards() {
  List<FlipCard> cards = [];
  for (var i = 0; i < easyWords.length; i++) {
    cards.add(
      FlipCard(
        key: ValueKey('card$i'),
        front: Container(
          alignment: Alignment.center,
          color: easyWords[i].changeColorIfRight,
          child: Text(
            '${easyWords[i].word}',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
        back: Container(
          alignment: Alignment.center,
          color: Colors.green,
          child: Text(
            '${easyWords[i].rusTrans}',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  return cards;
}

