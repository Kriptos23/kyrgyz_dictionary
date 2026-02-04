import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kyrgyz_dictionary/classes/level_progress.dart';

import '../classes/firebase_image.dart';
import '../classes/words_class.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future<void> createUserDataOnFirstLogin() async {
    final levelsRef = usersCollection.doc(uid).collection('WordCardsDifficulty');

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

  Future<Map<String, Map<String, LevelProgress>>> getDifficultyProgress() async //returns overall progress for given difficulty
  {
    Map<String, Map<String, LevelProgress>> data = {};


    var difficultiesSnapshot = await usersCollection.doc(uid).collection('WordCardsDifficulty').get();

    if (difficultiesSnapshot.docs.isEmpty) {
      createUserDataOnFirstLogin();
    }

    difficultiesSnapshot = await usersCollection.doc(uid).collection('WordCardsDifficulty').get();

    for (var difficultyDoc in difficultiesSnapshot.docs) {
      final difficultyId = difficultyDoc.id; // "easy", "mid", "hard"
      print('\nDIFFICULTIES ARE: $difficultyId');

      final Map<String, LevelProgress> levelsMap = {};

      final levelsSnapshot = await difficultyDoc.reference.collection('levels').get();

      for (var levelDoc in levelsSnapshot.docs) {
        print('LEVELS ARE: ${levelDoc.id}');
        final levelId = levelDoc.id; // "level1", "level2"
        final json = levelDoc.data();
        // print('SO IS THIS ONE WORKING?');

        levelsMap[levelId] = LevelProgress.fromJson(json);
        // print('SO THIS ONE IS NOT WORKING HUH');
      }
      data[difficultyId] =
          levelsMap; //simultaneously creates a map field with the name of difficultyId, then makes it equal t levelsMap
    }
    return data;
  }

  Future<Map<String, Map<String, LevelProgress>>> getDifficultyProgress2(String difficulty) async //returns overall progress for
  // given
  // difficulty
  {
    Map<String, Map<String, LevelProgress>> data = {};
    final Map<String, LevelProgress> levelsMap = {};

    final difficultiesSnapshot = await usersCollection.doc(uid).collection('WordCardsDifficulty').get();

    for (var difficultyDoc in difficultiesSnapshot.docs) {
      final difficultyId = difficultyDoc.id; // "easy", "mid", "hard"

      final levelsSnapshot = await difficultyDoc.reference.collection('levels').get();

      for (var levelDoc in levelsSnapshot.docs) {
        final levelId = levelDoc.id; // "level1", "level2"
        final json = levelDoc.data();

        levelsMap[levelId] = LevelProgress.fromJson(json);
      }
      data[difficultyId] =
          levelsMap; //simultaneously creates a map field with the name of difficultyId, then makes it equal t levelsMap
    }
    return data;
  }

  Future<int> getLevelCounter(String difficulty, String level) async {
    final levelsRef = usersCollection.doc(uid).collection('WordCardsDifficulty');

    final levelDoc = await levelsRef.doc(difficulty).get();

    if (levelDoc.exists) {
      final levelCounter = levelDoc.data()![level];
      return levelCounter;
    } else {
      return 0;
    }
  }

  Future updateLevelCounter(String difficulty, String level) async {
    return await usersCollection.doc(uid).collection;
  }

  Future<void> setLevelValue(String uid, String difficulty, String level, int value) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).collection('WordCardsDifficulty').doc(difficulty).update({
      level: value,
    });
  }
}

Future<List<FirebaseImage>> getUrl(List<Words> listOfWords) async {//get urls for the images for levels
  List<String> listOfUrl = [];
  List<FirebaseImage> listOfImg = [];
  final List<String> imageUrls = listOfWords.map((word) => word.img!).toList();
  for (final url in imageUrls) {
    final ref = FirebaseStorage.instance
        .ref(url);

    final String imageUrl = await ref.getDownloadURL();
    final String imageName = await ref.name;
    listOfUrl.add(imageUrl);
    listOfImg.add(FirebaseImage(imageName, imageUrl));
  }

  return listOfImg;
}
