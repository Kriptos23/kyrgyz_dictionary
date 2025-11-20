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
    name: "kyrgyz-dictionary-6fb97",
    options: FirebaseOptions(
        apiKey: "AIzaSyD5HvXDXe19-NkteCb-_ZXW_NXwgDZ8Gsk",
        authDomain: "kyrgyz-dictionary-6fb97.firebaseapp.com",
        projectId: "kyrgyz-dictionary-6fb97",
        storageBucket: "kyrgyz-dictionary-6fb97.firebasestorage.app",
        messagingSenderId: "308251536087",
        appId: "1:308251536087:web:d72d8b2d707cf076e11e92",
        measurementId: "G-LYQCE3S6XE"
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
