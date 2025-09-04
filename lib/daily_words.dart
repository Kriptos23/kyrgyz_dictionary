import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flip_card/flip_card.dart';

class DailyWords extends StatefulWidget {
  const DailyWords({super.key});

  @override
  State<DailyWords> createState() => _DailyWordsState();
}

class _DailyWordsState extends State<DailyWords> {
  final CardSwiperController controller = CardSwiperController();

  List<Widget> cards = [
    FlipCard(
      fill: Fill.fillBack,
      // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.VERTICAL,
      // default
      side: CardSide.FRONT,
      // The side to initially display.
      front: Container(
        alignment: Alignment.center,
        child: const Text('front'),
        color: Colors.blue,
      ),
      back: Container(
        alignment: Alignment.center,
        child: const Text('2'),
        color: Colors.red,
      ),
    ),
    FlipCard(
      fill: Fill.fillBack,
      // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.VERTICAL,
      // default
      side: CardSide.FRONT,
      // The side to initially display.
      front:     Container(
        alignment: Alignment.center,
        child: const Text('3'),
        color: Colors.purple,
      ),
      back:     Container(
        alignment: Alignment.center,
        child: const Text('3'),
        color: Colors.yellow,
      ),
    ),
    FlipCard(
      fill: Fill.fillBack,
      // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.VERTICAL,
      // default
      side: CardSide.FRONT,
      // The side to initially display.
      front:     Container(
        alignment: Alignment.center,
        child: const Text('3'),
        color: Colors.grey,
      ),
      back:     Container(
        alignment: Alignment.center,
        child: const Text('3'),
        color: Colors.green,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flexible(
        child: CardSwiper(
          cardsCount: cards.length,
          cardBuilder: (context, index, percentThresholdX, percentThresholdY) => cards[index],
        ),
      ),
    );
  }
}
