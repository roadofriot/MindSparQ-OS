import 'package:flutter/material.dart';
import '../../tokens/app_colors.dart';
import '../../tokens/app_radii.dart';
import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';
import '../buttons/app_button.dart';

class SidebarItem {
  final String titleEn;
  final String titleNe;
  final IconData icon;
  final String route;

  const SidebarItem({
    required this.titleEn,
    required this.titleNe,
    required this.icon,
    required this.route,
  });
}

/// Stitch Fixed Desktop Left Navigation Sidebar (260px)
class AppSidebar extends StatelessWidget {
  final String currentRoute;
  final List<SidebarItem> items;
  final ValueChanged<String> onNavigate;
  final VoidCallback? onPrimaryAction;
  final String primaryActionLabel;
  final double width;

  const AppSidebar({
    super.key,
    required this.currentRoute,
    required this.items,
    required this.onNavigate,
    this.onPrimaryAction,
    this.primaryActionLabel = 'नयाँ विद्यालय (New School)',
    this.width = 260.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          right: BorderSide(color: AppColors.outlineVariant, width: 1.0),
        ),
      ),
      padding: AppSpacing.paddingMd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo & Brand Heading
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: AppRadii.roundedLg,
                ),
                child: const Center(
                  child: Text(
                    'M',
                    style: TextStyle(
                      color: AppColors.onPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MindSparQ OS',
                      style: AppTypography.headlineMd.copyWith(fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'आन्तरिक व्यवस्थापन',
                      style: AppTypography.labelSm.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Primary Action CTA
          if (onPrimaryAction != null) ...[
            AppButton(
              label: primaryActionLabel,
              icon: Icons.add,
              isFullWidth: true,
              onPressed: onPrimaryAction,
            ),
            const SizedBox(height: 20),
          ],

          // Navigation Links List
          Expanded(
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 4),
              itemBuilder: (context, index) {
                final item = items[index];
                final isActive = currentRoute == item.route ||
                    (item.route != '/' && currentRoute.startsWith(item.route));

                return Material(
                  color: isActive ? AppColors.primaryFixed : Colors.transparent,
                  borderRadius: AppRadii.roundedLg,
                  child: InkWell(
                    onTap: () => onNavigate(item.route),
                    borderRadius: AppRadii.roundedLg,
                    hoverColor: AppColors.surfaceContainerLow,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: Row(
                        children: [
                          Icon(
                            item.icon,
                            size: 20,
                            color: isActive ? AppColors.primary : AppColors.onSurfaceVariant,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              '${item.titleNe} (${item.titleEn})',
                              style: AppTypography.labelMd.copyWith(
                                color: isActive ? AppColors.primary : AppColors.onSurface,
                                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Footer
          const Divider(color: AppColors.outlineVariant, height: 24),
          Row(
            children: [
              const Icon(Icons.help_outline, size: 18, color: AppColors.onSurfaceVariant),
              const SizedBox(width: 8),
              Text(
                'सहयोग (Help)',
                style: AppTypography.labelSm.copyWith(color: AppColors.onSurfaceVariant),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
