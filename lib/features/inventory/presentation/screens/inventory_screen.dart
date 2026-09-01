import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/soft_card.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

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
                      'मौज्दात तथा खरिद (Inventory & Logistics)',
                      style: AppTypography.headlineLg,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Campus Assets, Equipment Checkout, Stock Alerts & Purchase Orders',
                      style: AppTypography.bodyMd.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              AppButton(
                label: 'सामग्री थप्नुहोस् (Add Item)',
                icon: Icons.add_box_outlined,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),
          SoftCard(
            padding: EdgeInsets.zero,
            child: const Column(
              children: [
                AppEmptyState(
                  icon: Icons.inventory_2_outlined,
                  title: 'मौज्दात सूची रिक्त छ',
                  subtitle:
                      'No inventory items, lab tools, or textbooks are registered in campus stock.',
                  actionLabel: 'नयाँ सामग्री प्रविष्टि गर्नुहोस्',
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
