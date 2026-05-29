import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Coffee + Beige trading theme
  // Core palette (source of truth)
  static const Color espresso = Color(0xFF3E2010);
  static const Color coffee = Color(0xFF6F4E37);
  static const Color caramel = Color(0xFFC08552);
  static const Color honey = Color(0xFFEEC373);
  static const Color biscuit = Color(0xFFF4DFBA);
  static const Color cream = Color(0xFFFBF0E3);
  static const Color ivory = Color(0xFFFBF6EF);

  // Semantic colors
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF3B2F2A);
  static const Color textSecondary = Color(0xFF6B5B53);
  static const Color error = Color(0xFFB00020);

  // Backwards-compatible aliases
  static Color get primary => coffee;
  static Color get secondary => biscuit;
  static Color get accent => caramel;
  static Color get success => const Color(0xFF5E8C61);
  static Color get background => ivory;

  // Legacy names kept for compatibility
  static Color get warmBeige => biscuit;
  static Color get deepAmber => caramel;
  static Color get oliveGreen => success;
  static Color get softCream => cream;

  // On colors
  static const Color _onPrimary = Color(0xFFFFFFFF);
  static Color get onPrimary => _onPrimary;
  static Color get onBackground => textPrimary;

  // Chart palette (use in order)
  static const List<Color> chartPalette = [
    caramel,
    honey,
    Color(0xFFA67B5B), // mocha
    Color(0xFF5C7A45), // sage green
    coffee,
    Color(0xFFD4956A), // lighter caramel
  ];
}
