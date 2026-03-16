import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const bg        = Color(0xFF0D0D0D);
  static const surface   = Color(0xFF1A1A1A);
  static const card      = Color(0xFF222222);
  static const accent    = Color(0xFF00E5BE);   // teal-mint
  static const accentDim = Color(0xFF00B89A);
  static const error     = Color(0xFFFF4D6A);
  static const success   = Color(0xFF00C98D);
  static const warning   = Color(0xFFFFB545);
  static const textPri   = Color(0xFFF5F5F5);
  static const textSec   = Color(0xFF9E9E9E);
  static const divider   = Color(0xFF2C2C2C);
}

class AppTheme {
  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.bg,
    colorScheme: const ColorScheme.dark(
      background: AppColors.bg,
      surface: AppColors.surface,
      primary: AppColors.accent,
      secondary: AppColors.accentDim,
      error: AppColors.error,
    ),
    textTheme: GoogleFonts.cairoTextTheme(
      const TextTheme(
        displayLarge:  TextStyle(color: AppColors.textPri, fontWeight: FontWeight.w700, fontSize: 28),
        headlineMedium:TextStyle(color: AppColors.textPri, fontWeight: FontWeight.w600, fontSize: 22),
        titleLarge:    TextStyle(color: AppColors.textPri, fontWeight: FontWeight.w600, fontSize: 18),
        titleMedium:   TextStyle(color: AppColors.textPri, fontWeight: FontWeight.w500, fontSize: 16),
        bodyLarge:     TextStyle(color: AppColors.textPri, fontSize: 15),
        bodyMedium:    TextStyle(color: AppColors.textSec, fontSize: 14),
        labelLarge:    TextStyle(color: AppColors.textPri, fontWeight: FontWeight.w600, fontSize: 15),
      ),
    ),
    cardColor: AppColors.card,
    dividerColor: AppColors.divider,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.bg,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.textPri),
      titleTextStyle: TextStyle(
        color: AppColors.textPri, fontSize: 18,
        fontWeight: FontWeight.w600, fontFamily: 'Cairo',
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.bg,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, fontFamily: 'Cairo'),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.accent,
        side: const BorderSide(color: AppColors.accent, width: 1.5),
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
  );
}
