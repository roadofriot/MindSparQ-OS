import 'package:flutter/material.dart';
import '../../../../core/design_system/design_system.dart';

class DashboardStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData watermarkIcon;
  final Color accentColor;
  final VoidCallback? onTap;

  const DashboardStatCard({
    super.key,
    required this.label,
    required this.value,
    required this.watermarkIcon,
    this.accentColor = AppColors.primary,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: AppRadii.roundedCard,
        child: Stack(
          children: [
            // Watermark Icon in top-right corner with 8% opacity
            Positioned(
              right: -14,
              top: -14,
              child: Opacity(
                opacity: 0.08,
                child: Icon(
                  watermarkIcon,
                  size: 96,
                  color: accentColor,
                ),
              ),
            ),
            // Card Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label.toUpperCase(),
                    style: AppTypography.labelMd.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: AppTypography.headlineLg.copyWith(
                      color: AppColors.onSurface,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
