import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../classes/words_class.dart';
import '../widgets/botttom_nav_bar_widget.dart';
import 'package:kyrgyz_dictionary/widgets/flip_cards_widget.dart';

class DailyWordsTemplateScreen extends StatefulWidget {
  final List<Words> listOfWords;
  final bool ifSetIsDone;
  final int rightAnswersCounter;

  const DailyWordsTemplateScreen({super.key, required this.listOfWords, this.ifSetIsDone=false, required this.rightAnswersCounter
  });

  @override
  State<DailyWordsTemplateScreen> createState() => _DailyWordsTemplateScreenState();
}

class _DailyWordsTemplateScreenState extends State<DailyWordsTemplateScreen> {
  List<Words>? listOfWordsPointer;
  bool? ifSetIsDonePointer;
  late int rightAnswersCounterPointer;


  // BottomNavBar bottomNavBarWidget = BottomNavBar(1);

  final CardSwiperController controller = CardSwiperController();

  final TextEditingController _textController = TextEditingController();

  int cardIndex = 0;


  bool isNewCard = true;

  @override
  void initState() {
    super.initState();
    listOfWordsPointer = widget.listOfWords; // pointer (shared reference)
    ifSetIsDonePointer = widget.ifSetIsDone;
    rightAnswersCounterPointer = widget.rightAnswersCounter;
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
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) async{
          if (didPop) return; // already popped
          // Navigator.of(context).pop(rightAnswersCounterPointer);
          Navigator.pop(context, rightAnswersCounterPointer);
        },
        child: Scaffold(
          // bottomNavigationBar: bottomNavBarWidget.buildBottomNavBar(context, setState),
          body: Column(
            children: [
              Text('$rightAnswersCounterPointer/10', style: const TextStyle(color: Colors.lightGreen, fontSize: 15),),
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
                decoration: const InputDecoration(
                  labelText: "давай поиграем!",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
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
                                    rightAnswersCounterPointer++;
                                    if(rightAnswersCounterPointer==10){
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
                                  rightAnswersCounterPointer--;
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
                child: const Text("Get Explanation"),
              ),
              ElevatedButton(onPressed: (){
                setState(() {
                  Navigator.pop(context, rightAnswersCounterPointer);
                });
              }, child: const Text('go back'))
            ],
          ),
        ),
      ),
    );
  }
}
