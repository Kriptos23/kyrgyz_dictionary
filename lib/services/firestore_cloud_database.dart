import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService
{
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future<void> createUserDataOnFirstLogin() async {
    final levelsRef = usersCollection
        .doc(uid)
        .collection('WordCardsDifficulty');

    // Check if the "easy" document exists (if it does → user data exists)
    final easyDoc = await levelsRef.doc('easy').collection('levels').doc('level1').get();

    if (!easyDoc.exists) {
      // Create all default difficulty documents
      await levelsRef.doc('easy').collection('levels').doc('level1').set({
        'counter': 0,
        'answeredWords': [],
        'isDone': false,
      });
      await levelsRef.doc('easy').collection('levels').doc('level2').set({
        'counter': 0,
        'answeredWords': [],
        'isDone': false,
      });
      await levelsRef.doc('easy').collection('levels').doc('level3').set({
        'counter': 0,
        'answeredWords': [],
        'isDone': false,
      });

      await levelsRef.doc('medium').collection('levels').doc('level1').set({
        'counter': 0,
        'answeredWords': [],
        'isDone': false,
      });
      await levelsRef.doc('medium').collection('levels').doc('level2').set({
        'counter': 0,
        'answeredWords': [],
        'isDone': false,
      });
      await levelsRef.doc('medium').collection('levels').doc('level3').set({
        'counter': 0,
        'answeredWords': [],
        'isDone': false,
      });

      await levelsRef.doc('hard').collection('levels').doc('level1').set({
        'counter': 0,
        'answeredWords': [],
        'isDone': false,
      });
      await levelsRef.doc('hard').collection('levels').doc('level2').set({
        'counter': 0,
        'answeredWords': [],
        'isDone': false,
      });
      await levelsRef.doc('hard').collection('levels').doc('level3').set({
        'counter': 0,
        'answeredWords': [],
        'isDone': false,
      });

      print("User data created for the first time!");
    } else {
      print("User already exists – no need to create.");
    }
  }

  /*
  *
  * Future<void> createUserDataOnFirstLogin() async {
  final diffRef = usersCollection.doc(uid).collection('WordCardsDifficulty');

  // Check only one document (easy → level1)
  final exists = await diffRef
      .doc('easy')
      .collection('levels')
      .doc('level1')
      .get();

  if (exists.exists) {
    print("User already exists – no need to create.");
    return;
  }

  print("Creating user levels data…");

  final difficulties = ['easy', 'medium', 'hard'];
  final levels = ['level1', 'level2', 'level3'];

  for (final diff in difficulties) {
    for (final lvl in levels) {
      await diffRef.doc(diff).collection('levels').doc(lvl).set({
        'counter': 0,
        'answeredWords': [],
        'isDone': false,
      });
    }
  }

  print("All default difficulty + level data created!");
}
  *
  * */

  Future<int> getLevelCounter(String difficulty, String level) async
  {
    final levelsRef = usersCollection
        .doc(uid)
        .collection('WordCardsDifficulty');

    final levelDoc = await levelsRef.doc(difficulty).get();

    if(levelDoc.exists)
      {
        final levelCounter = levelDoc.data()![level];
        return levelCounter;
      }
    else
      {
        return 0;
      }
  }

  Future updateLevelCounter(String difficulty, String level) async{
     return await usersCollection.doc(uid).collection;
   }

  Future<void> setLevelValue(String uid, String difficulty, String level, int value) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('WordCardsDifficulty')
        .doc(difficulty)
        .update({
      level: value,
    });
  }

}