import 'package:flutter/material.dart';
import '../../tokens/app_colors.dart';
import '../../tokens/app_typography.dart';
import '../buttons/app_button.dart';
import 'app_dialog.dart';

/// Reusable Confirmation Dialog for institutional operations
class AppConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final bool isDestructive;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const AppConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmLabel = 'पुष्टि गर्नुहोस् (Confirm)',
    this.cancelLabel = 'रद्द गर्नुहोस् (Cancel)',
    this.isDestructive = false,
    required this.onConfirm,
    this.onCancel,
  });

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    String confirmLabel = 'पुष्टि गर्नुहोस् (Confirm)',
    String cancelLabel = 'रद्द गर्नुहोस् (Cancel)',
    bool isDestructive = false,
  }) {
    return AppDialog.show<bool>(
      context: context,
      title: title,
      content: Text(
        message,
        style: AppTypography.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
      ),
      actions: [
        AppButton(
          label: cancelLabel,
          variant: AppButtonVariant.outline,
          onPressed: () => Navigator.of(context).pop(false),
        ),
        AppButton(
          label: confirmLabel,
          variant: isDestructive ? AppButtonVariant.destructive : AppButtonVariant.primary,
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: title,
      content: Text(
        message,
        style: AppTypography.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
      ),
      actions: [
        AppButton(
          label: cancelLabel,
          variant: AppButtonVariant.outline,
          onPressed: () {
            onCancel?.call();
            Navigator.of(context).pop();
          },
        ),
        AppButton(
          label: confirmLabel,
          variant: isDestructive ? AppButtonVariant.destructive : AppButtonVariant.primary,
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
