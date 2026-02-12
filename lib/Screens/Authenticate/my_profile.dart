import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kyrgyz_dictionary/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../generated/locale_keys.g.dart';
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: GestureDetector(
                    child: Container(
                      width: 100,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          // color: Color(0xFFDAD8D8),
                          // color: niceColor,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35),
                          border: Border.all(color: Colors.red, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child:

                            Text(LocaleKeys.sign_out.tr(), style: TextStyle(color: Colors.black, fontWeight: FontWeight
                                .w400, shadows: [Shadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 5),), ]),),
                          ),
                    onTap: () async {
                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.remove('isLanguageSelected');
                      dynamic result = await _auth.signOut(); //method from auth.dart, should return null or OurUser obj
                      // if(result == null) {
                      //   Navigator.pushNamed(context, '/sign_in');
                      // }
                    }),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
