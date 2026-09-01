import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Responsive layout switcher based on Stitch breakpoints (Mobile, Tablet, Desktop)
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < AppConstants.mobileMaxBreakpoint;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= AppConstants.mobileMaxBreakpoint &&
        width < AppConstants.tabletMaxBreakpoint;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= AppConstants.tabletMaxBreakpoint;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= AppConstants.tabletMaxBreakpoint) {
          return desktop;
        }
        if (constraints.maxWidth >= AppConstants.mobileMaxBreakpoint &&
            tablet != null) {
          return tablet!;
        }
        return mobile;
      },
    );
  }
}
