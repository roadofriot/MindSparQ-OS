import 'package:flutter/material.dart';

/// Complete Design System Color Palette for MindSparQ OS
/// Strictly matching Google Stitch Project 13746084714856879502 / DESIGN.md
class AppColors {
  // Primary Academic Blue Palette
  static const Color primary = Color(0xFF004E9F);
  static const Color primaryContainer = Color(0xFF0066CC);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFFDFE8FF);
  static const Color primaryFixed = Color(0xFFD7E3FF);
  static const Color primaryFixedDim = Color(0xFFAAC7FF);
  static const Color surfaceTint = Color(0xFF005CBA);
  static const Color onPrimaryFixed = Color(0xFF001B3E);
  static const Color onPrimaryFixedVariant = Color(0xFF00458E);

  // Surface & Canvas (Light Institutional Theme)
  static const Color background = Color(0xFFFCF8FB);
  static const Color surface = Color(0xFFFCF8FB);
  static const Color surfaceBright = Color(0xFFFCF8FB);
  static const Color surfaceDim = Color(0xFFDCD9DC);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF); // Primary Cards & Modals
  static const Color surfaceContainerLow = Color(0xFFF6F3F5);    // Inputs & Search Bars
  static const Color surfaceContainer = Color(0xFFF0EDEF);       // Inactive Tracks & Hover
  static const Color surfaceContainerHigh = Color(0xFFEAE7EA);   // Subtle Dividers
  static const Color surfaceContainerHighest = Color(0xFFE4E2E4);// Border Highlights

  // Text & Content Hierarchy (Light Mode)
  static const Color onSurface = Color(0xFF1B1B1D);
  static const Color onSurfaceVariant = Color(0xFF414753);
  static const Color onBackground = Color(0xFF1B1B1D);
  static const Color outline = Color(0xFF727784);
  static const Color outlineVariant = Color(0xFFC1C6D5);

  // Secondary Slate Palette
  static const Color secondary = Color(0xFF5E5E63);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFE0DFE4);
  static const Color onSecondaryContainer = Color(0xFF626267);
  static const Color secondaryFixed = Color(0xFFE3E2E7);
  static const Color secondaryFixedDim = Color(0xFFC7C6CB);
  static const Color onSecondaryFixed = Color(0xFF1A1B1F);
  static const Color onSecondaryFixedVariant = Color(0xFF46464B);

  // Tertiary / Alert Orange Palette
  static const Color tertiary = Color(0xFF883700);
  static const Color tertiaryContainer = Color(0xFFAF4900);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color onTertiaryContainer = Color(0xFFFFE3D6);
  static const Color tertiaryFixed = Color(0xFFFFDBCB);
  static const Color tertiaryFixedDim = Color(0xFFFFB692);
  static const Color onTertiaryFixed = Color(0xFF341100);
  static const Color onTertiaryFixedVariant = Color(0xFF793000);

  // Status & Validation Semantics
  static const Color error = Color(0xFFBA1A1A);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onErrorContainer = Color(0xFF93000A);

  static const Color success = Color(0xFF008855);
  static const Color successContainer = Color(0xFFD4F8E8);
  static const Color onSuccess = Color(0xFFFFFFFF);
  static const Color onSuccessContainer = Color(0xFF006E3D);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningContainer = Color(0xFFFEF3C7);
  static const Color onWarning = Color(0xFF78350F);

  // Stitch Card Border & Divider
  static const Color cardBorder = Color(0xFFE5E5E7);

  // Dark Theme Inversion Tokens
  static const Color darkBackground = Color(0xFF1B1B1D);
  static const Color darkSurface = Color(0xFF242426);
  static const Color darkCard = Color(0xFF2E2E31);
  static const Color darkOnSurface = Color(0xFFF3F0F2);
  static const Color darkOnSurfaceVariant = Color(0xFFB9B9C0);
  static const Color darkOutline = Color(0xFF8E9099);
  static const Color darkOutlineVariant = Color(0xFF46464B);
}
