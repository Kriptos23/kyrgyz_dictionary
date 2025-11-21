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
    final easyDoc = await levelsRef.doc('easy').get();

    if (!easyDoc.exists) {
      // Create all default difficulty documents
      await levelsRef.doc('easy').set({
        'level1': 0,
        'level2': 0,
        'level3': 0,
      });

      await levelsRef.doc('medium').set({
        'level1': 0,
        'level2': 0,
        'level3': 0,
      });

      await levelsRef.doc('hard').set({
        'level1': 0,
        'level2': 0,
        'level3': 0,
      });

      print("User data created for the first time!");
    } else {
      print("User already exists – no need to create.");
    }
  }

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