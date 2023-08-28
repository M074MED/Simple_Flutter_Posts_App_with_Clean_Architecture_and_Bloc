import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static final appTheme = ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryColor,
      ),
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: AppColors.primaryColor),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.secondaryColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
          floatingLabelStyle: const TextStyle(color: AppColors.primaryColor),
          iconColor: AppColors.secondaryColor,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.secondaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(8),
          )));
}
