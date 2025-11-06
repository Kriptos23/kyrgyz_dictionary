import 'package:flutter/material.dart';
import 'package:kyrgyz_dictionary/Screens/Authenticate/my_profile.dart';
import 'package:kyrgyz_dictionary/Screens/Authenticate/sign_in.dart';
import 'package:kyrgyz_dictionary/Screens/sozduk_screen.dart';
import 'package:kyrgyz_dictionary/classes/our_user.dart';
import 'package:provider/provider.dart';

import '../Navigation.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<OurUser?>(context);

    if(user == null){
      return SignIn();
    }
    else{
      return Navigation();
    }
  }
}
