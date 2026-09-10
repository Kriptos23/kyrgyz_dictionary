import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kyrgyz_dictionary/generated/locale_keys.g.dart';
import '../services/api_service.dart';
import '../widgets/botttom_nav_bar_widget.dart';

class SozdukScreen extends StatefulWidget {
  const SozdukScreen({super.key});

  @override
  State<SozdukScreen> createState() => _SozdukScreenState();
}

class _SozdukScreenState extends State<SozdukScreen> {
  ///VARIABLES
  String _result = "";

  List<String> languageOptions = <String>["Кыргызча", "Русский", "English"];

  String? selectedLanguage;

  final TextEditingController _controller = TextEditingController();

  BottomNavBar bottomNavBarWidget = BottomNavBar(0);

  // int _currentIndex = 0;
  // final List<String> _routes = ['/', '/sozdor'];
  // void _onTabTapped(int index) {
  //   if (index != _currentIndex) {
  //     setState(() => _currentIndex = index);
  //     Navigator.pushReplacementNamed(context, _routes[index]);
  //   }
  // }

  int whatLanguage(String langCode) {
    if (langCode == 'ky') {
      return 0;
    } else if (langCode == 'ru') {
      return 1;
    } else {
      return 2;
    }
  }

  ///METHODS
  @override
  void initState() {}

  void _startStreaming(String word, String language) {
    _result = "";
    setState(() {});

    ApiService.streamWordExplanation4(word, language).listen(
          (chunk) {
        print("CHUNK: $chunk");

        if (!mounted) return;

        setState(() {
          _result += chunk;
        });
      },
      onError: (error, stackTrace) {
        print("STREAM ERROR: $error");
        print(stackTrace);
      },
      onDone: () {
        print("STREAM FINISHED");
      },
    );
  }

  void _startStreaming2(String word, String language) {
    _result = "";
    setState(() {});

    ApiService.streamWordExplanation2(word, language).listen((chunk) {
      setState(() {
        _result += chunk; // append as it arrives
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String langCode = context.locale.languageCode;
    selectedLanguage = languageOptions[whatLanguage(langCode)];
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
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                  title: const Text("Daniel Kuvan Kyrgyz Vocab App Demo"),
                  backgroundColor: Color(0xFFF0F0F0),
                  actions: <Widget>[
                    DropdownButton(
                      value: selectedLanguage,
                      items: languageOptions
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedLanguage = value!;
                          if (value == "Кыргызча")
                            context.setLocale(Locale('ky'));
                          else if (value == "Русский")
                            context.setLocale(Locale('ru'));
                          else
                            context.setLocale(Locale('en'));
                          // SystemNavigator.pop();
                          // final engine = WidgetsFlutterBinding.ensureInitialized();
                          // engine.performReassemble();
                        });
                      },
                      underline: Container(
                        color: Colors.blue,
                        height: 3,
                      ),
                    )
                  ]),
              // bottomNavigationBar: bottomNavBarWidget.buildBottomNavBar(context, setState),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      LocaleKeys.greeting.tr(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                      child: Text(
                        LocaleKeys.gpt_caution.tr(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.gpt_text_field.tr(),
                        border: const OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.black)),
                      onPressed: () {
                        _startStreaming(
                            _controller.text.trim(), selectedLanguage!);
                      },
                      child: Text(
                        LocaleKeys.get_explanation.tr(),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          _result,
                          style: TextStyle(
                            fontSize: 16,
                            shadows: [
                            Shadow(
                              blurRadius: 1,
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(0, 0.5),
                            )
                          ]
                          ),

                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
