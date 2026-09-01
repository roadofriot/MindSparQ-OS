import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/network/supabase_client_provider.dart';
import '../domain/models/activity_item.dart';
import '../domain/models/dashboard_overview.dart';
import '../domain/models/school_summary.dart';

abstract class DashboardRepository {
  Future<DashboardOverview> getDashboardOverview();
}

class SupabaseDashboardRepository implements DashboardRepository {
  final SupabaseClient? _client;

  SupabaseDashboardRepository(this._client);

  @override
  Future<DashboardOverview> getDashboardOverview() async {
    if (_client == null) {
      return DashboardOverview.empty;
    }

    try {
      // 1. Fetch real school count and recent schools
      int totalSchools = 0;
      List<SchoolSummary> recentSchools = [];
      try {
        final schoolResponse = await _client
            .from('schools')
            .select()
            .order('created_at', ascending: false)
            .limit(5);

        final List<dynamic> schoolList = schoolResponse as List<dynamic>;
        recentSchools = schoolList
            .map((item) => SchoolSummary.fromJson(item as Map<String, dynamic>))
            .toList();

        final countRes = await _client.from('schools').count();
        totalSchools = countRes;
      } catch (_) {
        // Table may not exist yet in fresh Supabase projects
      }

      // 2. Fetch real active teachers count
      int activeTeachers = 0;
      try {
        final teacherCount = await _client
            .from('teachers')
            .count(CountOption.exact);
        activeTeachers = teacherCount;
      } catch (_) {}

      // 3. Fetch real attendance breakdown
      int present = 0;
      int late = 0;
      int absent = 0;
      try {
        final todayStr = DateTime.now().toIso8601String().split('T').first;
        final attendanceRows = await _client
            .from('attendance_logs')
            .select('status')
            .gte('timestamp', '$todayStr 00:00:00')
            .lte('timestamp', '$todayStr 23:59:59');

        for (final row in attendanceRows as List<dynamic>) {
          final s = (row['status'] as String? ?? '').toLowerCase();
          if (s == 'present') present++;
          if (s == 'late') late++;
          if (s == 'absent') absent++;
        }
      } catch (_) {}

      // 4. Fetch upcoming activities
      List<ActivityItem> activities = [];
      try {
        final actRows = await _client
            .from('activities')
            .select()
            .order('scheduled_at', ascending: true)
            .limit(5);

        activities = (actRows as List<dynamic>)
            .map((item) => ActivityItem.fromJson(item as Map<String, dynamic>))
            .toList();
      } catch (_) {}

      return DashboardOverview(
        totalSchools: totalSchools,
        activeTeachers: activeTeachers,
        monthlyRevenue: 0.0,
        outstandingRevenue: 0.0,
        attendancePresent: present,
        attendanceLate: late,
        attendanceAbsent: absent,
        recentSchools: recentSchools,
        upcomingActivities: activities,
      );
    } catch (e) {
      return DashboardOverview.empty;
    }
  }
}

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return SupabaseDashboardRepository(client);
});
