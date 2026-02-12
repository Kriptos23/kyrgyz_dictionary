import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kyrgyz_dictionary/Screens/Authenticate/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/locale_keys.g.dart';
import '../Navigation.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({super.key});

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  List<String> languageOptions = <String>["Kyrgyz", "Russian", "English"];

  String? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(LocaleKeys.select_language.tr())),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50, width: MediaQuery.of(context).size.width,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.language, color: Colors.blue.shade800,),
                SizedBox(
                  width: 250, // width you want
                  height: 60, // height you want
                  child: DropdownButton
                    (
                    value: selectedLanguage,
                    hint: Text(LocaleKeys.language.tr()),
                    items: languageOptions.map<DropdownMenuItem<String>>((String value)
                    {
                      return DropdownMenuItem<String>(value: value, child: Row(
                        children: [
                          SizedBox(width: 10,),
                          Text(value, style: TextStyle(fontSize: 20),),
                        ],
                      )
                      );
                    }).toList(),
                    isExpanded: true, // important to fill width
                    onChanged: (String? value){
                      setState(() {
                        selectedLanguage = value!;
                        if(value=="Kyrgyz") context.setLocale(Locale('ky'));
                        else if(value=="English") context.setLocale(Locale('en'));
                        else context.setLocale(Locale('ru'));
                        // final engine = WidgetsFlutterBinding.ensureInitialized();
                        // engine.performReassemble();
                      });
                    },
                    underline: Container(color: Colors.blue, height: 3,),
                  ),
                ),
              ],
            ),
        GestureDetector(
          onTap: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isLanguageSelected', true);

            // reload wrapper
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => Wrapper()),
            );
          },
          child: Text("Continue", style: TextStyle(color: Colors.blue.shade900, fontSize: 18, fontWeight: FontWeight.w400),),
        )
          ],
        ),
      ),
    );
  }
}
