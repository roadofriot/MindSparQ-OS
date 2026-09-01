import 'activity_item.dart';
import 'school_summary.dart';

class DashboardOverview {
  final int totalSchools;
  final int activeTeachers;
  final double monthlyRevenue;
  final double outstandingRevenue;
  final int attendancePresent;
  final int attendanceLate;
  final int attendanceAbsent;
  final List<SchoolSummary> recentSchools;
  final List<ActivityItem> upcomingActivities;

  const DashboardOverview({
    this.totalSchools = 0,
    this.activeTeachers = 0,
    this.monthlyRevenue = 0.0,
    this.outstandingRevenue = 0.0,
    this.attendancePresent = 0,
    this.attendanceLate = 0,
    this.attendanceAbsent = 0,
    this.recentSchools = const [],
    this.upcomingActivities = const [],
  });

  static const empty = DashboardOverview();
}
