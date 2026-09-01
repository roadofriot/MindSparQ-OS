import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/soft_card.dart';

class SchoolsScreen extends StatelessWidget {
  const SchoolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppSpacing.paddingMd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Actions
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
                    Text('विद्यालय व्यवस्थापन (Schools)', style: AppTypography.headlineLg),
                    const SizedBox(height: 4),
                    Text(
                      'Institutional Registry & District Network',
                      style: AppTypography.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              AppButton(
                label: 'नयाँ विद्यालय (Add School)',
                icon: Icons.domain_add,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Filters & Table Card
          SoftCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                // Table Toolbar
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 38,
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainerLow,
                            borderRadius: AppSpacing.roundedLg,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              const Icon(Icons.search, size: 18, color: AppColors.onSurfaceVariant),
                              const SizedBox(width: 8),
                              Text(
                                'विद्यालय नाम वा कोड खोज्नुहोस्...',
                                style: AppTypography.bodyMd.copyWith(
                                  color: AppColors.onSurfaceVariant.withAlpha(160),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      AppButton(
                        label: 'फिल्टर (Filters)',
                        icon: Icons.filter_list,
                        variant: AppButtonVariant.outline,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const Divider(color: AppColors.outlineVariant, height: 1),

                // Table Data / Empty State
                const AppEmptyState(
                  icon: Icons.school_outlined,
                  title: 'कुनै विद्यालय दर्ता गरिएको छैन',
                  subtitle: 'No schools are currently registered in the database. Use the button above to register an institution.',
                  actionLabel: 'नयाँ विद्यालय दर्ता गर्नुहोस्',
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
