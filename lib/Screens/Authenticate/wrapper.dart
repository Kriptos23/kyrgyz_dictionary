import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kyrgyz_dictionary/Screens/Authenticate/my_profile.dart';
import 'package:kyrgyz_dictionary/Screens/Authenticate/select_language.dart';
import 'package:kyrgyz_dictionary/Screens/Authenticate/sign_in.dart';
import 'package:kyrgyz_dictionary/Screens/sozduk_screen.dart';
import 'package:kyrgyz_dictionary/classes/our_user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Navigation.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  Future<bool> _isLanguageSelected() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLanguageSelected') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<OurUser?>(context);

    if(user == null){
      // GoogleSignIn.instance.initialize();
      return SignIn();
    }

    return FutureBuilder<bool>(
      future: _isLanguageSelected(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        bool selected = snapshot.data!;

        if (!selected) {
          return SelectLanguage();
        }

        return Navigation();
      },
    );


  }
}
