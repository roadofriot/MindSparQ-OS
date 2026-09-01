import 'package:flutter/material.dart';
import '../../../../core/design_system/design_system.dart';
import '../../domain/models/school_summary.dart';

class RecentSchoolsTable extends StatelessWidget {
  final List<SchoolSummary> schools;
  final VoidCallback? onViewAll;

  const RecentSchoolsTable({
    super.key,
    required this.schools,
    this.onViewAll,
  });

  String _formatDate(DateTime dt) {
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
    return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.surfaceBright,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.outlineVariant.withAlpha(80),
                ),
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Recent Schools',
                    style: AppTypography.headlineMd.copyWith(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                TextButton(
                  onPressed: onViewAll,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 30),
                  ),
                  child: Text(
                    'View All',
                    style: AppTypography.labelMd.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content: Empty State or Table Rows
          if (schools.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
              child: AppEmptyState(
                icon: Icons.school_outlined,
                title: 'No Registered Schools',
                subtitle:
                    'Your network has no registered institutions yet. Register your first school to begin operational telemetry.',
                actionLabel: 'New School',
                onAction: onViewAll,
              ),
            )
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 500),
                child: DataTable(
                  horizontalMargin: 24,
                  columnSpacing: 24,
                  headingRowColor: WidgetStateProperty.all(
                    AppColors.surfaceContainerLow,
                  ),
                  columns: [
                    DataColumn(
                      label: Text(
                        'SCHOOL NAME',
                        style: AppTypography.labelSm.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'DATE ADDED',
                        style: AppTypography.labelSm.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'PROGRAMS',
                        style: AppTypography.labelSm.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                    DataColumn(
                      numeric: true,
                      label: Text(
                        'STATUS',
                        style: AppTypography.labelSm.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  ],
                  rows: schools.map((school) {
                    final dateStr = _formatDate(school.dateAdded);
                    final programStr = school.activePrograms > 0
                        ? '${school.activePrograms} Active'
                        : '-';

                    return DataRow(
                      cells: [
                        DataCell(
                          Text(
                            school.name,
                            style: AppTypography.bodyMd.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.onSurface,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            dateStr,
                            style: AppTypography.bodyMd.copyWith(
                              color: AppColors.secondary,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            programStr,
                            style: AppTypography.bodyMd.copyWith(
                              color: AppColors.secondary,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        DataCell(_buildStatusBadge(school.status)),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bg;
    Color fg;
    String label;

    switch (status.toLowerCase()) {
      case 'active':
        bg = const Color(0xFFE6F4EA);
        fg = const Color(0xFF137333);
        label = 'ACTIVE';
        break;
      case 'pending_setup':
      case 'pending':
        bg = const Color(0xFFFEF7E0);
        fg = const Color(0xFFE37400);
        label = 'PENDING SETUP';
        break;
      default:
        bg = AppColors.surfaceContainerHigh;
        fg = AppColors.secondary;
        label = 'INACTIVE';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: AppTypography.labelSm.copyWith(
          color: fg,
          fontWeight: FontWeight.w600,
          fontSize: 10,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
