import 'package:flutter/material.dart';

import '../constants/color_manager.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
    primary: AppColors.primary,
    secondary: AppColors.mint,
    surface: AppColors.background,
    error: AppColors.error,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.background,
    foregroundColor: AppColors.primary,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
  ),
  cardTheme: CardThemeData(
    color: AppColors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
  ),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: AppColors.white,
    indicatorColor: AppColors.cream,
  ),
);
