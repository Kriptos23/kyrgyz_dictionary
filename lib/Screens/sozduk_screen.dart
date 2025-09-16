import 'package:flutter/material.dart';
import '../api_service.dart';
import 'package:flutter/cupertino.dart';
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

  List<String> languageOptions = <String>["Kyrgyz", "Russian", "English"];

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

  ///METHODS
  @override
  void initState() {
    selectedLanguage = languageOptions.first;
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
    return Scaffold(
      appBar: AppBar
        (
          title: Text("Kyrgyz Vocab App"),
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
                });
              },
              underline: Container(color: Colors.deepPurple, height: 3,),
            )
          ]
      ),
      bottomNavigationBar: bottomNavBarWidget.buildBottomNavBar(context, setState),
      body: Padding
        (
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Enter a Kyrgyz word",
                border: OutlineInputBorder(),

              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                _startStreaming(_controller.text.trim(), selectedLanguage!);
              },
              child: Text("Get Explanation"),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _result,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
