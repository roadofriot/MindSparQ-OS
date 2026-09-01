import 'package:flutter/material.dart';
import '../../tokens/app_colors.dart';
import '../../tokens/app_durations.dart';
import '../../tokens/app_elevation.dart';
import '../../tokens/app_radii.dart';
import '../../tokens/app_spacing.dart';

/// Stitch Soft Card Container
/// Exact specifications: 16px radius, #E5E5E7 border, smooth hover elevation.
class SoftCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? width;
  final double? height;

  const SoftCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.width,
    this.height,
  });

  @override
  State<SoftCard> createState() => _SoftCardState();
}

class _SoftCardState extends State<SoftCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bg = widget.backgroundColor ?? AppColors.surfaceContainerLowest;
    final border = widget.borderColor ?? AppColors.cardBorder;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppDurations.medium,
        curve: AppDurations.easeInOut,
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: AppRadii.roundedCard,
          border: Border.all(color: border, width: 1.0),
          boxShadow: _isHovered ? AppElevation.level1Hover : const [],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: AppRadii.roundedCard,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: AppRadii.roundedCard,
            child: Padding(
              padding: widget.padding ?? AppSpacing.paddingMd,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
