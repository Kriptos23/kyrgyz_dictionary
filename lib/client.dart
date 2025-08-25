// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// Future<String> fetchWordExplanation(String word) async {
//   final url = Uri.parse("https://api.openai.com/v1/chat/completions");
//
//   final response = await http.post(
//     url,
//     headers: {
//       "Content-Type": "application/json",
//       "Authorization": "Bearer YOUR_API_KEY",
//     },
//     body: jsonEncode({
//       "model": "gpt-4o-mini",
//       "messages": [
//         {"role": "system", "content": "You are a Kyrgyz language teacher."},
//         {"role": "user", "content": "Explain the word '$word' in Kyrgyz with synonyms and examples."},
//       ],
//     }),
//   );
//
//   final data = jsonDecode(response.body);
//   print(data["choices"][0]["message"]["content"]);
//   return data["choices"][0]["message"]["content"];
// }
//
