import 'package:flutter/material.dart';

import '../constants/color_manager.dart';

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.mint,
    brightness: Brightness.dark,
    primary: AppColors.mint,
    secondary: AppColors.peach,
    surface: const Color(0xFF202124),
  ),
  scaffoldBackgroundColor: const Color(0xFF171819),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF171819),
    surfaceTintColor: Colors.transparent,
    elevation: 0,
  ),
);
