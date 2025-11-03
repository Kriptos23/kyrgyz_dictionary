import 'package:flutter/material.dart';
import 'package:kyrgyz_dictionary/services/auth.dart';

import '../../widgets/botttom_nav_bar_widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthService _auth = AuthService();//auth obj from our self-made class to use sign-in functions

  BottomNavBar bottomNavBarWidget = BottomNavBar(2);//Working Bottom Nav Bar from our self-made class

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Sign In"),),
        bottomNavigationBar: bottomNavBarWidget.buildBottomNavBar(context, setState),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: ElevatedButton(child: Text('Sign in Anonymously'),
                  onPressed: ()async{
                    dynamic result = await _auth.signInAnon();//method from auth.dart
                    if(result == null){
                      print('error signing in');
                    }else{
                      print('signed in');
                      print(result.uid);
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
