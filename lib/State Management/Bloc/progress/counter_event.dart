abstract class ProgressEvent {}

class LoadDifficulty extends ProgressEvent{
  final String difficulty;

  LoadDifficulty(this.difficulty);
}

class UpdateLevelProgress extends ProgressEvent {
  final String difficulty;
  final String level;
  final int value;

  UpdateLevelProgress(this.difficulty, this.level, this.value);
}

class ResetDifficultyEvent extends ProgressEvent {}

// class Increment extends ProgressEvent {}
// class Decrement extends ProgressEvent {}