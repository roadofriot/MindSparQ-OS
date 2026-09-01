import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/dashboard_repository.dart';
import '../../domain/models/dashboard_overview.dart';

final dashboardOverviewProvider =
    FutureProvider.autoDispose<DashboardOverview>((ref) async {
  final repository = ref.watch(dashboardRepositoryProvider);
  return await repository.getDashboardOverview();
});
