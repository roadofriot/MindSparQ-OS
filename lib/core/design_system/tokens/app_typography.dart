import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Complete Design System Typography for MindSparQ OS
/// Based strictly on Inter font tokens from DESIGN.md and Stitch Project 13746084714856879502
class AppTypography {
  // Light Mode Styles
  static TextStyle displayLg = GoogleFonts.inter(
    fontSize: 48,
    height: 56 / 48,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.02 * 48,
    color: AppColors.onSurface,
  );

  static TextStyle headlineLg = GoogleFonts.inter(
    fontSize: 32,
    height: 40 / 32,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.01 * 32,
    color: AppColors.onSurface,
  );

  static TextStyle headlineMd = GoogleFonts.inter(
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.01 * 24,
    color: AppColors.onSurface,
  );

  static TextStyle bodyLg = GoogleFonts.inter(
    fontSize: 17,
    height: 26 / 17,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.01 * 17,
    color: AppColors.onSurface,
  );

  static TextStyle bodyMd = GoogleFonts.inter(
    fontSize: 15,
    height: 22 / 15,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    color: AppColors.onSurface,
  );

  static TextStyle labelMd = GoogleFonts.inter(
    fontSize: 13,
    height: 18 / 13,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.01 * 13,
    color: AppColors.onSurface,
  );

  static TextStyle labelSm = GoogleFonts.inter(
    fontSize: 11,
    height: 16 / 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.03 * 11,
    color: AppColors.onSurfaceVariant,
  );

  // Dark Mode Style Variants
  static TextStyle displayLgDark = displayLg.copyWith(color: AppColors.darkOnSurface);
  static TextStyle headlineLgDark = headlineLg.copyWith(color: AppColors.darkOnSurface);
  static TextStyle headlineMdDark = headlineMd.copyWith(color: AppColors.darkOnSurface);
  static TextStyle bodyLgDark = bodyLg.copyWith(color: AppColors.darkOnSurface);
  static TextStyle bodyMdDark = bodyMd.copyWith(color: AppColors.darkOnSurface);
  static TextStyle labelMdDark = labelMd.copyWith(color: AppColors.darkOnSurface);
  static TextStyle labelSmDark = labelSm.copyWith(color: AppColors.darkOnSurfaceVariant);

  // Bilingual / Devanagari text styling with extra vertical headroom
  static TextStyle nepali(TextStyle baseStyle) {
    return baseStyle.copyWith(
      height: (baseStyle.height ?? 1.2) + 0.1,
    );
  }
}
