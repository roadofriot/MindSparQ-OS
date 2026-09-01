import 'package:flutter/material.dart';
import '../../../../core/design_system/design_system.dart';

class EntryGuardWidget extends StatelessWidget {
  final int present;
  final int lateCount;
  final int absent;

  const EntryGuardWidget({
    super.key,
    required this.present,
    required this.lateCount,
    required this.absent,
  });

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          // Decorative top-right curved arc matching Stitch
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primaryFixed.withAlpha(50),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    const Icon(
                      Icons.fact_check_outlined,
                      color: AppColors.primary,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Entry Guard',
                      style: AppTypography.headlineMd.copyWith(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  "TODAY'S ATTENDANCE",
                  style: AppTypography.labelSm.copyWith(
                    color: AppColors.secondary,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 20),

                // Attendance Status Pills
                _buildAttendancePill(
                  label: 'PRESENT',
                  count: present,
                  bgColor: const Color(0xFFE6F4EA),
                  borderColor: const Color(0xFFCEEAD6),
                  accentColor: const Color(0xFF137333),
                ),
                const SizedBox(height: 12),
                _buildAttendancePill(
                  label: 'LATE',
                  count: lateCount,
                  bgColor: const Color(0xFFFEF7E0),
                  borderColor: const Color(0xFFFEEFC3),
                  accentColor: const Color(0xFFE37400),
                ),
                const SizedBox(height: 12),
                _buildAttendancePill(
                  label: 'ABSENT',
                  count: absent,
                  bgColor: const Color(0xFFFCE8E6),
                  borderColor: const Color(0xFFFAD2CF),
                  accentColor: const Color(0xFFC5221F),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendancePill({
    required String label,
    required int count,
    required Color bgColor,
    required Color borderColor,
    required Color accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: accentColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: AppTypography.labelMd.copyWith(
                  color: accentColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          Text(
            count.toString(),
            style: AppTypography.headlineMd.copyWith(
              color: accentColor,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
