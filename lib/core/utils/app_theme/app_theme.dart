import 'package:flutter/material.dart';
import 'package:tobby_reviewer/core/utils/app_theme/text_theme.dart';

class AppTheme {
  static ThemeData themeData() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
      textTheme: textTheme,
    );
  }
}
