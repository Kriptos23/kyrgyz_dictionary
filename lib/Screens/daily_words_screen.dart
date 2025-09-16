import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter/cupertino.dart';
import '../widgets/botttom_nav_bar_widget.dart';
import 'package:kyrgyz_dictionary/list_of_words.dart';
import 'package:kyrgyz_dictionary/widgets/flip_cards_widget.dart';

class DailyWords extends StatefulWidget {
  const DailyWords({super.key});

  @override
  State<DailyWords> createState() => _DailyWordsState();
}

class _DailyWordsState extends State<DailyWords> {
  BottomNavBar bottomNavBarWidget = BottomNavBar(1);

  final CardSwiperController controller = CardSwiperController();

  final TextEditingController _textController = TextEditingController();

  int cardIndex = 0;

  int rightAnswersCounter = 0;
  bool isNewCard = true;



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


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: bottomNavBarWidget.buildBottomNavBar(context, setState),
        body: Column(
          children: [
            Text('$rightAnswersCounter/10', style: TextStyle(color: Colors.lightGreen, fontSize: 15),),
            Flexible(
              child: CardSwiper(
                isDisabled: _onSwipe(0),
                cardsCount: easyWords1.length,
                cardBuilder: (context, index, percentThresholdX, percentThresholdY) => buildFlipCards()[index],
                onSwipe: (previousIndex, currentIndex, direction) {
                  cardIndex = currentIndex!;
                  isNewCard = true;
                  return true; // 👈 must return true to allow the swipe
                },
              ),
            ),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: "давай поиграем!",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                if(_textController.text.trim() == easyWords1[cardIndex].rusTrans){
                  // buildFlipCards()[0].toggleCard();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Азамат!", style: TextStyle(color: Colors.lightGreen),),
                        content: const Text("You are right!"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // closes the popup
                              setState((){
                                // if(isNewCard == true && rightAnswersCounter<10){
                                //   rightAnswersCounter++;
                                // }
                                if(!easyWords1[cardIndex].isCorrectlyAnswered){
                                  easyWords1[cardIndex].isCorrectlyAnswered = true;
                                  rightAnswersCounter++;
                                  easyWords1[cardIndex].changeColorIfRight = Colors.lightGreen;
                                }
                              });
                              isNewCard = false;
                            },
                            child: const Text("Close"),
                          ),
                        ],
                      );
                    },
                  );
                }
                else{
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
                                easyWords1[cardIndex].isCorrectlyAnswered = false;
                                rightAnswersCounter--;
                                easyWords1[cardIndex].changeColorIfRight = Colors.red;
                              });
                            },
                            child: const Text("Close"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text("Get Explanation"),
            ),
          ],
        ),
      ),
    );
  }
}
