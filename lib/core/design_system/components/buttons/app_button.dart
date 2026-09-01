import 'package:flutter/material.dart';
import '../../tokens/app_colors.dart';
import '../../tokens/app_elevation.dart';
import '../../tokens/app_radii.dart';
import '../../tokens/app_typography.dart';

enum AppButtonVariant { primary, outline, destructive, ghost }

/// Stitch Button component supporting Primary, Outline, Destructive, and Ghost variants.
/// Includes top-inset highlight simulation and responsive label wrapping.
class AppButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final IconData? trailingIcon;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool isFullWidth;
  final double height;
  final BorderRadius? borderRadius;

  const AppButton({
    super.key,
    required this.label,
    this.icon,
    this.trailingIcon,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.isFullWidth = false,
    this.height = 44.0,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    BorderSide? border;

    final isEnabled = onPressed != null && !isLoading;

    switch (variant) {
      case AppButtonVariant.primary:
        bg = isEnabled ? AppColors.primary : AppColors.surfaceDim;
        fg = isEnabled ? AppColors.onPrimary : AppColors.onSurfaceVariant;
        border = null;
        break;
      case AppButtonVariant.outline:
        bg = Colors.transparent;
        fg = isEnabled ? AppColors.onSurface : AppColors.onSurfaceVariant;
        border = BorderSide(
          color: isEnabled ? AppColors.outlineVariant : AppColors.surfaceDim,
          width: 1.0,
        );
        break;
      case AppButtonVariant.destructive:
        bg = isEnabled ? AppColors.error : AppColors.surfaceDim;
        fg = isEnabled ? AppColors.onError : AppColors.onSurfaceVariant;
        border = null;
        break;
      case AppButtonVariant.ghost:
        bg = Colors.transparent;
        fg = isEnabled ? AppColors.onSurfaceVariant : AppColors.surfaceDim;
        border = null;
        break;
    }

    final radius = borderRadius ?? AppRadii.roundedLg;

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: height,
      child: Material(
        color: bg,
        borderRadius: radius,
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: radius,
          hoverColor: variant == AppButtonVariant.primary
              ? AppColors.primaryContainer
              : AppColors.surfaceContainer,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: radius,
              border: border != null ? Border.fromBorderSide(border) : null,
              boxShadow: variant == AppButtonVariant.primary && isEnabled
                  ? AppElevation.primaryButtonInset
                  : null,
            ),
            child: Row(
              mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading)
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                       strokeWidth: 2.0,
                       valueColor: AlwaysStoppedAnimation<Color>(fg),
                    ),
                  )
                else ...[
                  if (icon != null) ...[
                    Icon(icon, size: 18, color: fg),
                    const SizedBox(width: 8),
                  ],
                  Flexible(
                    child: Text(
                      label,
                      style: AppTypography.labelMd.copyWith(
                        color: fg,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (trailingIcon != null) ...[
                    const SizedBox(width: 8),
                    Icon(trailingIcon, size: 18, color: fg),
                  ],
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
