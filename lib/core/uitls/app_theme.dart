import 'package:flutter/material.dart';

class AppTheme {
  static const Color background = Color(0xff121312);
  static const Color primary = Color(0xFFF6BD00);
  static const Color black = Color(0xFF121312);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray = Color(0xFF282A28);
  static const Color red = Color(0xFFE82626);
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: background,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: background,
      foregroundColor: primary,
      centerTitle: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: white,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: gray),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: gray),
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    textTheme: TextTheme(
      titleSmall: TextStyle(color: primary, fontSize: 16),
      titleMedium: TextStyle(
        color: white,
        fontWeight: FontWeight.w200,
        fontSize: 14,
      ),
    ),
  );
}
