import 'package:flutter/material.dart';

extension StringExtension on String {
  String capitalizeEachWord() {
    if (isEmpty) return this;
    List<String> words = split(' ');

    String capitalizedText = words.map((String word) {
      String firstLetter = word.substring(0, 1).toUpperCase();
      String remainingLetters = word.substring(1).toLowerCase();
      return '$firstLetter$remainingLetters';
    }).join(' ');

    return capitalizedText;
  }

  Color statusColor() {
    if (toLowerCase() == 'reported') return Colors.blue[700]!;
    if (toLowerCase() == 'followup' || toLowerCase() == 'follow up') {
      return Colors.yellow[700]!;
    }
    if (toLowerCase() == 'reviewed & approved') return Colors.green[600]!;
    if (toLowerCase() == 'rejected') return Colors.redAccent;
    return Colors.grey;
  }

  String appendLetter() {
    int currentCharCode = codeUnitAt(0);
    int nextCharCode = currentCharCode + 1;
    String nextLetter = String.fromCharCode(nextCharCode);
    return nextLetter;
  }
}
