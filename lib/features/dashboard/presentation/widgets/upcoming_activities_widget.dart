import 'package:flutter/material.dart';
import '../../../../core/design_system/design_system.dart';
import '../../domain/models/activity_item.dart';

class UpcomingActivitiesWidget extends StatelessWidget {
  final List<ActivityItem> activities;
  final VoidCallback? onViewCalendar;

  const UpcomingActivitiesWidget({
    super.key,
    required this.activities,
    this.onViewCalendar,
  });

  String _formatDateTime(DateTime dt) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    final hour = dt.hour > 12 ? dt.hour - 12 : (dt.hour == 0 ? 12 : dt.hour);
    final ampm = dt.hour >= 12 ? 'PM' : 'AM';
    final min = dt.minute.toString().padLeft(2, '0');
    return '${months[dt.month - 1]} ${dt.day}, $hour:$min $ampm';
  }

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Upcoming Activities',
            style: AppTypography.headlineMd.copyWith(
              color: AppColors.onSurface,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),

          // Timeline or Empty State
          if (activities.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Center(
                child: Column(
                  children: [
                    const Icon(
                      Icons.event_note_outlined,
                      size: 36,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'No Upcoming Activities',
                      style: AppTypography.labelMd.copyWith(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'All academic schedules are currently clear.',
                      style: AppTypography.labelSm.copyWith(
                        color: AppColors.secondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final item = activities[index];
                final isLast = index == activities.length - 1;
                final dateStr = _formatDateTime(item.scheduledAt);

                return IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Node & connecting line
                      Column(
                        children: [
                          _buildActivityBadge(item.type),
                          if (!isLast)
                            Expanded(
                              child: Container(
                                width: 1,
                                color: AppColors.outlineVariant.withAlpha(100),
                                margin: const EdgeInsets.symmetric(vertical: 4),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(width: 14),
                      // Content
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: AppTypography.labelMd.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.onSurface,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                item.subtitle,
                                style: AppTypography.bodyMd.copyWith(
                                  color: AppColors.secondary,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                dateStr,
                                style: AppTypography.labelSm.copyWith(
                                  color: AppColors.secondary,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

          const SizedBox(height: 16),
          // View Calendar Button
          AppButton(
            label: 'View Calendar',
            variant: AppButtonVariant.outline,
            isFullWidth: true,
            height: 38,
            onPressed: onViewCalendar,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityBadge(String type) {
    IconData icon;
    Color bg;
    Color fg;

    switch (type.toLowerCase()) {
      case 'payment_due':
      case 'payment':
        icon = Icons.payments_outlined;
        bg = AppColors.errorContainer;
        fg = AppColors.onErrorContainer;
        break;
      case 'school_visit':
      case 'visit':
        icon = Icons.map_outlined;
        bg = AppColors.primaryContainer;
        fg = AppColors.onPrimaryContainer;
        break;
      default:
        icon = Icons.assignment_ind_outlined;
        bg = AppColors.tertiaryFixed;
        fg = AppColors.onTertiaryFixed;
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 16, color: fg),
    );
  }
}
