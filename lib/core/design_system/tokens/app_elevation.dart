import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Design System Elevation & BoxShadow Tokens for MindSparQ OS
/// Tonal layering model with subtle border-defined elevation.
class AppElevation {
  // Level 1: Soft Card Hover BoxShadow
  static const List<BoxShadow> level1Hover = [
    BoxShadow(
      color: Color(0x0D000000), // rgba(0,0,0,0.05)
      blurRadius: 20,
      offset: Offset(0, 4),
    ),
  ];

  // Level 2: Popover, Contextual Menu, and Dropdown Shadow
  static const List<BoxShadow> level2Popover = [
    BoxShadow(
      color: Color(0x14000000), // rgba(0,0,0,0.08)
      blurRadius: 30,
      offset: Offset(0, 8),
    ),
  ];

  // Level 3: Modal Dialog and Centered Panel Shadow
  static const List<BoxShadow> level3Modal = [
    BoxShadow(
      color: Color(0x26000000), // rgba(0,0,0,0.15)
      blurRadius: 50,
      offset: Offset(0, 20),
    ),
  ];

  // Button Inset Highlight Simulation (Level 0.5)
  static const List<BoxShadow> primaryButtonInset = [
    BoxShadow(
      color: Color(0x33FFFFFF), // rgba(255,255,255,0.2)
      blurRadius: 0,
      offset: Offset(0, 1),
    ),
  ];

  // Standard BorderSide definitions
  static const BorderSide borderDefault = BorderSide(color: AppColors.outlineVariant, width: 1.0);
  static const BorderSide borderCard = BorderSide(color: AppColors.cardBorder, width: 1.0);
  static const BorderSide borderFocus = BorderSide(color: AppColors.primary, width: 1.5);
  static const BorderSide borderError = BorderSide(color: AppColors.error, width: 1.0);
}
