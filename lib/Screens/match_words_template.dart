import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kyrgyz_dictionary/widgets/word_match.dart';
import '../classes/words_class.dart';

class MatchWordsTemplate extends StatefulWidget {
  const MatchWordsTemplate({super.key, required this.listOfWords});

  final List<Words> listOfWords;

  @override
  State<MatchWordsTemplate> createState() => _MatchWordsTemplateState();
}

class _MatchWordsTemplateState extends State<MatchWordsTemplate> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(12),
                children: widget.listOfWords.map((word) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: WordMatch(
                      text1: word.word ?? '',
                    ),
                  );
                }).toList(),

              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(12),
                children: widget.listOfWords.map((word) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: WordMatch(
                      text1: word.rusTrans?.tr() ?? '',
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}