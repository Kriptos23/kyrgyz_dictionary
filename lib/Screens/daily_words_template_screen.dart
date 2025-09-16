import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter/cupertino.dart';
import '../classes/words_class.dart';
import '../widgets/botttom_nav_bar_widget.dart';
import 'package:kyrgyz_dictionary/list_of_words.dart';
import 'package:kyrgyz_dictionary/widgets/flip_cards_widget.dart';

class DailyWordsTemplateScreen extends StatefulWidget {
  final List<Words> listOfWords;
  final bool ifSetIsDone;

  const DailyWordsTemplateScreen({super.key,required this.listOfWords, this.ifSetIsDone=false});

  @override
  State<DailyWordsTemplateScreen> createState() => _DailyWordsTemplateScreenState();
}

class _DailyWordsTemplateScreenState extends State<DailyWordsTemplateScreen> {
  List<Words>? listOfWordsPointer;
  bool? ifSetIsDonePointer;

  BottomNavBar bottomNavBarWidget = BottomNavBar(1);

  final CardSwiperController controller = CardSwiperController();

  final TextEditingController _textController = TextEditingController();

  int cardIndex = 0;

  int rightAnswersCounter = 0;
  bool isNewCard = true;

  @override
  void initState() {
    super.initState();
    listOfWordsPointer = widget.listOfWords; // pointer (shared reference)
    ifSetIsDonePointer = widget.ifSetIsDone;
  }

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
                cardsCount: listOfWordsPointer!.length,
                cardBuilder: (context, index, percentThresholdX, percentThresholdY) => buildFlipCards(listOfWordsPointer!)[index],
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
                if(_textController.text.trim() == listOfWordsPointer![cardIndex].rusTrans){
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
                                if(!listOfWordsPointer![cardIndex].isCorrectlyAnswered){
                                  listOfWordsPointer![cardIndex].isCorrectlyAnswered = true;
                                  rightAnswersCounter++;
                                  if(rightAnswersCounter==10){
                                    ifSetIsDonePointer = true;
                                  }
                                  listOfWordsPointer![cardIndex].changeColorIfRight = Colors.lightGreen;
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
                                listOfWordsPointer![cardIndex].isCorrectlyAnswered = false;
                                rightAnswersCounter--;
                                listOfWordsPointer![cardIndex].changeColorIfRight = Colors.red;
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
