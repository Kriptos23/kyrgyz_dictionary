import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kyrgyz_dictionary/Screens/Authenticate/wrapper.dart';
import 'package:kyrgyz_dictionary/Screens/daily_words_screen.dart';
import 'package:kyrgyz_dictionary/classes/our_user.dart';
import 'package:kyrgyz_dictionary/services/auth.dart';
import 'package:provider/provider.dart';
import 'Screens/Authenticate/my_profile.dart';
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
    return StreamProvider.value(//this is our Provider package's class we can use to listen to Stream
      value: AuthService().user,//This must listen to the Stream from .user method
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes:
        {
          '/':(context) => const Wrapper(),
          '/sozduk':(context) => const SozdukScreen(),
          '/sozdor':(context) => const DailyWords(),
          '/menin_profilim':(context) => const MyProfile(),
          '/sign_in':(context) => const SignIn(),
        },
      ),
    );
  }
}
