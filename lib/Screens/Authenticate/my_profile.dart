import 'package:flutter/material.dart';
import 'package:kyrgyz_dictionary/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/botttom_nav_bar_widget.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

AuthService _auth = AuthService(); //auth obj from our self-made class to use sign-in functions
BottomNavBar bottomNavBarWidget = BottomNavBar(2); //Working Bottom Nav Bar from our self-made class

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Menin Profilim"),
        ),
        // bottomNavigationBar: bottomNavBarWidget.buildBottomNavBar(context, setState),
        body: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: ElevatedButton(
                    child: const Text('Log Out'),
                    onPressed: () async {
                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.remove('isLanguageSelected');
                      dynamic result = await _auth.signOut(); //method from auth.dart, should return null or OurUser obj
                      // if(result == null) {
                      //   Navigator.pushNamed(context, '/sign_in');
                      // }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
