import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle display = GoogleFonts.merriweather(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle pageHeading = GoogleFonts.merriweather(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle sectionHeading = GoogleFonts.merriweather(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle cardHeading = GoogleFonts.merriweather(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle body = GoogleFonts.lato(
    fontSize: 15,
    color: AppColors.textPrimary,
  );

  static TextStyle caption = GoogleFonts.lato(
    fontSize: 13,
    color: AppColors.textSecondary,
  );
}
