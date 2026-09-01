import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../config/env_config.dart';
import '../constants/route_constants.dart';
import '../design_system/components/feedback/not_found_screen.dart';
import '../design_system/components/feedback/unauthorized_screen.dart';
import '../../features/attendance/presentation/screens/attendance_screen.dart';
import '../../features/auth/data/auth_repository.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/emergency/presentation/screens/emergency_screen.dart';
import '../../features/finance/presentation/screens/finance_screen.dart';
import '../../features/inventory/presentation/screens/inventory_screen.dart';
import '../../features/schools/presentation/screens/schools_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/shell/presentation/shell_screen.dart';
import '../../features/teachers/presentation/screens/teacher_profile_screen.dart';
import '../../features/teachers/presentation/screens/teachers_screen.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final shellNavigatorKey = GlobalKey<NavigatorState>();
  final authRepo = ref.watch(authRepositoryProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: RouteConstants.dashboard,
    refreshListenable: GoRouterRefreshStream(authRepo.authStateChanges),
    redirect: (context, state) {
      final isLoggingIn = state.uri.path == RouteConstants.login;
      final isRoot = state.uri.path == RouteConstants.root;

      // In production environment with Supabase configured, enforce authentication
      if (EnvConfig.isConfigured) {
        final isAuthenticated = authRepo.currentUser != null;

        if (!isAuthenticated && !isLoggingIn) {
          return RouteConstants.login;
        }

        if (isAuthenticated && isLoggingIn) {
          return RouteConstants.dashboard;
        }
      }

      // Root path redirects to dashboard
      if (isRoot) {
        return RouteConstants.dashboard;
      }

      return null;
    },
    errorPageBuilder: (context, state) => NoTransitionPage(
      child: NotFoundScreen(attemptedPath: state.uri.path),
    ),
    routes: [
      GoRoute(
        path: RouteConstants.login,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        path: '/unauthorized',
        pageBuilder: (context, state) {
          final role = state.uri.queryParameters['role'];
          return NoTransitionPage(
            child: UnauthorizedScreen(requiredRole: role),
          );
        },
      ),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) {
          final location = state.uri.path;
          String title = 'MindSparQ OS';

          if (location.startsWith(RouteConstants.schools)) {
            title = 'विद्यालय व्यवस्थापन (Schools)';
          } else if (location.startsWith(RouteConstants.teachers)) {
            title = 'शिक्षकहरू (Teachers)';
          } else if (location.startsWith(RouteConstants.attendance)) {
            title = 'प्रवेश रक्षक (Attendance)';
          } else if (location.startsWith(RouteConstants.finance)) {
            title = 'वित्तीय व्यवस्थापन (Finance)';
          } else if (location.startsWith(RouteConstants.inventory)) {
            title = 'मौज्दात (Inventory)';
          } else if (location.startsWith(RouteConstants.emergency)) {
            title = 'आपतकालीन (Emergency)';
          } else if (location.startsWith(RouteConstants.settings)) {
            title = 'सेटिङहरू (Settings)';
          } else {
            title = 'केन्द्रीय ड्यासबोर्ड (Dashboard)';
          }

          return ShellScreen(
            currentRoute: location,
            screenTitle: title,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: RouteConstants.dashboard,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DashboardScreen(),
            ),
          ),
          GoRoute(
            path: RouteConstants.schools,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SchoolsScreen(),
            ),
          ),
          GoRoute(
            path: RouteConstants.teachers,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: TeachersScreen(),
            ),
            routes: [
              GoRoute(
                path: ':id',
                pageBuilder: (context, state) {
                  final id = state.pathParameters['id'] ?? '';
                  return NoTransitionPage(
                    child: TeacherProfileScreen(teacherId: id),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: RouteConstants.attendance,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AttendanceScreen(),
            ),
          ),
          GoRoute(
            path: RouteConstants.finance,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: FinanceScreen(),
            ),
          ),
          GoRoute(
            path: RouteConstants.inventory,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: InventoryScreen(),
            ),
          ),
          GoRoute(
            path: RouteConstants.emergency,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: EmergencyScreen(),
            ),
          ),
          GoRoute(
            path: RouteConstants.settings,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SettingsScreen(),
            ),
          ),
        ],
      ),
    ],
  );
});
