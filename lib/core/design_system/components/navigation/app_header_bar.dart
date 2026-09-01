import 'package:flutter/material.dart';
import '../../tokens/app_colors.dart';
import '../../tokens/app_radii.dart';
import '../../tokens/app_typography.dart';
import '../buttons/app_icon_button.dart';
import '../inputs/app_search_field.dart';

/// Stitch Desktop Header Utility Bar
class AppHeaderBar extends StatelessWidget {
  final String title;
  final bool isConnected;
  final ValueChanged<String>? onSearch;
  final VoidCallback? onNotificationTap;
  final String userLabel;

  const AppHeaderBar({
    super.key,
    required this.title,
    this.isConnected = true,
    this.onSearch,
    this.onNotificationTap,
    this.userLabel = 'व्यवस्थापक (Admin)',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.outlineVariant, width: 1.0),
        ),
      ),
      child: Row(
        children: [
          // Title
          Text(title, style: AppTypography.headlineMd),
          const SizedBox(width: 16),

          // Backend Status Indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isConnected ? AppColors.successContainer : AppColors.surfaceContainer,
              borderRadius: AppRadii.roundedFull,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: isConnected ? AppColors.success : AppColors.secondary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  isConnected ? 'Live Backend' : 'Standby',
                  style: AppTypography.labelSm.copyWith(
                    color: isConnected ? AppColors.success : AppColors.secondary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // Search Field
          AppSearchField(
            width: 260,
            onChanged: onSearch,
          ),
          const SizedBox(width: 12),

          // Notifications
          AppIconButton(
            icon: Icons.notifications_none,
            onPressed: onNotificationTap,
          ),
          const SizedBox(width: 8),

          // User Profile Chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              border: Border.all(color: AppColors.outlineVariant),
              borderRadius: AppRadii.roundedFull,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    'A',
                    style: TextStyle(
                      color: AppColors.onPrimary,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  userLabel,
                  style: AppTypography.labelSm.copyWith(color: AppColors.onSurface),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
