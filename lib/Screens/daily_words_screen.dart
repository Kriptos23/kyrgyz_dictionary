import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyrgyz_dictionary/Screens/Levels/choose_difficulty.dart';
import 'package:kyrgyz_dictionary/Screens/Levels/choose_levels.dart';
import 'package:kyrgyz_dictionary/widgets/loading_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../State Management/Bloc/progress/counter_state.dart';
import '../State Management/Bloc/progress/progress_bloc.dart';
import '../services/auth.dart';
import '../services/firestore_cloud_database.dart';
import '../widgets/botttom_nav_bar_widget.dart';
import 'package:kyrgyz_dictionary/list_of_words.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'learning_words_template_screen.dart';

class DailyWords extends StatefulWidget {
  const DailyWords({super.key});

  @override
  State<DailyWords> createState() => _DailyWordsState();
}

class _DailyWordsState extends State<DailyWords> {


  @override
  void initState(){
    super.initState();
  }


  //
  // int ifNullCounter(int count){
  //   return count;
  //   }

  // int? test;
  // late int counter2;
  // late int counter3;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
      Scaffold(
        // bottomNavigationBar: bottomNavBarWidget.buildBottomNavBar(context, setState),//Bottom NavBar object that we created
        // ourselves
        body:
        BlocBuilder<ProgressBloc, ProgressState>(
          builder: (context, state){
            if(state is ProgressInitial){
              return ChooseDifficulty();
            }
            if(state is ProgressLoading){
              print(state.difficulty); // works well
              return LoadingWidget();//make a loading widget
            }
            if(state is ProgressLoaded){
              final dataLevels = state.data[state.difficulty];

              return ChooseLevels(
                difficulty: state.difficulty,
                dataLevels: dataLevels,
              );
              print(state.difficulty);
              return ChooseLevels(difficulty: state.difficulty, dataLevels: dataLevels,);
            }
            if(state is ProgressError){
              return Center(child: Text(state.exception?.toString() ?? 'Exception'));
            }
            return Placeholder();
          }

        ),

      ),
    );
  }
}
