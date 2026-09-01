import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_button.dart';

class NavItemData {
  final String titleEn;
  final String titleNe;
  final IconData icon;
  final String route;

  const NavItemData({
    required this.titleEn,
    required this.titleNe,
    required this.icon,
    required this.route,
  });
}

class DesktopNavSidebar extends StatelessWidget {
  final String currentRoute;

  const DesktopNavSidebar({
    super.key,
    required this.currentRoute,
  });

  static const List<NavItemData> navItems = [
    NavItemData(
      titleEn: 'Dashboard',
      titleNe: 'ड्यासबोर्ड',
      icon: Icons.dashboard_outlined,
      route: RouteConstants.dashboard,
    ),
    NavItemData(
      titleEn: 'Schools',
      titleNe: 'विद्यालयहरू',
      icon: Icons.school_outlined,
      route: RouteConstants.schools,
    ),
    NavItemData(
      titleEn: 'Teachers',
      titleNe: 'शिक्षकहरू',
      icon: Icons.person_outline,
      route: RouteConstants.teachers,
    ),
    NavItemData(
      titleEn: 'Attendance / Gate',
      titleNe: 'प्रवेश रक्षक',
      icon: Icons.fact_check_outlined,
      route: RouteConstants.attendance,
    ),
    NavItemData(
      titleEn: 'Finance',
      titleNe: 'वित्त',
      icon: Icons.payments_outlined,
      route: RouteConstants.finance,
    ),
    NavItemData(
      titleEn: 'Inventory',
      titleNe: 'मौज्दात व्यवस्थापन',
      icon: Icons.inventory_2_outlined,
      route: RouteConstants.inventory,
    ),
    NavItemData(
      titleEn: 'Emergency Command',
      titleNe: 'आपतकालीन',
      icon: Icons.warning_amber_outlined,
      route: RouteConstants.emergency,
    ),
    NavItemData(
      titleEn: 'Settings',
      titleNe: 'सेटिङहरू',
      icon: Icons.settings_outlined,
      route: RouteConstants.settings,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppConstants.desktopSidebarWidth,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          right: BorderSide(color: AppColors.outlineVariant, width: 1.0),
        ),
      ),
      padding: AppSpacing.paddingMd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand Header
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: AppSpacing.roundedLg,
                ),
                child: const Center(
                  child: Text(
                    'M',
                    style: TextStyle(
                      color: AppColors.onPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppConstants.appName,
                      style: AppTypography.headlineMd.copyWith(fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'आन्तरिक व्यवस्थापन',
                      style: AppTypography.labelSm.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Primary Quick Action: Add New School / नयाँ विद्यालय
          AppButton(
            label: 'नयाँ विद्यालय (New School)',
            icon: Icons.add,
            isFullWidth: true,
            onPressed: () => context.go(RouteConstants.schools),
          ),
          const SizedBox(height: 20),

          // Navigation Links
          Expanded(
            child: ListView.separated(
              itemCount: navItems.length,
              separatorBuilder: (context, index) => const SizedBox(height: 4),
              itemBuilder: (context, index) {
                final item = navItems[index];
                final isActive = currentRoute == item.route ||
                    (item.route != RouteConstants.dashboard &&
                        currentRoute.startsWith(item.route));

                return Material(
                  color: isActive ? AppColors.primaryFixed : Colors.transparent,
                  borderRadius: AppSpacing.roundedLg,
                  child: InkWell(
                    onTap: () => context.go(item.route),
                    borderRadius: AppSpacing.roundedLg,
                    hoverColor: AppColors.surfaceContainerLow,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item.icon,
                            size: 20,
                            color: isActive
                                ? AppColors.primary
                                : AppColors.onSurfaceVariant,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              '${item.titleNe} (${item.titleEn})',
                              style: AppTypography.labelMd.copyWith(
                                color: isActive
                                    ? AppColors.primary
                                    : AppColors.onSurface,
                                fontWeight: isActive
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Footer info
          const Divider(color: AppColors.outlineVariant, height: 24),
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('सहयोग र प्राविधिक समर्थन (Support Desk)'),
                  content: const Text(
                    'MindSparQ OS — Institutional & School Management Platform\nVersion: 1.0.0 (Production)\n\nFor support, contact support@mindsparq.edu.np or reach your regional coordinator.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('ठीक छ (OK)'),
                    ),
                  ],
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              child: Row(
                children: [
                  const Icon(Icons.help_outline, size: 18, color: AppColors.onSurfaceVariant),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'सहयोग (Help & Support)',
                      style: AppTypography.labelSm.copyWith(color: AppColors.onSurfaceVariant),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
