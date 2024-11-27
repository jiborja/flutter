import 'package:flutter/material.dart';
import 'package:presentation/shared/borders.dart';

const kFontPathWayGothicOne = 'Pathway Gothic One';

class MovieColors {
  static const int _primaryColor = 0xffa50012;
  static const primaryColor = MaterialColor(_primaryColor, {
    50: Color(0xfff4e0e3),
    100: Color(0xFFe4b3b8),
    200: Color(0xFFd28089),
    300: Color(0xFFc04d59),
    400: Color(0xFFb32636),
    500: Color(_primaryColor),
    600: Color(0xFF9d0010),
    700: Color(0xFF93000d),
    800: Color(0xFF8a000a),
    900: Color(0xFF790005),
  });
  static const backgroundColor = Color(0xFF29292D);
}

final ligthTheme = ThemeData(
  scaffoldBackgroundColor: MovieColors.backgroundColor,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: MovieColors.primaryColor).copyWith(
    primary: MovieColors.primaryColor,
    secondary: const Color(0xFF008EAA),
    tertiary: const Color(0xFF002857),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 28,
      fontFamily: kFontPathWayGothicOne,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displayMedium: TextStyle(
      fontSize: 24,
      fontFamily: kFontPathWayGothicOne,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.18,
    ),
    displaySmall: TextStyle(
      fontSize: 20,
      fontFamily: kFontPathWayGothicOne,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontFamily: kFontPathWayGothicOne,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontFamily: kFontPathWayGothicOne,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontFamily: kFontPathWayGothicOne,
      fontWeight: FontWeight.normal,
      color: Color(0xB3FFFFFF),
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontFamily: kFontPathWayGothicOne,
      fontWeight: FontWeight.normal,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontFamily: kFontPathWayGothicOne,
      fontWeight: FontWeight.normal,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontFamily: kFontPathWayGothicOne,
      fontWeight: FontWeight.normal,
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      fontFamily: kFontPathWayGothicOne,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.42,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontFamily: kFontPathWayGothicOne,
      fontWeight: FontWeight.normal,
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      fontFamily: kFontPathWayGothicOne,
      fontWeight: FontWeight.normal,
      letterSpacing: 1.5,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: const TextStyle(color: MovieColors.primaryColor, fontSize: 15),
    border: textFieldBorderDecoration,
    focusedBorder: textFieldBorderDecoration,
    enabledBorder: textFieldBorderDecoration,
  ),
);
