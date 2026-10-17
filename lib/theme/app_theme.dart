import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  // Primary base colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color secondarySurface = Color(0xFFF8F9FA);
  static const Color cardSurface = Color(0xFFFFFFFF);

  // Brand Accents
  static const Color mint = Color(0xFF63D6C4);
  static const Color darkNav = Color(0xFF0F0F12);
  static const Color deepPurple = Color(0xFF371B83);
  static const Color orangePrice = Color(0xFFFF6B00);
  static const Color discountRed = Color(0xFFFF4D4D);
  static const Color goldYellow = Color(0xFFFFB800);

  // Soft Pastels
  static const Color pastelLavender = Color(0xFFF3F0FA);
  static const Color pastelMint = Color(0xFFE2F5EA);
  static const Color pastelBlue = Color(0xFFE8F5FB);
  static const Color pastelYellow = Color(0xFFFFF7D9);
  static const Color pastelPink = Color(0xFFFDECEF);
  static const Color pastelPeach = Color(0xFFFFF0E6);

  // Text Colors
  static const Color textPrimary = Color(0xFF111111);
  static const Color textSecondary = Color(0xFF9E9E9E);
  static const Color textMuted = Color(0xFFB0B0B8);
  static const Color inputBackground = Color(0xFFF5F6F8);
  static const Color dividerColor = Color(0xFFEEEEF2);

  // Shadows
  static List<BoxShadow> get softShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ];

  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: const Color(0xFF0F0F12).withValues(alpha: 0.06),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ];

  static List<BoxShadow> get mintGlow => [
        BoxShadow(
          color: mint.withValues(alpha: 0.35),
          blurRadius: 18,
          offset: const Offset(0, 6),
        ),
      ];
}

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.mint,
        primary: AppColors.mint,
        surface: AppColors.background,
        brightness: Brightness.light,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
        displayLarge: GoogleFonts.plusJakartaSans(
          fontSize: 30,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
          letterSpacing: -0.5,
        ),
        headlineMedium: GoogleFonts.plusJakartaSans(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -0.3,
        ),
        titleMedium: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          color: AppColors.textSecondary,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
