import '../../../classes/level_progress.dart';

abstract class ProgressState{
  const ProgressState();
}

class ProgressInitial extends ProgressState{}

class ProgressLoading extends ProgressState{
  final String difficulty;

  ProgressLoading(this.difficulty);
}

class ProgressLoaded extends ProgressState{
  final String difficulty;
  final Map<String, Map<String, LevelProgress>> data;

  ProgressLoaded(this.data,this.difficulty);
}

class ProgressError extends ProgressState {
  final Object exception;

  ProgressError(this.exception);
}