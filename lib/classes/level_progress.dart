class LevelProgress
{
  final bool completed;
  final int counter;
  final List<String> answeredWords;

  LevelProgress({required this.completed, required this.counter, required this.answeredWords});

  factory LevelProgress.fromJson(Map<String, dynamic> json)//this is factory named constructor which is used to convert json
  // file from the Firebase to get data and wrap the level's data to neat LevelProgress
  {
    return LevelProgress(completed: json['isDone'] ?? false, counter: json['counter'] ?? 0,
      answeredWords: (json['answeredWords'] as List<dynamic>? ?? [])
          .cast<String>(),);
  }

}