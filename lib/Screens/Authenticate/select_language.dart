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
  List<String> languageOptions = <String>["Кыргыз", "Русский", "English"];

  String? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.white,
          ),
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
        Positioned(
          top: 550,
          left: 20,
          child: Image.asset(
            "assets/img/snow_leopard.png",
            width: 300,
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Center(child: Text(LocaleKeys.select_language.tr())),
              backgroundColor: Color(0xFFF0F0F0),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                ),
                SizedBox(
                  width: 250, // width you want
                  height: 60, // height you want
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.blue.shade100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(24),
                        dropdownColor: Colors.white,
                        icon: Icon(
                          Icons.language,
                          color: Colors.blue.shade800,
                        ),
                        value: selectedLanguage,
                        hint: Text(LocaleKeys.language.tr()),
                        items: languageOptions
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    value,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ));
                        }).toList(),
                        isExpanded: true,
                        // important to fill width
                        onChanged: (String? value) {
                          setState(() {
                            selectedLanguage = value!;
                            if (value == "Кыргыз")
                              context.setLocale(Locale('ky'));
                            else if (value == "English")
                              context.setLocale(Locale('en'));
                            else
                              context.setLocale(Locale('ru'));
                            // final engine = WidgetsFlutterBinding.ensureInitialized();
                            // engine.performReassemble();
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('isLanguageSelected', true);

                    // reload wrapper
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => Wrapper()),
                    );
                  },
                  child: Text("Continue",
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
