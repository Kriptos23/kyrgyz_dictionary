import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyrgyz_dictionary/services/auth.dart';
import '../../widgets/botttom_nav_bar_widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthService _auth = AuthService(); //auth obj from our self-made class to use sign-in functions

  Future<void> _handleRedirect() async {
    await _auth.handleRedirect();
  }

  @override
  void initState() {
    // TODO: implement initState
    // FirebaseAuth.instance.authStateChanges().listen((User? user)  {
    //   if (user != null) {
    //     print('We got our user ladies and gentlemen');
    //     _auth.handleRedirect();
    //   } else {
    //     // not signed in.
    //     print('nothing happened, no user ;(');
    //   }
    // });
    _handleRedirect();
    // wait5sec();
    // _auth.handleRedirect();

    super.initState();

    // _auth.handleRedirect();
  }

  // void wait5sec()async{
  //   await Future.delayed(const Duration(milliseconds: 250));
  //   _auth.handleRedirect();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 120,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: GestureDetector(
                  child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        // color: Color(0xFFDAD8D8),
                        // color: niceColor,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35),
                        border: Border.all(color: Colors.blue, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img/google.png',
                            width: 30,
                            height: 30,
                          ),
                          SizedBox(width: 10,),
                          Text('Sign in with Google', style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight
                              .w400, shadows: [Shadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 5),), ]),),
                        ],
                      )),
                  onTap: () async {
                    dynamic result = await _auth.signInWithGoogle(); //method from auth.dart, should return null or OurUser obj
                    if (result == null) {
                      print('error signing in');
                    } else {
                      print('signed in');
                      print(result.uid);
                    }
                  }),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: GestureDetector(
                  child: Text('Sign in Anonymously', style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.w500,
                      shadows: [Shadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 5),), ])),
                  onTap: () async {
                    dynamic result = await _auth.signInAnon(); //method from auth.dart, should return null or OurUser obj
                    if (result == null) {
                      print('error signing in');
                    } else {
                      print('signed in');
                      print(result.uid);
                    }
                  }),
            ),
            Text('Гугл вход на айфоне не работает\nВходите анонимно, буквально потратил 2 дня\nэта фигня не решается\n test 5',
                style:
            TextStyle(color:
            Colors
                .blue
                .shade900, fontWeight: FontWeight.w500,
                shadows: [Shadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 5),), ])),
          ],
        ),
      ),
    );
  }
}