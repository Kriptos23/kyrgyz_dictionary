import 'package:easy_localization/easy_localization.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import '../../generated/locale_keys.g.dart';
import '../../list_of_words.dart';
import '../../widgets/flip_cards_widget.dart';

class FunBox extends StatefulWidget {
  const FunBox({super.key});

  @override
  State<FunBox> createState() => _FunBoxState();
}

class _FunBoxState extends State<FunBox> {
  final TextEditingController _textController = TextEditingController();

  void initState() {
    super.initState();
    // _loadFlipCards();
    sample1.shuffle();
    swipeThrough(sample1.length);
  }

  CardSwiperController cardSwiperController = CardSwiperController();
  final FlipCardController flipCardController = FlipCardController();

  Future<void> swipeThrough(int count) async {
    for (int i = 0; i < count; i++) {
      await Future.delayed(const Duration(milliseconds: 250));
      cardSwiperController.swipe(CardSwiperDirection.left);
      // await Future.delayed(const Duration(milliseconds: 250));
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 500));
      flipCardController.toggleCard();
      await Future.delayed(const Duration(milliseconds: 1500));
      flipCardController.toggleCard();
    });
  }

  List<FlipCard> _flipCards = [];
  bool _isLoading = true; // пока грузятся картинки
  int cardIndex = 0;
  bool isNewCard = true;

  Future<void> _loadFlipCards() async {
    // 1. Получаем готовый список URL

    // 2. Строим карточки
    // final cards = buildFlipCards1(sample1);

    // 3. Сохраняем их в состояние
    if (!mounted) return;
    setState(() {
      // _flipCards = cards;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [
        Text(
          LocaleKeys.greeting.tr(),
          style: const TextStyle(fontSize: 16),
        ),
        Flexible(
          child: CardSwiper(
            cardsCount: sample1.length,
            controller: cardSwiperController,
            cardBuilder: (context, index, percentThresholdX, percentThresholdY) =>
                buildFlipCards1(sample1, flipCardController)[index],
            onSwipe: (previousIndex, currentIndex, direction) {
              cardIndex = currentIndex!;
              isNewCard = true;
              return true; // 👈 must return true to allow the swipe
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15, 5, 15, 30),
          child: TextField(
            controller: _textController,
            decoration: InputDecoration(
              labelText: "Напиши перевод!",
              border: OutlineInputBorder(),
              suffixIcon: IconButton(onPressed:(){
                if (_textController.text.trim() == sample1![cardIndex].rusTrans!.tr()) {

                  setState(() {
                    sample1[cardIndex].changeColorIfRight =
                        Colors.green;
                    sample1[cardIndex].containerFrontColor =
                        Colors.green.shade50;

                    if (!sample1[cardIndex].isCorrectlyAnswered) {
                      sample1[cardIndex].isCorrectlyAnswered = true;
                      // rightAnswersCounter++;
                      // onCorrectAnswer();

                      // if (rightAnswersCounter == 10) {
                      //   ifSetIsDonePointer = true;
                      // }
                    }
                  });








                  // buildFlipCards()[0].toggleCard();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Row(
                      children: const [
                        Icon(Icons.check_circle, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Correct!'),
                      ],
                    ),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    // makes it float above content
                    margin: const EdgeInsets.all(16),
                    // spacing from edges
                    duration: const Duration(seconds: 1),
                    // auto disappears
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ));
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Жок ай", style: TextStyle(color: Colors.red)),
                        content: const Text("Try again!"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // closes the popup
                              setState(() {
                                sample1[cardIndex].isCorrectlyAnswered = false;
                                // rightAnswersCounter--;
                                // onCorrectAnswer();//updates counter in the FireStore Cloud
                                sample1[cardIndex].changeColorIfRight = Colors.red;
                                sample1[cardIndex].containerFrontColor = Colors.red.shade50;
                              });
                            },
                            child: const Text("Close"),
                          ),
                        ],
                      );
                    },
                  );
                }
              }, icon: Icon(Icons.search))
            ),

          ),
        ),

      ]),
    );
  }
}
