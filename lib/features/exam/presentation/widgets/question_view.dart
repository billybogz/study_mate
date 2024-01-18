import 'package:flutter/material.dart';
import 'package:tobby_reviewer/core/extensions/string_extension.dart';

class QuestionView extends StatelessWidget {
  const QuestionView(this.question, {super.key});

  final String question;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 0),
      child: Text(
        question.capitalizeFirstLetter(),
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
