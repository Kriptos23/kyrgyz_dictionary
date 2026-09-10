import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyrgyz_dictionary/services/auth.dart';
import '../../widgets/botttom_nav_bar_widget.dart';
import 'package:flutter/foundation.dart';
class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthService _auth = AuthService(); //auth obj from our self-made class to use sign-in functions

  Future<void> _handleRedirect() async {
    if(kIsWeb){
      await _auth.handleRedirect();
    }
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
    if (kIsWeb) {
      _handleRedirect(); // only runs on Web
    }
    // wait5sec();
    // _auth.handleRedirect();

    super.initState();

    // _auth.handleRedirect();
  }

  void wait5sec()async{
    await Future.delayed(const Duration(milliseconds: 250));
    _auth.handleRedirect();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(color: Colors.white,),
        ),
        Positioned.fill(
          // bottom: 500,
          child: Transform.translate(
            offset: Offset(0, 150),
            child: Image.asset(
              "assets/img/background.png",
              fit: BoxFit.cover,
              alignment: Alignment(0, 0.2),
            ),
          ),
        ),

        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 100,),
                Container(
                  height: 120,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(35),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(35),
                      onTap: () async {
                        dynamic result = await _auth.signInWithGoogle();
                        if (result == null) {
                          print('error signing in');
                        } else {
                          print('signed in');
                          print(result.uid);
                        }
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35),
                          border: Border.all(color: Colors.blue, width: 3),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/img/google.png',
                                width: 30,
                                height: 30,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Sign in with Google',
                                style: TextStyle(
                                  color: Colors.blue.shade900,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  child: TextButton(
                    onPressed: () async {
                      dynamic result = await _auth.signInAnon();
                      if (result == null) {
                        print('error signing in');
                      } else {
                        print('signed in');
                        print(result.uid);
                      }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue.shade900,
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                    ),
                    child: Text('Sign in Anonymously'),
                  ),
                ),
                Text('Гугл вход на айфоне не работает\nВходите анонимно, буквально потратил 2 дня\nэта фигня не решается\n test 8',
                    style:
                TextStyle(color:
                Colors
                    .blue
                    .shade900, fontWeight: FontWeight.w500,
                    shadows: [Shadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 5),), ])),
              ],
            ),
          ),
        ),
      ],
    );
  }
}