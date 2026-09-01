import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/design_system/design_system.dart';
import '../controllers/teacher_controller.dart';
import '../../domain/models/teacher.dart';
import '../widgets/document_vault_card.dart';

class TeacherProfileScreen extends ConsumerStatefulWidget {
  final String teacherId;

  const TeacherProfileScreen({
    super.key,
    required this.teacherId,
  });

  @override
  ConsumerState<TeacherProfileScreen> createState() => _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends ConsumerState<TeacherProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabLabels = [
    'Overview',
    'Schools',
    'Schedule',
    'Attendance',
    'Training',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabLabels.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final teacherAsync = ref.watch(teacherDetailProvider(widget.teacherId));
    final isMobile = AppBreakpoints.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16.0 : 32.0,
          vertical: 24.0,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1440.0),
            child: teacherAsync.when(
              loading: () => Column(
                children: const [
                  AppSkeletonCard(height: 220),
                  SizedBox(height: 24),
                  AppSkeletonCard(height: 380),
                ],
              ),
              error: (err, _) => AppErrorBanner(
                message: 'Failed to load teacher profile: $err',
                onRetry: () => ref.refresh(teacherDetailProvider(widget.teacherId)),
              ),
              data: (teacher) {
                if (teacher == null) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48.0),
                    child: AppEmptyState(
                      icon: Icons.person_off_outlined,
                      title: 'Teacher Not Found',
                      subtitle: 'The requested faculty profile could not be located in the database.',
                      actionLabel: 'Back to Teachers',
                      onAction: () => context.go(RouteConstants.teachers),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Breadcrumbs matching Stitch
                    _buildBreadcrumbs(context, teacher),
                    const SizedBox(height: 16),

                    // Profile Header Card matching Stitch
                    _buildHeaderCard(context, teacher, isMobile),
                    const SizedBox(height: 24),

                    // Tabs Header Bar
                    _buildTabBar(),
                    const SizedBox(height: 24),

                    // Active Tab Content
                    _buildTabContent(context, teacher, isMobile),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBreadcrumbs(BuildContext context, Teacher teacher) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, size: 20),
          color: AppColors.onSurface,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(RouteConstants.teachers);
            }
          },
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => context.go(RouteConstants.teachers),
          child: Text(
            'Teachers',
            style: AppTypography.labelMd.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.chevron_right, size: 16, color: AppColors.secondary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            teacher.fullName,
            style: AppTypography.labelMd.copyWith(
              color: AppColors.secondary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderCard(BuildContext context, Teacher teacher, bool isMobile) {
    return SoftCard(
      padding: EdgeInsets.all(isMobile ? 20.0 : 32.0),
      child: Column(
        children: [
          // Top row: Avatar + Names + Action Buttons
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar with verified badge
              Stack(
                children: [
                  CircleAvatar(
                    radius: isMobile ? 32 : 46,
                    backgroundColor: AppColors.primaryContainer.withAlpha(40),
                    child: Text(
                      teacher.fullName.isNotEmpty
                          ? teacher.fullName.substring(0, 1).toUpperCase()
                          : 'T',
                      style: AppTypography.displayLg.copyWith(
                        fontSize: isMobile ? 26 : 38,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),

              // Names and designation
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      teacher.fullName,
                      style: AppTypography.headlineLg.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: isMobile ? 22 : 28,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${teacher.designation} • ${teacher.experienceYears} Years Exp.',
                      style: AppTypography.bodyMd.copyWith(
                        color: AppColors.secondary,
                        fontSize: isMobile ? 13 : 15,
                      ),
                    ),
                  ],
                ),
              ),

              // Action Buttons on Desktop
              if (!isMobile) ...[
                AppButton(
                  label: 'Message',
                  variant: AppButtonVariant.outline,
                  height: 38,
                  onPressed: () {},
                ),
                const SizedBox(width: 12),
                AppButton(
                  label: 'Edit Profile',
                  variant: AppButtonVariant.primary,
                  height: 38,
                  onPressed: () {},
                ),
              ],
            ],
          ),
          const SizedBox(height: 24),
          const Divider(height: 1, color: Color(0x15000000)),
          const SizedBox(height: 20),

          // Metric Counters matching Stitch
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMetricCounter(
                label: 'OVERALL RATING',
                value: '${teacher.overallRating.toStringAsFixed(1)} ★',
                valueColor: const Color(0xFFE37400),
              ),
              _buildMetricCounter(
                label: 'ATTENDANCE RATE',
                value: '${(teacher.attendanceRate * 100).toStringAsFixed(0)}% ↗',
                valueColor: const Color(0xFF137333),
              ),
              _buildMetricCounter(
                label: 'ACTIVE SCHOOLS',
                value: '${teacher.activeSchoolsCount}',
                valueColor: AppColors.primary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCounter({
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: AppTypography.labelSm.copyWith(
            color: AppColors.secondary,
            letterSpacing: 0.6,
            fontWeight: FontWeight.w600,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: AppTypography.headlineLg.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0x15000000),
            width: 1.0,
          ),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorColor: AppColors.primary,
        indicatorWeight: 3.0,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.secondary,
        labelStyle: AppTypography.labelMd.copyWith(fontWeight: FontWeight.w600),
        unselectedLabelStyle: AppTypography.labelMd,
        onTap: (_) => setState(() {}),
        tabs: _tabLabels.map((t) => Tab(text: t)).toList(),
      ),
    );
  }

  Widget _buildTabContent(BuildContext context, Teacher teacher, bool isMobile) {
    switch (_tabController.index) {
      case 0:
        return _buildOverviewTab(context, teacher, isMobile);
      case 1:
        return _buildSchoolsTab(teacher);
      case 2:
        return _buildScheduleTab(teacher);
      case 3:
        return _buildAttendanceTab(teacher);
      case 4:
        return _buildTrainingTab(teacher);
      default:
        return _buildOverviewTab(context, teacher, isMobile);
    }
  }

  Widget _buildOverviewTab(BuildContext context, Teacher teacher, bool isMobile) {
    if (isMobile) {
      return Column(
        children: [
          _buildContactInfoCard(teacher),
          const SizedBox(height: 20),
          _buildAssignmentsCard(teacher),
          const SizedBox(height: 20),
          DocumentVaultCard(teacher: teacher),
        ],
      );
    }

    // 3 Columns on Desktop
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildContactInfoCard(teacher)),
        const SizedBox(width: 24),
        Expanded(child: _buildAssignmentsCard(teacher)),
        const SizedBox(width: 24),
        Expanded(child: DocumentVaultCard(teacher: teacher)),
      ],
    );
  }

  Widget _buildContactInfoCard(Teacher teacher) {
    return SoftCard(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Information',
            style: AppTypography.headlineMd.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 20),
          _buildInfoRow(
            icon: Icons.mail_outline,
            label: 'Email',
            value: teacher.email,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: teacher.phone,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            icon: Icons.location_on_outlined,
            label: 'Address',
            value: teacher.address,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.secondary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.labelSm.copyWith(
                  color: AppColors.secondary,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value.isNotEmpty ? value : '—',
                style: AppTypography.bodyMd.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAssignmentsCard(Teacher teacher) {
    return SoftCard(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Assignments',
            style: AppTypography.headlineMd.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 20),

          // Programs Taught
          Text(
            'PROGRAMS TAUGHT',
            style: AppTypography.labelSm.copyWith(
              color: AppColors.secondary,
              letterSpacing: 0.6,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 10),
          if (teacher.assignedPrograms.isEmpty)
            Text(
              'No active programs assigned',
              style: AppTypography.bodyMd.copyWith(color: AppColors.secondary),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: teacher.assignedPrograms.map((p) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer.withAlpha(30),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    p.name,
                    style: AppTypography.labelSm.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),

          const SizedBox(height: 24),

          // Current Schools
          Text(
            'CURRENT SCHOOLS',
            style: AppTypography.labelSm.copyWith(
              color: AppColors.secondary,
              letterSpacing: 0.6,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 10),
          if (teacher.assignedSchools.isEmpty)
            Text(
              'No schools linked yet',
              style: AppTypography.bodyMd.copyWith(color: AppColors.secondary),
            )
          else
            Column(
              children: teacher.assignedSchools.map((s) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          s.name,
                          style: AppTypography.bodyMd.copyWith(
                            color: AppColors.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildSchoolsTab(Teacher teacher) {
    if (teacher.assignedSchools.isEmpty) {
      return AppEmptyState(
        icon: Icons.school_outlined,
        title: 'No Assigned Schools',
        subtitle: 'This faculty member is not assigned to any institutional rosters.',
      );
    }

    return Column(
      children: teacher.assignedSchools.map((s) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: SoftCard(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                const Icon(Icons.school_outlined, size: 28, color: AppColors.primary),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s.name, style: AppTypography.labelMd.copyWith(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 2),
                      Text(s.address, style: AppTypography.bodyMd.copyWith(color: AppColors.secondary, fontSize: 13)),
                    ],
                  ),
                ),
                if (s.isPrimary)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryFixed,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text('PRIMARY', style: AppTypography.labelSm.copyWith(color: AppColors.onPrimaryFixed)),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildScheduleTab(Teacher teacher) {
    if (teacher.schedules.isEmpty) {
      return AppEmptyState(
        icon: Icons.calendar_month_outlined,
        title: 'No Timetable Schedules',
        subtitle: 'No classroom periods scheduled for this faculty member.',
      );
    }

    return Column(
      children: teacher.schedules.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: SoftCard(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer.withAlpha(20),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item.dayOfWeek.toUpperCase(),
                    style: AppTypography.labelSm.copyWith(fontWeight: FontWeight.w700, color: AppColors.primary),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${item.subject} • Room ${item.classroom}',
                          style: AppTypography.labelMd.copyWith(fontWeight: FontWeight.w600)),
                      Text('${item.startTime} - ${item.endTime} • ${item.schoolName}',
                          style: AppTypography.bodyMd.copyWith(color: AppColors.secondary, fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAttendanceTab(Teacher teacher) {
    if (teacher.attendanceLogs.isEmpty) {
      return AppEmptyState(
        icon: Icons.fact_check_outlined,
        title: 'No Attendance Records',
        subtitle: 'No gate or classroom logs recorded for this faculty member.',
      );
    }

    return Column(
      children: teacher.attendanceLogs.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: SoftCard(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${item.date.year}-${item.date.month.toString().padLeft(2, '0')}-${item.date.day.toString().padLeft(2, '0')}',
                        style: AppTypography.labelMd.copyWith(fontWeight: FontWeight.w600)),
                    if (item.checkInTime != null)
                      Text('Check-in: ${item.checkInTime} • Check-out: ${item.checkOutTime ?? '—'}',
                          style: AppTypography.bodyMd.copyWith(color: AppColors.secondary, fontSize: 12)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: item.status == 'present' ? const Color(0xFFE6F4EA) : const Color(0xFFFCE8E6),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    item.status.toUpperCase(),
                    style: AppTypography.labelSm.copyWith(
                      color: item.status == 'present' ? const Color(0xFF137333) : const Color(0xFFC5221F),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTrainingTab(Teacher teacher) {
    if (teacher.trainings.isEmpty) {
      return AppEmptyState(
        icon: Icons.school_outlined,
        title: 'No Completed Trainings',
        subtitle: 'No certified faculty development programs recorded.',
      );
    }

    return Column(
      children: teacher.trainings.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: SoftCard(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                const Icon(Icons.workspace_premium_outlined, color: Color(0xFFE37400), size: 28),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: AppTypography.labelMd.copyWith(fontWeight: FontWeight.w700)),
                      Text('${item.institution} • ${item.creditHours} Credit Hrs',
                          style: AppTypography.bodyMd.copyWith(color: AppColors.secondary, fontSize: 13)),
                      Text('Certificate: ${item.certificateNumber}',
                          style: AppTypography.labelSm.copyWith(color: AppColors.secondary, fontSize: 11)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
