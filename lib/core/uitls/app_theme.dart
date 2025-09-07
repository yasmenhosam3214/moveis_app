import 'package:flutter/material.dart';
import 'package:moveis_app/core/uitls/app_colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.primary,
      centerTitle: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: AppColors.white,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.gray),
        borderRadius: BorderRadius.circular(16),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.gray),
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    textTheme: TextTheme(
      titleSmall: TextStyle(color: AppColors.primary, fontSize: 16),
      titleMedium: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w200,
        fontSize: 14,
      ),
    ),
  );
}
