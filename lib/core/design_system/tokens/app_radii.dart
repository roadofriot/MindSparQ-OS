import 'package:flutter/material.dart';

/// Design System Corner Radius Tokens for MindSparQ OS
class AppRadii {
  static const double defaultRadius = 4.0;
  static const double lg = 8.0;
  static const double xl = 12.0;
  static const double card = 16.0;
  static const double sheet = 24.0;
  static const double full = 9999.0;

  // BorderRadius helpers
  static final BorderRadius roundedDefault = BorderRadius.circular(defaultRadius);
  static final BorderRadius roundedLg = BorderRadius.circular(lg);
  static final BorderRadius roundedXl = BorderRadius.circular(xl);
  static final BorderRadius roundedCard = BorderRadius.circular(card);
  static final BorderRadius roundedSheet = const BorderRadius.vertical(top: Radius.circular(sheet));
  static final BorderRadius roundedFull = BorderRadius.circular(full);
}
