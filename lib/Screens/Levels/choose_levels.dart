import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kyrgyz_dictionary/classes/words_class.dart';
import 'package:kyrgyz_dictionary/list_of_words.dart';
import 'package:kyrgyz_dictionary/widgets/circle_button.dart';

import '../../State Management/Bloc/progress/counter_event.dart';
import '../../State Management/Bloc/progress/progress_bloc.dart';

class ChooseLevels extends StatefulWidget {
  String difficulty;
  var dataLevels;

  ChooseLevels({super.key, required this.difficulty, required this.dataLevels});

  @override
  State<ChooseLevels> createState() => _ChooseLevelsState();
}

class _ChooseLevelsState extends State<ChooseLevels> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(onPressed: (){
        context.read<ProgressBloc>().add(ResetDifficultyEvent());
      }, icon: Icon(Icons.arrow_back, size: 32,),),),
      body: Padding(

        padding: EdgeInsets.fromLTRB(35, 5, 35, 5),
        child: ListView(children:
        [
          Text('Difficulty: ${widget.difficulty}', style: TextStyle(fontSize: 24),),
          CircleButton(difficulty: 'easy', level: 'level1', listOfWords: easyWords1, alignment: MainAxisAlignment.start, game: 1),
          CircleButton(difficulty: widget.difficulty, level: 'level2', listOfWords: loadWords(1), alignment: MainAxisAlignment
              .center, game: 2),


          // CircleButton(difficulty: 'easy', level: 'level1', listOfWords: easyWords1, alignment: MainAxisAlignment.end, game: 1),
          // CircleButton(difficulty: widget.difficulty, level: 'level1', listOfWords: loadWords(1), alignment: MainAxisAlignment
          //     .center, game: 2),
          // CircleButton(difficulty: 'easy', level: 'level2', listOfWords: loadWords(2), alignment: MainAxisAlignment.start, game: 1),

          // Text('${widget.dataLevels}')
        ],),
      ),
    );
  }

  List<Words> loadWords(int level)
  {
    if(widget.difficulty == 'easy'){
      switch(level){
        case 1:
          return easyWords1;
        case 2:
          // return easyWords2;
        default:
          return [];
      }
    }
    else{
      return [];
    }
  }
}
