import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService{


  static Stream<String> streamWordExplanation(String word, String language) async* {
    const url = 'https://api.openai.com/v1/chat/completions';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer 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',
    };
    final body = jsonEncode({
      "model": "gpt-4o-mini", //-4o-mini
      "stream": true,
      "messages": [
        {"role": "system", "content": "You are a Kyrgyz language teacher."},
        {
          "role": "user",
          "content": "Explain the word $word from Kyrgyz language chatting with user in $language language, "
              "provide synonyms and examples in kyrgyz language. If word is not from kyrgyz language, then you show message "
              "saying "
              "this"
              " is not a kyrgyz word. Always check if the word is from Kyrgyz language, this is crucial, if not say this is not"
              " from kyrgyz language and provide translation to kyrgyz"//prompt
        }
      ]
    });

    var request = http.Request('POST', Uri.parse(url))
      ..headers.addAll(headers)
      ..body = body;

    var streamedResponse = await request.send();

    if (streamedResponse.statusCode == 200) {
      await for (var line in streamedResponse.stream.transform(utf8.decoder).transform(const LineSplitter())) {
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
      final errorBody = await streamedResponse.stream.bytesToString();
      yield 'Error: ${streamedResponse.statusCode}: $errorBody';
      print('Эу '
          'гдееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееее'
          'ееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееее');
      print(streamedResponse.request);
    }
  }

  ///This methods supposed to use prompt with responses instead of chat completions but not working
  static Stream<String> streamWordExplanation2(String word, String language) async* {
    const url = 'https://api.openai.com/v1/responses';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer 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',
    };
    final body = jsonEncode({
      "model": "gpt-4o-mini", //-4o-mini
      "stream": true,
      "prompt": {
        "id": "pmpt_68b0ee1bd4d08195b4b02fb03ce446c40feef3a8dd85221f",
        "version": "2",
        "variables": {"word": word, "language": language}
      },
    });

    var request = http.Request('POST', Uri.parse(url))
      ..headers.addAll(headers)
      ..body = body;

    var streamedResponse = await request.send();

    if (streamedResponse.statusCode != 200) {
      final errorBody = await streamedResponse.stream.bytesToString();
      yield 'Error ${streamedResponse.statusCode}: $errorBody';
      return;
    }

    // Read streaming chunks
    await for (var line in streamedResponse.stream.transform(utf8.decoder).transform(const LineSplitter())) {
      if (!line.startsWith('data: ')) continue;
      final jsonStr = line.substring(6).trim();
      if (jsonStr.isEmpty || jsonStr == '[DONE]') continue;

      try {
        final data = json.decode(jsonStr);

        // ⚡ Correct parser for Responses API streaming
        if (data['type'] == 'output_text.delta' && data['delta'] != null) {
          yield data['delta'];
        }
      } catch (_) {
        continue; // skip malformed chunks
      }
    }
  }

  //gpt 5 - much better yet pricy
  static Stream<String> streamWordExplanation3(String word, String language) async* {
    const url = 'https://api.openai.com/v1/responses';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer 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',
    };
    final body = jsonEncode({
      "model": "gpt-5",
      "reasoning": { "effort": "minimal" }, // keeps it faster
      // "max_output_tokens": 200,             // VERY important for speed
      "stream": true,
      "input": [
        {
          "role": "system",
          "content": """
You are a professional Kyrgyz linguist.
If unsure, say you are unsure.
"""
        },
        {
          "role": "user",
          "content": """
Explain the word $word from Kyrgyz language chatting with user in $language language, 
provide 3 synonyms and 3 examples in kyrgyz language. If word is not from kyrgyz language, 
then you show message saying this is not a kyrgyz word. 
Shortly give possible source if possible, if not skip.
Very brief fun facts.
Always check if the word is from Kyrgyz language, this is crucial, if not say this is 
              not from kyrgyz language and provide translation to kyrgyz

If the word is NOT Kyrgyz:
Say: "This is not a Kyrgyz word."
Then provide its translation into Kyrgyz.
"""
        }
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

            if (data['type'] == 'response.output_text.delta') {
              final delta = data['delta'];
              if (delta != null) {
                yield delta;
              }
            }

          } catch (e) {
            continue;
          }
        }
      }
    } else {
      final errorBody = await streamedResponse.stream.bytesToString();
      yield 'Error: ${streamedResponse.statusCode}: $errorBody';
      print('Эу '
          'гдееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееее'
          'ееееееееееееееееееееееееееееееееееееееееееееееееееееееееееееее');
      print(streamedResponse.request);
    }
  }

/// this is old method which gives chatgpt responce as a whole block, gotta wait a lot, kept for reference
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

}