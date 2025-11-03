import 'package:flip_card/flip_card.dart';
import 'package:kyrgyz_dictionary/classes/words_class.dart';
import 'package:flutter/material.dart';



List<FlipCard> buildFlipCards(List<Words> listOfWords) {
  List<FlipCard> cards = [];
  for (var i = 0; i < listOfWords.length; i++) {
    cards.add(
      FlipCard(
        key: ValueKey('card$i'),
        front: Container(
          alignment: Alignment.center,
          color: listOfWords[i].changeColorIfRight,
          child: Text(
            '${listOfWords[i].word}',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
        back: Container(
          alignment: Alignment.center,
          color: Colors.green,
          child: Text(
            '${listOfWords[i].rusTrans}',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }

  return cards;
}

