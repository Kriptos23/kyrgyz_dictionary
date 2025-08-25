import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: WordScreen(),
    );
  }
}

class WordScreen extends StatefulWidget {
  @override
  State<WordScreen> createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  final TextEditingController _controller = TextEditingController();
  String _result = "";

  Stream<String> streamWordExplanation(String word) async* {
    final url = 'https://api.openai.com/v1/chat/completions';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer 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',
    };
    final body = jsonEncode({
      "model": "gpt-4o-mini",
      "stream": true,
      "messages": [
        {"role": "system", "content": "You are a Kyrgyz language teacher."},
        {"role": "user", "content": "Explain the word '$word' in Kyrgyz with synonyms and examples."}
      ]
    });

    var request = http.Request('POST', Uri.parse(url))
      ..headers.addAll(headers)
      ..body = body;

    var streamedResponse = await request.send();

    if (streamedResponse.statusCode == 200) {
      await for (var line in streamedResponse.stream
          .transform(utf8.decoder)
          .transform(const LineSplitter())) {
        if (line.startsWith('data: ')) {
          final jsonStr = line.substring(6).trim();
          if (jsonStr.isEmpty || jsonStr == '[DONE]') continue;

          try {
            final data = json.decode(jsonStr);
            final delta = data['choices'][0]['delta'];
            if (delta != null && delta['content'] != null) {
              yield delta['content'];
            }
          } catch (e) {
            continue; // skip malformed chunks
          }
        }
      }
    } else {
      yield 'Error: ${streamedResponse.statusCode}';
    }
  }
  void _startStreaming(String word) {
    _result = "";
    setState(() {});

    streamWordExplanation(word).listen((chunk) {
      setState(() {
        _result += chunk; // append as it arrives
      });
    });
  }


  // Future<String> fetchWordExplanation(String word) async {
  //   final url = Uri.parse("https://api.openai.com/v1/chat/completions");
  //
  //   final response = await http.post(
  //     url,
  //     headers: {
  //       "Content-Type": "application/json",
  //       "Authorization": "Bearer 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", // put your real key here
  //     },
  //     body: jsonEncode({
  //       "model": "gpt-4o",
  //       "messages": [
  //         {"role": "system", "content": "You are a Kyrgyz language teacher."},
  //         {"role": "user", "content": "Explain the word '$word' in Kyrgyz with synonyms and examples."},
  //       ],
  //       "stream" : true,
  //     }),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     return data["choices"][0]["message"]["content"];
  //   } else {
  //     // Print error to console
  //     print("Error: ${response.statusCode}");
  //     print(response.body);
  //     return "Error: ${response.statusCode}\n${response.body}";
  //   }
  // }

  // void _getExplanation() async {
  //   final word = _controller.text.trim();
  //   if (word.isEmpty) return;
  //
  //   final explanation = await fetchWordExplanation(word);
  //
  //   final explanation1 = await streamWordExplanation(word);
  //
  //   // Print to console
  //   // print("Explanation for $word:\n$explanation1");
  //
  //   // Update UI
  //   setState(() {
  //     _result = explanation;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kyrgyz Vocab App")),
      body: Padding(
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
              onPressed: (){
                _startStreaming(_controller.text.trim());
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
