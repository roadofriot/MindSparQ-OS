import 'package:flutter/material.dart';
import '../../tokens/app_colors.dart';
import '../../tokens/app_radii.dart';
import '../../tokens/app_typography.dart';
import '../buttons/app_button.dart';

/// Full-width Error Banner for operational/server failures
class AppErrorBanner extends StatelessWidget {
  final String message;
  final String? title;
  final VoidCallback? onRetry;

  const AppErrorBanner({
    super.key,
    required this.message,
    this.title,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.errorContainer,
        borderRadius: AppRadii.roundedLg,
        border: Border.all(color: AppColors.error.withAlpha(80)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: AppColors.onErrorContainer, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: AppTypography.labelMd.copyWith(
                      color: AppColors.onErrorContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                Text(
                  message,
                  style: AppTypography.bodyMd.copyWith(
                    color: AppColors.onErrorContainer,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(width: 12),
            AppButton(
              label: 'पुनः प्रयास (Retry)',
              variant: AppButtonVariant.outline,
              height: 36,
              onPressed: onRetry,
            ),
          ],
        ],
      ),
    );
  }
}
