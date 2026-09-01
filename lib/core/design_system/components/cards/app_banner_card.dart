import 'package:flutter/material.dart';
import '../../tokens/app_colors.dart';
import '../../tokens/app_radii.dart';
import '../../tokens/app_typography.dart';

enum AppBannerVariant { info, success, warning, error }

/// Tonal Alert Banner Card matching Stitch incident & notification styles
class AppBannerCard extends StatelessWidget {
  final String title;
  final String? message;
  final Widget? action;
  final AppBannerVariant variant;
  final IconData? icon;

  const AppBannerCard({
    super.key,
    required this.title,
    this.message,
    this.action,
    this.variant = AppBannerVariant.info,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color border;
    Color fg;
    IconData defaultIcon;

    switch (variant) {
      case AppBannerVariant.info:
        bg = AppColors.primaryFixed.withAlpha(80);
        border = AppColors.primaryFixedDim;
        fg = AppColors.primary;
        defaultIcon = Icons.info_outline;
        break;
      case AppBannerVariant.success:
        bg = AppColors.successContainer.withAlpha(120);
        border = AppColors.success.withAlpha(60);
        fg = AppColors.onSuccessContainer;
        defaultIcon = Icons.check_circle_outline;
        break;
      case AppBannerVariant.warning:
        bg = AppColors.warningContainer;
        border = AppColors.warning.withAlpha(80);
        fg = AppColors.onWarning;
        defaultIcon = Icons.warning_amber_rounded;
        break;
      case AppBannerVariant.error:
        bg = AppColors.errorContainer;
        border = AppColors.error.withAlpha(80);
        fg = AppColors.onErrorContainer;
        defaultIcon = Icons.error_outline;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppRadii.roundedCard,
        border: Border.all(color: border, width: 1.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon ?? defaultIcon, color: fg, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: AppTypography.labelMd.copyWith(
                    color: fg,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (message != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    message!,
                    style: AppTypography.bodyMd.copyWith(
                      color: fg.withAlpha(220),
                      fontSize: 13,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (action != null) ...[
            const SizedBox(width: 12),
            action!,
          ],
        ],
      ),
    );
  }
}
