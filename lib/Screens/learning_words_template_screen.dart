import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:kyrgyz_dictionary/services/firestore_cloud_database.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../classes/firebase_image.dart';
import '../classes/words_class.dart';
import '../generated/locale_keys.g.dart';
import '../widgets/botttom_nav_bar_widget.dart';
import 'package:kyrgyz_dictionary/widgets/flip_cards_widget.dart';

class LearningWordsTemplateScreen extends StatefulWidget {
  final String uid;
  final List<Words> listOfWords;
  final bool ifSetIsDone;
  final String difficulty;
  final String level;

  const LearningWordsTemplateScreen({
    super.key,
    required this.uid,
    required this.listOfWords,
    this.ifSetIsDone = false,
    required this.difficulty,
    required this.level,
  });

  @override
  State<LearningWordsTemplateScreen> createState() => _LearningWordsTemplateScreenState();
}

class _LearningWordsTemplateScreenState extends State<LearningWordsTemplateScreen> {
  Color containerColor = Colors.white;
  List<FlipCard> _flipCards = [];
  bool _isLoading = true; // пока грузятся картинки
  List<String> readyUrls = [];

  Future<void> _loadFlipCards() async {
    // 1. Получаем готовый список URL
    List<FirebaseImage> images = await getUrl(widget.listOfWords); // твой Future<List<String>>

    readyUrls = images.map((img) => img.url).toList();

    // 2. Строим карточки
    // final cards = buildFlipCards(widget.listOfWords, readyUrls);
    //
    // // 3. Сохраняем их в состояние
    if (!mounted) return;
    setState(() {
      // _flipCards = cards;
      _isLoading = false;
    });

    swipeThrough(widget.listOfWords.length);
  }

  late final DatabaseService databaseService;
  int rightAnswersCounter = 0; // default value

  void onCorrectAnswer() async {
    final uid = widget.uid;
    final difficulty = widget.difficulty;
    final level = widget.level;

    // increment the level counter
    await databaseService.setLevelValue(uid, difficulty, level, rightAnswersCounter);

    // optionally update local state
    setState(() {
      // rightAnswersCounter += 1;
    });
  }

  @override
  void initState() {
    super.initState();
    listOfWordsPointer = widget.listOfWords; // pointer (shared reference)
    ifSetIsDonePointer = widget.ifSetIsDone;
    databaseService = DatabaseService(uid: widget.uid); // initialize database service using late because we can not initialize
    // it in the constructor, we need uid first
    _loadRightAnswersCounter(); // load right answers counter from database, also need in here because we
    // need dataBaseService
    // obj first
    _loadFlipCards();
  }

  final FlipCardController flipCardController = FlipCardController();
  CardSwiperController cardSwiperController = CardSwiperController();

  Future<void> swipeThrough(int count) async {
    for (int i = 0; i < count; i++) {
      await Future.delayed(const Duration(milliseconds: 250));
      cardSwiperController.swipe(CardSwiperDirection.right);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 500));
      flipCardController.toggleCard();
      await Future.delayed(const Duration(milliseconds: 1500));
      flipCardController.toggleCard();
    });
  }

  // load right answers counter from database, need as a function because we need it as async
  Future<void> _loadRightAnswersCounter() async {
    final counter = await databaseService.getLevelCounter(widget.difficulty, widget.level);

    setState(() {
      rightAnswersCounter = counter;
    });
  }

  bool ifMobile() {
    if (MediaQuery.sizeOf(context).width < 420) {
      return true; // desktop web
    }
    return false;
  }

  List<Words>? listOfWordsPointer;
  bool? ifSetIsDonePointer;

  // late int rightAnswersCounterPointer;

  // BottomNavBar bottomNavBarWidget = BottomNavBar(1);

  final TextEditingController _textController = TextEditingController();

  int cardIndex = 0;

  bool isNewCard = true;

  bool _onSwipe(int index) {
    // final flipC = cards[index];
    // if(flipC.isItFront == false){
    //   return true;
    // }
    // else{
    //   return false;
    // }
    return false;
  }

  // String? selectedLanguage;
  // List<String> languageOptions = <String>["Kyrgyz", "Russian", "English"];

  @override
  Widget build(BuildContext context)
  {
    if (_isLoading)
    {
      return const Center(child: CircularProgressIndicator());
    }
    else
    {
      return SafeArea(
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, Object? result) async {
            if (didPop) return; // already popped
            // Navigator.of(context).pop(rightAnswersCounterPointer);
            Navigator.pop(context, rightAnswersCounter);
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                '$rightAnswersCounter/5',
                style: const TextStyle(color: Colors.lightGreen, fontSize: 15),
              ),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 32,
                ),
              ),
            ),
            // bottomNavigationBar: bottomNavBarWidget.buildBottomNavBar(context, setState),
            body: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Column(

                children: [
                  Flexible(
                    ///СЮДА СМОТРИ
                    child: CardSwiper(
                      controller: cardSwiperController,
                      isDisabled: _onSwipe(0),
                      cardsCount: widget.listOfWords!.length,
                      cardBuilder: (context, index, percentThresholdX, percentThresholdY) =>
                          buildFlipCards(widget.listOfWords, readyUrls, flipCardController)[index],
                      onSwipe: (previousIndex, currentIndex, direction) {
                        cardIndex = currentIndex!;
                        isNewCard = true;
                        return true; // 👈 must return true to allow the swipe
                      },
                    ),
                  ),
                  TextField(
                    controller: _textController,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.lets_play.tr(),
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // ElevatedButton(onPressed: (){swipeThrough(widget.listOfWords.length);}, child: Text('swipe ${widget.listOfWords
                  //     .length} times')),
                  // ElevatedButton(onPressed: (){flipCardController.toggleCard();}, child: Text('toggle card')),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white ,side: BorderSide(color: Colors.black)),
                    onPressed: () {
                      if (_textController.text.trim() == widget.listOfWords![cardIndex].rusTrans!.tr()) {
                        widget.listOfWords![cardIndex].changeColorIfRight = Colors.green;
                        widget.listOfWords![cardIndex].containerFrontColor = Colors.green.shade50;
                        // buildFlipCards()[0].toggleCard();

                        showTopSnackBar(
                          animationDuration: Duration(milliseconds: 500),
                          displayDuration: Duration(milliseconds: 1000),
                          reverseAnimationDuration: Duration(milliseconds: 0),
                          Overlay.of(context),
                          CustomSnackBar.success(
                            message:
                            "Азамат!",
                          ),
                        );

                        setState(() {
                          if (!widget.listOfWords![cardIndex].isCorrectlyAnswered) {
                            widget.listOfWords![cardIndex].isCorrectlyAnswered = true;
                            rightAnswersCounter++;
                            onCorrectAnswer();

                            if (rightAnswersCounter == 10) {
                              ifSetIsDonePointer = true;
                            }
                          }

                          isNewCard = false;

                          //Will clear the text if answer is correct, text will stay if incorrect
                          _textController.clear();
                        });
                      } else {
                        setState(() {
                          widget.listOfWords![cardIndex].isCorrectlyAnswered = false;
                          rightAnswersCounter--;
                          onCorrectAnswer(); //updates counter in the FireStore Cloud
                          widget.listOfWords![cardIndex].changeColorIfRight = Colors.red;
                          widget.listOfWords![cardIndex].containerFrontColor = Colors.red.shade50;
                        });

                        showTopSnackBar(
                          animationDuration: Duration(milliseconds: 500),
                          displayDuration: Duration(milliseconds: 1000),
                          reverseAnimationDuration: Duration(milliseconds: 0),
                          Overlay.of(context),
                          CustomSnackBar.error(
                            message:
                            "Жок ай!",
                          ),
                        );

                      }
                    },
                    child: Text(LocaleKeys.check.tr(), style: TextStyle(color: Colors.black),),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
