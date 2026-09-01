import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindsparq_os/core/constants/route_constants.dart';
import 'package:mindsparq_os/core/design_system/components/feedback/not_found_screen.dart';
import 'package:mindsparq_os/core/design_system/components/feedback/unauthorized_screen.dart';
import 'package:mindsparq_os/core/router/app_router.dart';
import 'package:mindsparq_os/features/attendance/presentation/screens/attendance_screen.dart';
import 'package:mindsparq_os/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:mindsparq_os/features/emergency/presentation/screens/emergency_screen.dart';
import 'package:mindsparq_os/features/finance/presentation/screens/finance_screen.dart';
import 'package:mindsparq_os/features/inventory/presentation/screens/inventory_screen.dart';
import 'package:mindsparq_os/features/schools/presentation/screens/schools_screen.dart';
import 'package:mindsparq_os/features/settings/presentation/screens/settings_screen.dart';
import 'package:mindsparq_os/features/teachers/data/teacher_repository.dart';
import 'package:mindsparq_os/features/teachers/domain/models/teacher.dart';
import 'package:mindsparq_os/features/teachers/presentation/screens/teacher_profile_screen.dart';
import 'package:mindsparq_os/features/teachers/presentation/screens/teachers_screen.dart';

class FakeTeacherRepository implements TeacherRepository {
  @override
  Future<List<Teacher>> getTeachers({String? query, String? schoolId}) async => [];

  @override
  Future<Teacher?> getTeacherById(String id) async {
    return Teacher(
      id: id,
      fullName: 'Dr. Ram Sharma',
      designation: 'Senior Faculty',
      email: 'ram@mindsparq.edu',
      phone: '+977 9800000000',
      address: 'Kathmandu',
    );
  }
}

Widget createTestApp(ProviderContainer container) {
  return UncontrolledProviderScope(
    container: container,
    child: Consumer(
      builder: (context, ref, _) {
        final router = ref.watch(appRouterProvider);
        return MaterialApp.router(
          routerConfig: router,
        );
      },
    ),
  );
}

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('Navigation System - Comprehensive Suite', () {
    testWidgets('Renders root dashboard and verifies Desktop navigation sidebar items',
        (tester) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final container = ProviderContainer(
        overrides: [
          teacherRepositoryProvider.overrideWithValue(FakeTeacherRepository()),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(createTestApp(container));
      await tester.pumpAndSettle();

      expect(find.byType(DashboardScreen), findsOneWidget);

      // Verify all 8 navigation items exist in sidebar
      expect(find.text('ड्यासबोर्ड (Dashboard)'), findsOneWidget);
      expect(find.text('विद्यालयहरू (Schools)'), findsOneWidget);
      expect(find.text('शिक्षकहरू (Teachers)'), findsOneWidget);
      expect(find.text('प्रवेश रक्षक (Attendance / Gate)'), findsOneWidget);
      expect(find.text('वित्त (Finance)'), findsOneWidget);
      expect(find.text('मौज्दात व्यवस्थापन (Inventory)'), findsOneWidget);
      expect(find.text('आपतकालीन (Emergency Command)'), findsOneWidget);
      expect(find.text('सेटिङहरू (Settings)'), findsOneWidget);

      // Quick action button
      expect(find.text('नयाँ विद्यालय (New School)'), findsOneWidget);
    });

    testWidgets('Navigates across modules via GoRouter programmatically',
        (tester) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final container = ProviderContainer(
        overrides: [
          teacherRepositoryProvider.overrideWithValue(FakeTeacherRepository()),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(createTestApp(container));
      await tester.pumpAndSettle();

      final router = container.read(appRouterProvider);

      // 1. Navigate to Schools
      router.go(RouteConstants.schools);
      await tester.pumpAndSettle();
      expect(find.byType(SchoolsScreen), findsOneWidget);

      // 2. Navigate to Teachers
      router.go(RouteConstants.teachers);
      await tester.pumpAndSettle();
      expect(find.byType(TeachersScreen), findsOneWidget);

      // 3. Deep-link to Teacher Profile
      router.go('${RouteConstants.teachers}/t-101');
      await tester.pumpAndSettle();
      expect(find.byType(TeacherProfileScreen), findsOneWidget);
      expect(find.text('Dr. Ram Sharma'), findsWidgets);

      // 4. Navigate to Attendance
      router.go(RouteConstants.attendance);
      await tester.pumpAndSettle();
      expect(find.byType(AttendanceScreen), findsOneWidget);

      // 5. Navigate to Finance
      router.go(RouteConstants.finance);
      await tester.pumpAndSettle();
      expect(find.byType(FinanceScreen), findsOneWidget);

      // 6. Navigate to Inventory
      router.go(RouteConstants.inventory);
      await tester.pumpAndSettle();
      expect(find.byType(InventoryScreen), findsOneWidget);

      // 7. Navigate to Emergency
      router.go(RouteConstants.emergency);
      await tester.pumpAndSettle();
      expect(find.byType(EmergencyScreen), findsOneWidget);

      // 8. Navigate to Settings
      router.go(RouteConstants.settings);
      await tester.pumpAndSettle();
      expect(find.byType(SettingsScreen), findsOneWidget);
    });

    testWidgets('Unknown route (404) renders Stitch NotFoundScreen with recovery action',
        (tester) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final container = ProviderContainer(
        overrides: [
          teacherRepositoryProvider.overrideWithValue(FakeTeacherRepository()),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(createTestApp(container));
      await tester.pumpAndSettle();

      final router = container.read(appRouterProvider);

      // Navigate to an invalid non-existent path
      router.go('/some/non-existent/route');
      await tester.pumpAndSettle();

      expect(find.byType(NotFoundScreen), findsOneWidget);
      expect(find.text('४०४ / पृष्ठ फेला परेन'), findsOneWidget);
      expect(find.text('Page Not Found'), findsOneWidget);

      // Tap recovery button
      await tester.tap(find.text('ड्यासबोर्डमा फर्कनुहोस् (Go to Dashboard)'));
      await tester.pumpAndSettle();

      expect(find.byType(DashboardScreen), findsOneWidget);
    });

    testWidgets('Unauthorized route renders Stitch UnauthorizedScreen',
        (tester) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final container = ProviderContainer(
        overrides: [
          teacherRepositoryProvider.overrideWithValue(FakeTeacherRepository()),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(createTestApp(container));
      await tester.pumpAndSettle();

      final router = container.read(appRouterProvider);

      // Navigate to unauthorized route with query parameter
      router.go('/unauthorized?role=super_admin');
      await tester.pumpAndSettle();

      expect(find.byType(UnauthorizedScreen), findsOneWidget);
      expect(find.text('पहुँच निषेधित (Access Denied)'), findsOneWidget);
      expect(find.textContaining('super_admin'), findsOneWidget);
    });

    testWidgets('Teacher profile breadcrumbs back navigation returns to directory',
        (tester) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final container = ProviderContainer(
        overrides: [
          teacherRepositoryProvider.overrideWithValue(FakeTeacherRepository()),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(createTestApp(container));
      await tester.pumpAndSettle();

      final router = container.read(appRouterProvider);
      router.go('${RouteConstants.teachers}/t-101');
      await tester.pumpAndSettle();

      expect(find.byType(TeacherProfileScreen), findsOneWidget);

      // Tap back button in breadcrumb
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(find.byType(TeachersScreen), findsOneWidget);
    });

    testWidgets('Header operator menu opens popup with Settings and Logout',
        (tester) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      final container = ProviderContainer(
        overrides: [
          teacherRepositoryProvider.overrideWithValue(FakeTeacherRepository()),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(createTestApp(container));
      await tester.pumpAndSettle();

      // Open operator menu
      await tester.tap(find.text('व्यवस्थापक (Admin)'));
      await tester.pumpAndSettle();

      expect(find.text('Super Admin Access'), findsOneWidget);
      expect(find.text('सेटिङहरू (Settings)'), findsWidgets);
      expect(find.text('लगआउट (Log Out)'), findsOneWidget);
    });
  });
}
