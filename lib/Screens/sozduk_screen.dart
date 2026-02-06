
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

class _SozdukScreenState extends State<SozdukScreen>
{
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

  int whatLanguage(String langCode){
    if(langCode == 'ky'){
      return 0;
    }
    else if(langCode == 'ru'){
      return 1;
    }else{
      return 2;
    }
  }


  ///METHODS
  @override
  void initState() {

  }

  void _startStreaming(String word, String language) {
    _result = "";
    setState(() {});

    ApiService.streamWordExplanation(word, language).listen((chunk) {
      setState(() {
        _result += chunk; // append as it arrives
      });
    });
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
    // selectedLanguage = languageOptions[whatLanguage(langCode)];
    return
      Scaffold(
      appBar: AppBar
        (
          title: const Text("Kyrgyz Vocab App Demo"),
          actions: <Widget>
          [
            DropdownButton
              (
              
              value: selectedLanguage,
              items: languageOptions.map<DropdownMenuItem<String>>((String value)
              {
                return DropdownMenuItem<String>(value: value, child: Text(value));
              }).toList(),
              onChanged: (String? value){
                setState(() {
                  selectedLanguage = value!;
                  if(value=="Kyrgyz") context.setLocale(Locale('ky'));
                  else if(value=="Russian") context.setLocale(Locale('ru'));
                  else context.setLocale(Locale('en'));


                  // SystemNavigator.pop();
                  // final engine = WidgetsFlutterBinding.ensureInitialized();
                  // engine.performReassemble();
                });
              },
              underline: Container(color: Colors.blue, height: 3,),
            )
          ]
      ),
      // bottomNavigationBar: bottomNavBarWidget.buildBottomNavBar(context, setState),
      body:
      Padding
        (
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              LocaleKeys.greeting.tr(),
              style: const TextStyle(fontSize: 16),
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: LocaleKeys.gpt_text_field.tr(),
                border: const OutlineInputBorder(),

              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                _startStreaming(_controller.text.trim(), selectedLanguage!);
              },
              child: const Text("Get Explanation"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _result,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
