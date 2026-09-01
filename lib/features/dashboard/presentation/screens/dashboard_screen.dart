import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/design_system/design_system.dart';
import '../controllers/dashboard_controller.dart';
import '../../domain/models/dashboard_overview.dart';
import '../widgets/dashboard_stat_card.dart';
import '../widgets/entry_guard_widget.dart';
import '../widgets/recent_schools_table.dart';
import '../widgets/upcoming_activities_widget.dart';

/// MindSparQ OS Dashboard Screen
/// Faithfully implementing Stitch Screen 3b9590274f5a49ada7afe8ee42589fb0
/// Supports responsive layout across Mobile, Tablet, and Desktop.
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardOverviewProvider);
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Greeting Header matching Stitch
                Text(
                  'Good Morning, Admin 👋',
                  style: AppTypography.displayLg.copyWith(
                    color: AppColors.onSurface,
                    fontSize: isMobile ? 26 : 34,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.02 * 34,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Here is what's happening across your network today.",
                  style: AppTypography.bodyLg.copyWith(
                    color: AppColors.secondary,
                    fontSize: isMobile ? 14 : 16,
                  ),
                ),
                const SizedBox(height: 28),

                // 2. Main Dashboard Bento Layout
                dashboardAsync.when(
                  loading: () => _buildLoadingState(context),
                  error: (error, _) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: AppErrorBanner(
                      message: 'Failed to load telemetry: $error',
                      onRetry: () => ref.refresh(dashboardOverviewProvider),
                    ),
                  ),
                  data: (data) => _buildDashboardContent(context, data),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardContent(BuildContext context, DashboardOverview data) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 1024;
        final isTablet = constraints.maxWidth >= 640 && constraints.maxWidth < 1024;

        if (isDesktop) {
          // Desktop Bento Grid: 8-col left, 4-col right
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Column (Cols 1-8)
              Expanded(
                flex: 8,
                child: Column(
                  children: [
                    _buildStatCardsGrid(
                      context,
                      data,
                      crossAxisCount: 2,
                      childAspectRatio: 2.0,
                    ),
                    const SizedBox(height: 24),
                    RecentSchoolsTable(
                      schools: data.recentSchools,
                      onViewAll: () => context.go(RouteConstants.schools),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              // Right Column (Cols 9-12)
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    EntryGuardWidget(
                      present: data.attendancePresent,
                      lateCount: data.attendanceLate,
                      absent: data.attendanceAbsent,
                    ),
                    const SizedBox(height: 24),
                    UpcomingActivitiesWidget(
                      activities: data.upcomingActivities,
                      onViewCalendar: () => context.go(RouteConstants.attendance),
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        // Tablet & Mobile Layout
        return Column(
          children: [
            _buildStatCardsGrid(
              context,
              data,
              crossAxisCount: 2,
              childAspectRatio: isTablet ? 1.8 : 1.35,
            ),
            const SizedBox(height: 20),
            EntryGuardWidget(
              present: data.attendancePresent,
              lateCount: data.attendanceLate,
              absent: data.attendanceAbsent,
            ),
            const SizedBox(height: 20),
            RecentSchoolsTable(
              schools: data.recentSchools,
              onViewAll: () => context.go(RouteConstants.schools),
            ),
            const SizedBox(height: 20),
            UpcomingActivitiesWidget(
              activities: data.upcomingActivities,
              onViewCalendar: () => context.go(RouteConstants.attendance),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCardsGrid(
    BuildContext context,
    DashboardOverview data, {
    required int crossAxisCount,
    double childAspectRatio = 1.8,
  }) {
    return GridView.count(
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: childAspectRatio,
      children: [
        DashboardStatCard(
          label: 'Total Schools',
          value: data.totalSchools > 0 ? '${data.totalSchools}' : '0',
          watermarkIcon: Icons.school_outlined,
          accentColor: AppColors.primary,
          onTap: () => context.go(RouteConstants.schools),
        ),
        DashboardStatCard(
          label: 'Active Teachers',
          value: data.activeTeachers > 0 ? '${data.activeTeachers}' : '0',
          watermarkIcon: Icons.person_4_outlined,
          accentColor: AppColors.tertiary,
          onTap: () => context.go(RouteConstants.teachers),
        ),
        DashboardStatCard(
          label: 'Monthly Revenue',
          value: data.monthlyRevenue > 0
              ? 'Rs. ${data.monthlyRevenue.toStringAsFixed(0)}'
              : 'Rs. 0',
          watermarkIcon: Icons.account_balance_wallet_outlined,
          accentColor: AppColors.primary,
          onTap: () => context.go(RouteConstants.finance),
        ),
        DashboardStatCard(
          label: 'Outstanding',
          value: data.outstandingRevenue > 0
              ? 'Rs. ${data.outstandingRevenue.toStringAsFixed(0)}'
              : 'Rs. 0',
          watermarkIcon: Icons.warning_amber_outlined,
          accentColor: AppColors.error,
          onTap: () => context.go(RouteConstants.finance),
        ),
      ],
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Column(
      children: [
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.4,
          children: const [
            AppSkeletonCard(height: 120),
            AppSkeletonCard(height: 120),
            AppSkeletonCard(height: 120),
            AppSkeletonCard(height: 120),
          ],
        ),
        const SizedBox(height: 24),
        const AppSkeletonCard(height: 200),
        const SizedBox(height: 24),
        const AppSkeletonCard(height: 180),
      ],
    );
  }
}
