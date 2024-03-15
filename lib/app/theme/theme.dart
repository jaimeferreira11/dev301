import 'package:flutter/material.dart';
import 'package:test_mobile_itae/app/theme/app_colors.dart';
import 'package:test_mobile_itae/app/theme/app_fonts.dart';

class MyTheme {
  static ThemeData buildDefaultTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        primary: AppColors.primaryColor,
        secondary: AppColors.accentColor,
        // brightness: Brightness.dark,
      ),
      textTheme: AppFonts.primaryFont.copyWith(),
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: AppColors.accentColor),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.accentColor,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
