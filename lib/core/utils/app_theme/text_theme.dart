import 'package:flutter/material.dart';

const String kprimaryFont = 'Poppins';

TextTheme textTheme = const TextTheme(
  displayLarge: TextStyle(
    fontFamily: kprimaryFont,
    fontWeight: FontWeight.normal,
    fontSize: 57.0,
  ),
  displayMedium: TextStyle(
    fontFamily: kprimaryFont,
    fontWeight: FontWeight.normal,
    fontSize: 45.0,
  ),
  displaySmall: TextStyle(
    fontFamily: kprimaryFont,
    fontWeight: FontWeight.normal,
    fontSize: 32.0,
  ),
  headlineLarge: TextStyle(
    fontFamily: kprimaryFont,
    fontWeight: FontWeight.normal,
    fontSize: 32.0,
  ),
  headlineMedium: TextStyle(
    fontFamily: kprimaryFont,
    fontWeight: FontWeight.w500,
    fontSize: 28.0,
  ),
  headlineSmall: TextStyle(
    fontFamily: kprimaryFont,
    fontWeight: FontWeight.w500,
    fontSize: 20.0,
  ),
  titleLarge: TextStyle(
    fontFamily: kprimaryFont,
    fontWeight: FontWeight.w500,
    fontSize: 22.0,
  ),
  titleMedium: TextStyle(
    fontFamily: kprimaryFont,
    fontWeight: FontWeight.w500,
    fontSize: 20.0,
  ),
  titleSmall: TextStyle(
    fontFamily: kprimaryFont,
    fontWeight: FontWeight.normal,
    fontSize: 18.0,
  ),
  labelLarge: TextStyle(
    fontFamily: kprimaryFont,
    fontWeight: FontWeight.w500,
    fontSize: 14.0,
  ),
  labelMedium: TextStyle(
    fontFamily: kprimaryFont,
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
  ),
  labelSmall: TextStyle(
    fontFamily: kprimaryFont,
    fontWeight: FontWeight.w500,
    fontSize: 11.0,
  ),
  bodyLarge: TextStyle(
    fontFamily: kprimaryFont,
    fontWeight: FontWeight.normal,
    fontSize: 16.0,
  ),
  bodyMedium: TextStyle(
    fontFamily: kprimaryFont,
    fontWeight: FontWeight.normal,
    fontSize: 15.0,
  ),
  bodySmall: TextStyle(
    fontFamily: kprimaryFont,
    fontWeight: FontWeight.normal,
    fontSize: 14.0,
  ),
);

class TextStyles {
  const TextStyles._();

  static const TextStyle _baseTextStyle = TextStyle(
    fontFamily: 'Poppins',
  );

  static final h3 = _baseTextStyle.copyWith(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
}
