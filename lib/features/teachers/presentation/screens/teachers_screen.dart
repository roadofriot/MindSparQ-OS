import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/design_system/design_system.dart';
import '../controllers/teacher_controller.dart';
import '../widgets/teacher_card.dart';

class TeachersScreen extends ConsumerWidget {
  const TeachersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teachersAsync = ref.watch(teacherListProvider);
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
                // Top Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'शिक्षकहरू (Teachers)',
                            style: AppTypography.headlineLg.copyWith(
                              fontSize: isMobile ? 22 : 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Faculty Deployment, Workload & Department Assignment',
                            style: AppTypography.bodyMd.copyWith(
                              color: AppColors.secondary,
                              fontSize: isMobile ? 12 : 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppButton(
                      label: isMobile ? 'Add' : 'शिक्षक थप्नुहोस् (New Teacher)',
                      icon: Icons.person_add_alt,
                      variant: AppButtonVariant.primary,
                      height: 40,
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Search and Filter Bar
                Row(
                  children: [
                    Expanded(
                      child: AppSearchField(
                        hintText: 'Search teachers by name or subject...',
                        onChanged: (val) {
                          ref.read(teacherSearchQueryProvider.notifier).state = val;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    AppButton(
                      label: 'Filters',
                      icon: Icons.filter_list,
                      variant: AppButtonVariant.outline,
                      height: 44,
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Teachers Directory Content
                teachersAsync.when(
                  loading: () => Column(
                    children: const [
                      AppSkeletonCard(height: 120),
                      SizedBox(height: 16),
                      AppSkeletonCard(height: 120),
                    ],
                  ),
                  error: (err, _) => AppErrorBanner(
                    message: 'Failed to load teachers: $err',
                    onRetry: () => ref.refresh(teacherListProvider),
                  ),
                  data: (teachers) {
                    if (teachers.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        child: AppEmptyState(
                          icon: Icons.person_search_outlined,
                          title: 'No Teachers Found',
                          subtitle:
                              'No faculty records are registered yet. Add your first teacher profile to manage workload and school assignments.',
                          actionLabel: 'Add First Teacher',
                          onAction: () {},
                        ),
                      );
                    }

                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final isWide = constraints.maxWidth >= 768;
                        final crossAxisCount = isWide ? 2 : 1;

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: isWide ? 2.2 : 2.0,
                          ),
                          itemCount: teachers.length,
                          itemBuilder: (context, index) {
                            final teacher = teachers[index];
                            return TeacherCard(
                              teacher: teacher,
                              onTap: () {
                                context.go('${RouteConstants.teachers}/${teacher.id}');
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
