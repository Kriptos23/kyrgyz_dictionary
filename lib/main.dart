import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kyrgyz_dictionary/Screens/daily_words_screen.dart';
import 'Screens/Authenticate/sign_in.dart';
import 'Screens/sozduk_screen.dart';

Future <void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAIqfRVIRjB6ZbLvPsdOF8Ve2tYz774B1E", // Your apiKey
      appId: "1:308251536087:android:644598832b84836ce11e92", // Your appId
      messagingSenderId: "308251536087", // Your messagingSenderId
      projectId: "kyrgyz-dictionary-6fb97", // Your projectId
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes:
      {
        '/':(context) => const SozdukScreen(),
        '/sozdor':(context) => const DailyWords(),
        '/authentification':(context) => const SignIn(),
      },
    );
  }
}
