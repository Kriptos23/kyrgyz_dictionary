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



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Sign In"),),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: ElevatedButton(child: Text('Sign in Anonymously'),
                  onPressed: ()async{
                    dynamic result = await _auth.signInAnon();//method from auth.dart, should return null or OurUser obj
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
