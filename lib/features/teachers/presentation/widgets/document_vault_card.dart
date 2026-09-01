import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/auth/role_permissions.dart';
import '../../../../core/design_system/design_system.dart';
import '../../domain/models/teacher.dart';

class DocumentVaultCard extends ConsumerStatefulWidget {
  final Teacher teacher;

  const DocumentVaultCard({
    super.key,
    required this.teacher,
  });

  @override
  ConsumerState<DocumentVaultCard> createState() => _DocumentVaultCardState();
}

class _DocumentVaultCardState extends ConsumerState<DocumentVaultCard> {
  bool _revealPan = false;
  bool _revealBank = false;

  @override
  Widget build(BuildContext context) {
    final permissions = ref.watch(rolePermissionsProvider);
    final canViewSalary = permissions.canViewSensitiveField(
      SensitiveField.salary,
      targetTeacherId: widget.teacher.id,
    );

    final maskedPan = permissions.maskValue(
      widget.teacher.panNumber ?? 'N/A',
      SensitiveField.panNumber,
      targetTeacherId: widget.teacher.id,
    );

    final maskedBank = permissions.maskValue(
      widget.teacher.bankAccountNumber ?? 'N/A',
      SensitiveField.bankAccount,
      targetTeacherId: widget.teacher.id,
    );

    return SoftCard(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Shield Icon matching Stitch
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Document Vault',
                style: AppTypography.headlineMd.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: AppColors.onSurface,
                ),
              ),
              const Icon(
                Icons.shield_outlined,
                size: 22,
                color: AppColors.secondary,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 1. PAN Card Container
          _buildVaultRow(
            icon: Icons.badge_outlined,
            title: 'PAN Card',
            valueText: _revealPan && permissions.canViewSensitiveField(SensitiveField.panNumber)
                ? (widget.teacher.panNumber ?? 'Not Provided')
                : maskedPan,
            trailingWidget: IconButton(
              icon: Icon(
                _revealPan ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                size: 20,
                color: AppColors.secondary,
              ),
              onPressed: () {
                setState(() {
                  _revealPan = !_revealPan;
                });
              },
            ),
          ),
          const SizedBox(height: 12),

          // 2. Bank Details Container
          _buildVaultRow(
            icon: Icons.account_balance_outlined,
            title: widget.teacher.bankName ?? 'Bank Details',
            valueText: _revealBank && permissions.canViewSensitiveField(SensitiveField.bankAccount)
                ? (widget.teacher.bankAccountNumber ?? 'Not Provided')
                : maskedBank,
            trailingWidget: IconButton(
              icon: Icon(
                _revealBank ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                size: 20,
                color: AppColors.secondary,
              ),
              onPressed: () {
                setState(() {
                  _revealBank = !_revealBank;
                });
              },
            ),
          ),
          const SizedBox(height: 12),

          // 3. Salary Structure Container (Permission Restricted with Lock)
          _buildVaultRow(
            icon: Icons.receipt_long_outlined,
            title: 'Salary Structure',
            valueText: canViewSalary
                ? '${widget.teacher.salaryCurrency} ${widget.teacher.baseSalary?.toStringAsFixed(0) ?? '0'}'
                : 'Restricted Access',
            trailingWidget: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                canViewSalary ? Icons.check_circle_outline : Icons.lock_outline,
                size: 20,
                color: canViewSalary ? AppColors.success : AppColors.error,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVaultRow({
    required IconData icon,
    required String title,
    required String valueText,
    required Widget trailingWidget,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surfaceBright,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.outlineVariant.withAlpha(80),
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.labelMd.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  valueText,
                  style: AppTypography.labelSm.copyWith(
                    color: AppColors.secondary,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          trailingWidget,
        ],
      ),
    );
  }
}
