import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class MobileBottomNav extends StatelessWidget {
  final String currentRoute;

  const MobileBottomNav({
    super.key,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    final items = [
      (
        icon: Icons.dashboard_outlined,
        activeIcon: Icons.dashboard,
        label: 'ड्यासबोर्ड',
        route: RouteConstants.dashboard,
      ),
      (
        icon: Icons.school_outlined,
        activeIcon: Icons.school,
        label: 'विद्यालय',
        route: RouteConstants.schools,
      ),
      (
        icon: Icons.fact_check_outlined,
        activeIcon: Icons.fact_check,
        label: 'हाजिरी',
        route: RouteConstants.attendance,
      ),
      (
        icon: Icons.settings_outlined,
        activeIcon: Icons.settings,
        label: 'सेटिङ',
        route: RouteConstants.settings,
      ),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.outlineVariant, width: 1.0),
        ),
      ),
      padding: EdgeInsets.only(
        left: 8,
        right: 8,
        top: 6,
        bottom: bottomPadding > 0 ? bottomPadding : 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          final isActive = currentRoute == item.route;

          return Expanded(
            child: InkWell(
              onTap: () => context.go(item.route),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isActive ? item.activeIcon : item.icon,
                      size: 22,
                      color: isActive
                          ? AppColors.primary
                          : AppColors.onSurfaceVariant,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.label,
                      style: AppTypography.labelSm.copyWith(
                        color: isActive
                            ? AppColors.primary
                            : AppColors.onSurfaceVariant,
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                        fontSize: 10,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
