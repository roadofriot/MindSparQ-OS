import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/soft_card.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppSpacing.paddingMd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'आपतकालीन कमाण्ड सेन्टर (Emergency Response)',
                      style: AppTypography.headlineLg,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Campus-wide Alerts, Lockdown Protocols & Incident Escalation',
                      style: AppTypography.bodyMd.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.successContainer,
                  borderRadius: AppSpacing.roundedFull,
                ),
                child: Text(
                  'सुरक्षित / All Zones Secure',
                  style: AppTypography.labelSm.copyWith(color: AppColors.success),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Incident broadcast card
          SoftCard(
            backgroundColor: AppColors.errorContainer.withAlpha(50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: AppColors.error,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'संकटकालीन प्रोटोकल (Crisis Broadcast Control)',
                        style: AppTypography.headlineMd.copyWith(
                          color: AppColors.error,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Triggering an emergency lockdown immediately sends push alerts to all teacher mobile companions, shuts electronic gate turnstiles, and notifies district authorities.',
                  style: AppTypography.bodyMd.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 20),
                AppButton(
                  label: 'आपतकालीन तालाबन्दी (Initiate Emergency Protocol)',
                  icon: Icons.lock_person,
                  variant: AppButtonVariant.destructive,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
