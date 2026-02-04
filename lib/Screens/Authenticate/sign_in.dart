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
          ],
        ),
      ),
    );
  }
}
