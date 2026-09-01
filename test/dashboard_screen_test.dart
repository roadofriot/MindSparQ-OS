import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindsparq_os/features/dashboard/data/dashboard_repository.dart';
import 'package:mindsparq_os/features/dashboard/domain/models/activity_item.dart';
import 'package:mindsparq_os/features/dashboard/domain/models/dashboard_overview.dart';
import 'package:mindsparq_os/features/dashboard/domain/models/school_summary.dart';
import 'package:mindsparq_os/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:mindsparq_os/features/dashboard/presentation/widgets/dashboard_stat_card.dart';
import 'package:mindsparq_os/features/dashboard/presentation/widgets/entry_guard_widget.dart';
import 'package:mindsparq_os/features/dashboard/presentation/widgets/recent_schools_table.dart';
import 'package:mindsparq_os/features/dashboard/presentation/widgets/upcoming_activities_widget.dart';

class FakeDashboardRepository implements DashboardRepository {
  final DashboardOverview overview;
  FakeDashboardRepository(this.overview);

  @override
  Future<DashboardOverview> getDashboardOverview() async => overview;
}

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('DashboardScreen Tests', () {
    testWidgets(
        'Renders all Stitch visual elements and empty states on desktop',
        (tester) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            dashboardRepositoryProvider.overrideWithValue(
              FakeDashboardRepository(DashboardOverview.empty),
            ),
          ],
          child: const MaterialApp(
            home: DashboardScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Greeting Header
      expect(find.text('Good Morning, Admin 👋'), findsOneWidget);
      expect(
        find.text("Here is what's happening across your network today."),
        findsOneWidget,
      );

      // 4 Stat Cards
      expect(find.byType(DashboardStatCard), findsNWidgets(4));
      expect(find.text('TOTAL SCHOOLS'), findsOneWidget);
      expect(find.text('ACTIVE TEACHERS'), findsOneWidget);
      expect(find.text('MONTHLY REVENUE'), findsOneWidget);
      expect(find.text('OUTSTANDING'), findsOneWidget);

      // Entry Guard Widget
      expect(find.byType(EntryGuardWidget), findsOneWidget);
      expect(find.text('Entry Guard'), findsOneWidget);
      expect(find.text("TODAY'S ATTENDANCE"), findsOneWidget);
      expect(find.text('PRESENT'), findsOneWidget);
      expect(find.text('LATE'), findsOneWidget);
      expect(find.text('ABSENT'), findsOneWidget);

      // Recent Schools Table
      expect(find.byType(RecentSchoolsTable), findsOneWidget);
      expect(find.text('Recent Schools'), findsOneWidget);
      expect(find.text('View All'), findsOneWidget);
      expect(find.text('No Registered Schools'), findsOneWidget); // Empty state

      // Upcoming Activities Widget
      expect(find.byType(UpcomingActivitiesWidget), findsOneWidget);
      expect(find.text('Upcoming Activities'), findsOneWidget);
      expect(find.text('View Calendar'), findsOneWidget);
      expect(find.text('No Upcoming Activities'), findsOneWidget); // Empty state
    });

    testWidgets('Renders real populated data correctly when available',
        (tester) async {
      tester.view.physicalSize = const Size(1440, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final populatedData = DashboardOverview(
        totalSchools: 12,
        activeTeachers: 48,
        monthlyRevenue: 250000,
        outstandingRevenue: 45000,
        attendancePresent: 32,
        attendanceLate: 4,
        attendanceAbsent: 7,
        recentSchools: [
          SchoolSummary(
            id: '1',
            name: 'ABC Academy',
            dateAdded: DateTime(2026, 8, 20),
            activePrograms: 3,
            status: 'active',
          ),
        ],
        upcomingActivities: [
          ActivityItem(
            id: '1',
            title: 'Fee Collection Audit',
            subtitle: 'ABC Academy',
            scheduledAt: DateTime(2026, 9, 1, 10, 0),
            type: 'payment_due',
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            dashboardRepositoryProvider.overrideWithValue(
              FakeDashboardRepository(populatedData),
            ),
          ],
          child: const MaterialApp(
            home: DashboardScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('12'), findsOneWidget);
      expect(find.text('48'), findsOneWidget);
      expect(find.text('Rs. 250000'), findsOneWidget);
      expect(find.text('32'), findsOneWidget);
      expect(find.text('ABC Academy'), findsWidgets);
      expect(find.text('Fee Collection Audit'), findsOneWidget);
    });

    testWidgets('Renders responsive layout on mobile without overflow',
        (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            dashboardRepositoryProvider.overrideWithValue(
              FakeDashboardRepository(DashboardOverview.empty),
            ),
          ],
          child: const MaterialApp(
            home: DashboardScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Good Morning, Admin 👋'), findsOneWidget);
      expect(find.byType(DashboardStatCard), findsNWidgets(4));
      expect(find.byType(EntryGuardWidget), findsOneWidget);
      expect(find.byType(RecentSchoolsTable), findsOneWidget);
      expect(find.byType(UpcomingActivitiesWidget), findsOneWidget);
    });
  });
}
