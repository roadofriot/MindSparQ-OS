import 'package:flutter/animation.dart';

/// Design System Animation Durations and Motion Curves for MindSparQ OS
class AppDurations {
  // Durations
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 200);
  static const Duration slow = Duration(milliseconds: 300);
  static const Duration modal = Duration(milliseconds: 250);

  // Motion Curves
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve easeOut = Curves.easeOutCubic;
  static const Curve fastOutSlowIn = Curves.fastOutSlowIn;
}
