import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kyrgyz_dictionary/State%20Management/Bloc/progress/counter_event.dart';
import 'package:kyrgyz_dictionary/classes/level_progress.dart';

import '../../../services/firestore_cloud_database.dart';
import 'counter_state.dart';


class ProgressBloc extends Bloc<ProgressEvent, ProgressState>{


  final uid = FirebaseAuth.instance.currentUser!.uid;

  late final DatabaseService databaseService = DatabaseService(uid: uid);// initialize database service using late because we
  // can not initialize


  ProgressBloc() : super(ProgressInitial()){

    on<LoadDifficulty>((event, emit) async{
      String difficulty = event.difficulty;//working well
      emit(ProgressLoading(difficulty));



      try {
        var difficultyProgress = await databaseService.getDifficultyProgress();

        if (difficultyProgress[event.difficulty] == null ||
            difficultyProgress[event.difficulty]!.isEmpty) {
          await databaseService.createUserDataOnFirstLogin();
          difficultyProgress = await databaseService.getDifficultyProgress();
        }

        emit(ProgressLoaded(difficultyProgress, difficulty));
      }catch (e) {
        // TODO
        emit(ProgressError(e));
      }
    });

    on<ResetDifficultyEvent>((event, emit) {
      emit(ProgressInitial());
    });

  }
}