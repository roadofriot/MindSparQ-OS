import 'package:flutter/material.dart';

/// Design System Responsive Breakpoints for MindSparQ OS
/// Strictly matching RESPONSIVE.md specifications
class AppBreakpoints {
  static const double mobileMax = 640.0;
  static const double tabletMax = 1024.0;
  static const double desktopStandard = 1280.0;
  static const double desktopUltra = 1440.0;
  static const double desktopMaxCanvas = 2560.0;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobileMax;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= mobileMax && width < tabletMax;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tabletMax;

  static bool isUltraWide(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= desktopUltra;
}
