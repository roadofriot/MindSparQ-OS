import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config/env_config.dart';
import '../../../../core/network/supabase_client_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/soft_card.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isConnected = ref.watch(backendConnectionStatusProvider);

    return SingleChildScrollView(
      padding: AppSpacing.paddingMd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('प्रणाली सेटिङहरू (System Settings)', style: AppTypography.headlineLg),
          Text(
            'Environment Connectivity, Security & Localization Configuration',
            style: AppTypography.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
          ),
          const SizedBox(height: 24),

          // Backend Connection Card
          SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('डाटाबेस र सर्भर जडान (Backend Connection)', style: AppTypography.headlineMd.copyWith(fontSize: 18)),
                const SizedBox(height: 8),
                Text(
                  'Connected to production Supabase cloud database instance.',
                  style: AppTypography.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                ),
                const SizedBox(height: 16),
                const Divider(color: AppColors.outlineVariant, height: 1),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text('स्थिति (Status): ', style: AppTypography.labelMd),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isConnected ? AppColors.successContainer : AppColors.surfaceContainer,
                        borderRadius: AppSpacing.roundedFull,
                      ),
                      child: Text(
                        isConnected ? 'Active & Authenticated' : 'Awaiting Environment Keys (.env)',
                        style: AppTypography.labelSm.copyWith(
                          color: isConnected ? AppColors.success : AppColors.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text('वातावरण (Environment): ', style: AppTypography.labelMd),
                    const SizedBox(width: 8),
                    Text(EnvConfig.appEnvironment, style: AppTypography.bodyMd),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Language & Localization Card
          SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('भाषा र क्षेत्र (Localization)', style: AppTypography.headlineMd.copyWith(fontSize: 18)),
                const SizedBox(height: 8),
                Text(
                  'Bilingual support (English / नेपाली) active for all administrative menus and transcripts.',
                  style: AppTypography.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Chip(
                      label: const Text('English (US)'),
                      backgroundColor: AppColors.primaryFixed,
                      labelStyle: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      label: const Text('नेपाली (Nepal)'),
                      backgroundColor: AppColors.primaryFixed,
                      labelStyle: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
