import 'package:easy_localization/easy_localization.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:kyrgyz_dictionary/classes/words_class.dart';
import 'package:flutter/material.dart';
import 'package:kyrgyz_dictionary/services/database_audio.dart';
import 'package:kyrgyz_dictionary/widgets/audio_button.dart';

Color niceColor = Color(0xFF272727);
AudioService audioService = AudioService();

List<FlipCard> buildFlipCards(List<Words> listOfWords, List<String> listOfUrl, FlipCardController flipCardController) {
  List<FlipCard> cards = [];
  for (var i = 0; i < listOfWords.length; i++) {
    cards.add(
      FlipCard(
        controller: flipCardController,
        key: ValueKey('card$i'),
        front: Container(
          // width: 650,
          // height: 250,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: listOfWords[i].containerFrontColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
            border: Border.all(color: listOfWords[i].changeColorIfRight, width: 3),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: Image.network(
                listOfUrl[i],
                width: 300,
                height: 300,
              )),
              Column(
                children: [
                  Text(
                    '${listOfWords[i].word}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      letterSpacing: 0.5,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    listOfWords[i].transcription ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      // lighter weight
                      fontStyle: FontStyle.italic,
                      // gives phonetic feel
                      color: Colors.grey.shade600,
                      // softer color
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ), // ElevatedButton(onPressed: (){flipCardController.toggleCard();}, child: Text('toggle')),
            ],
          ),
        ),
        back: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blue.shade300,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: listOfWords[i].changeColorIfRight, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Text(
            '${listOfWords[i].rusTrans!.tr()}',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              letterSpacing: 0.5,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
          ),
        ),
        // autoFlipDuration: Duration(seconds: 0, milliseconds: 500),
      ),
    );
  }

  return cards;
}

List<FlipCard> buildFlipCards1(List<Words> listOfWords, FlipCardController flipCardController) {
  List<FlipCard> cards = [];
  // listOfWords.shuffle();
  for (var i = 0; i < listOfWords.length; i++) {
    cards.add(
      FlipCard(
        key: ValueKey('card$i'),
        controller: flipCardController,
        front: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: listOfWords[i].containerFrontColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
            border: Border.all(color: listOfWords[i].changeColorIfRight, width: 3),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // IconButton(onPressed: (){
                  //   audioService.playWord(listOfWords[i].audio);
                  // }, icon: Icon(Icons.volume_down_outlined)),
                  AudioButton(audioFile: listOfWords[i].audio, audioService: audioService),
                  Text(
                    '${listOfWords[i].word}',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      letterSpacing: 0.5,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                listOfWords[i].transcription ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  // lighter weight
                  fontStyle: FontStyle.italic,
                  // gives phonetic feel
                  color: Colors.grey.shade600,
                  // softer color
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
        back: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // color: Color(0xFFDAD8D8),
            // color: niceColor,
            color: Colors.blue.shade300,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: listOfWords[i].changeColorIfRight, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Text(
            '${listOfWords[i].rusTrans!.tr()}',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              letterSpacing: 0.5,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
          ),
        ),
        // autoFlipDuration: Duration(seconds: 0, milliseconds: 500),
      ),
    );
  }

  return cards;
}

List<FlipCard> buildFlipCards2(List<Words> listOfWords) {
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
        // autoFlipDuration: Duration(seconds: 0, milliseconds: 500),
      ),
    );
  }

  return cards;
}
