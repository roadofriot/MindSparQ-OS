import 'package:flutter/material.dart';
import '../tokens/app_colors.dart';
import '../tokens/app_radii.dart';
import '../tokens/app_spacing.dart';
import '../tokens/app_typography.dart';

/// Dark Mode Inversion Theme for MindSparQ OS
ThemeData buildDarkTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: AppColors.primaryFixedDim,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primaryFixedDim,
      onPrimary: Color(0xFF001B3E),
      primaryContainer: AppColors.primary,
      onPrimaryContainer: AppColors.onPrimaryContainer,
      secondary: Color(0xFFC7C6CB),
      onSecondary: Color(0xFF1A1B1F),
      secondaryContainer: Color(0xFF46464B),
      onSecondaryContainer: Color(0xFFE3E2E7),
      tertiary: AppColors.tertiaryFixed,
      onTertiary: Color(0xFF341100),
      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      errorContainer: Color(0xFF93000A),
      onErrorContainer: Color(0xFFFFDAD6),
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkOnSurface,
      outline: AppColors.darkOutline,
      outlineVariant: AppColors.darkOutlineVariant,
    ),
    cardTheme: CardThemeData(
      color: AppColors.darkCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.darkOutlineVariant, width: 1.0),
        borderRadius: AppRadii.roundedCard,
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.darkCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.darkOutlineVariant, width: 1.0),
        borderRadius: AppRadii.roundedCard,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.darkSurface,
      elevation: 16,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkCard,
      contentPadding: AppSpacing.inputPadding,
      border: OutlineInputBorder(
        borderRadius: AppRadii.roundedLg,
        borderSide: const BorderSide(color: AppColors.darkOutlineVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadii.roundedLg,
        borderSide: const BorderSide(color: AppColors.darkOutlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadii.roundedLg,
        borderSide: const BorderSide(color: AppColors.primaryFixedDim, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppRadii.roundedLg,
        borderSide: const BorderSide(color: Color(0xFFFFB4AB)),
      ),
      hintStyle: AppTypography.bodyMdDark.copyWith(
        color: AppColors.darkOnSurfaceVariant.withAlpha(160),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.darkOutlineVariant,
      thickness: 1.0,
      space: 1.0,
    ),
  );
}
