import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'botttom_nav_bar.dart';

class DailyWords extends StatefulWidget {
  const DailyWords({super.key});

  @override
  State<DailyWords> createState() => _DailyWordsState();
}

class _DailyWordsState extends State<DailyWords> {
  BottomNavBar bottomNavBarWidget = BottomNavBar(1);

  final CardSwiperController controller = CardSwiperController();



  bool _onSwipe(int index){
    // final flipC = cards[index];
    // if(flipC.isItFront == false){
    //   return true;
    // }
    // else{
    //   return false;
    // }
    return false;
  }
  GlobalKey<FlipCardState> key1 = GlobalKey<FlipCardState>();
  List<FlipCard> cards = [
    FlipCard(
      key:  const ValueKey('card1'),
      fill: Fill.fillBack,
      // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.VERTICAL,
      // default
      side: CardSide.FRONT,
      // The side to initially display.
      front: Container(
        alignment: Alignment.center,
        child: const Text('front1'),
        color: Colors.blue,
        isSwipable: true,
      ),
      back: Container(
        alignment: Alignment.center,
        child: const Text('back1'),
        color: Colors.red,
        isSwipable: false,
      ),
    ),
    FlipCard(
      key:  const ValueKey('card2'),
      fill: Fill.fillBack,
      // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.VERTICAL,
      // default
      side: CardSide.FRONT,
      // The side to initially display.
      front:     Container(
        alignment: Alignment.center,
        child: const Text('front2'),
        color: Colors.purple,
      ),
      back:     Container(
        alignment: Alignment.center,
        child: const Text('back2'),
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
        child: const Text('front3'),
        color: Colors.grey,
      ),
      back:     Container(
        alignment: Alignment.center,
        child: const Text('back3'),
        color: Colors.green,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavBarWidget.buildBottomNavBar(context, setState),
      body: Flexible(
        child: CardSwiper(
          isDisabled: _onSwipe(0),
          cardsCount: cards.length,
          cardBuilder: (context, index, percentThresholdX, percentThresholdY) => cards[index],
        ),
      ),
    );
  }
}
