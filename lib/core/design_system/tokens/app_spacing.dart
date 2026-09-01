import 'package:flutter/material.dart';

/// Design System Spacing Tokens for MindSparQ OS
/// 4px modular increment system matching Stitch Project 13746084714856879502
class AppSpacing {
  static const double unit = 4.0;
  static const double xs = 8.0;
  static const double sm = 16.0;
  static const double md = 24.0;
  static const double lg = 32.0;
  static const double xl = 48.0;

  static const double gutter = 24.0;
  static const double margin = 40.0;

  // Standard EdgeInsets
  static const EdgeInsets paddingXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingMd = EdgeInsets.all(md);
  static const EdgeInsets paddingLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingXl = EdgeInsets.all(xl);

  // Horizontal & Vertical Slices
  static const EdgeInsets horizontalSm = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets horizontalMd = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets verticalSm = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets verticalMd = EdgeInsets.symmetric(vertical: md);

  // Form & Input Insets
  static const EdgeInsets inputPadding = EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0);
  static const EdgeInsets cardPadding = EdgeInsets.all(24.0);
  static const EdgeInsets mobileCardPadding = EdgeInsets.all(16.0);

  // Border Radii (convenience aliases to AppRadii)
  static final BorderRadius roundedDefault = BorderRadius.circular(4.0);
  static final BorderRadius roundedLg = BorderRadius.circular(8.0);
  static final BorderRadius roundedXl = BorderRadius.circular(12.0);
  static final BorderRadius roundedCard = BorderRadius.circular(16.0);
  static final BorderRadius roundedFull = BorderRadius.circular(9999.0);
}
