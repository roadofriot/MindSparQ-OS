import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/responsive_layout.dart';
import 'app_header.dart';
import 'desktop_nav_sidebar.dart';
import 'mobile_bottom_nav.dart';

class ShellScreen extends StatelessWidget {
  final Widget child;
  final String currentRoute;
  final String screenTitle;

  const ShellScreen({
    super.key,
    required this.child,
    required this.currentRoute,
    this.screenTitle = 'MindSparQ OS',
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          title: Text(
            screenTitle,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          elevation: 0,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Divider(color: AppColors.outlineVariant, height: 1.0),
          ),
        ),
        body: child,
        bottomNavigationBar: MobileBottomNav(currentRoute: currentRoute),
      ),
      desktop: Scaffold(
        backgroundColor: AppColors.background,
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DesktopNavSidebar(currentRoute: currentRoute),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppHeader(title: screenTitle),
                  Expanded(
                    child: child,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
