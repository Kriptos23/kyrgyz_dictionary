import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../State Management/Bloc/progress/counter_event.dart';
import '../../State Management/Bloc/progress/progress_bloc.dart';


class ChooseDifficulty extends StatefulWidget {
  const ChooseDifficulty({super.key});

  @override
  State<ChooseDifficulty> createState() => _ChooseDifficultyState();
}

class _ChooseDifficultyState extends State<ChooseDifficulty> {
  @override
  void initState(){
    super.initState();
  }


  final uid = FirebaseAuth.instance.currentUser!.uid;
 
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () async {
              context.read<ProgressBloc>().add(LoadDifficulty('easy'));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text("EASY\nLevel 1", textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),),
            ),
          ),

        ],
      ),
    );
  }
}
