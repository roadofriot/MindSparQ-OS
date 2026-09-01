import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/network/supabase_client_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../auth/presentation/controllers/auth_controller.dart';

class AppHeader extends ConsumerWidget {
  final String title;

  const AppHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isConnected = ref.watch(backendConnectionStatusProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 680;
        final isMedium = constraints.maxWidth >= 680 && constraints.maxWidth < 960;

        return Container(
          height: 64,
          padding: EdgeInsets.symmetric(horizontal: isCompact ? 16 : 24),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(
              bottom: BorderSide(color: AppColors.outlineVariant, width: 1.0),
            ),
          ),
          child: Row(
            children: [
              // Screen Title (Flexible to prevent overflow)
              Flexible(
                child: Text(
                  title,
                  style: AppTypography.headlineMd.copyWith(
                    fontSize: isCompact ? 18 : 22,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),

              // Backend Status Pill (Hidden on very narrow viewports)
              if (!isCompact)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isConnected
                        ? AppColors.successContainer
                        : AppColors.surfaceContainer,
                    borderRadius: AppSpacing.roundedFull,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: isConnected ? AppColors.success : AppColors.secondary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        isConnected ? 'Live Backend' : 'Production Standby',
                        style: AppTypography.labelSm.copyWith(
                          color: isConnected ? AppColors.success : AppColors.secondary,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),

              const Spacer(),

              // Search Field (Desktop only)
              if (!isCompact && !isMedium) ...[
                Container(
                  width: 220,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: AppSpacing.roundedFull,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        size: 18,
                        color: AppColors.onSurfaceVariant,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Search...',
                          style: AppTypography.bodyMd.copyWith(
                            color: AppColors.onSurfaceVariant.withAlpha(160),
                            fontSize: 13,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
              ],

              // Notification Bell
              IconButton(
                icon: const Icon(Icons.notifications_none, size: 20),
                color: AppColors.onSurfaceVariant,
                onPressed: () {},
              ),
              const SizedBox(width: 4),

              // Operator Avatar Menu with Logout Action
              PopupMenuButton<String>(
                offset: const Offset(0, 48),
                constraints: const BoxConstraints(minWidth: 200, maxWidth: 280),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppColors.outlineVariant),
                ),
                tooltip: 'Account Menu',
                onSelected: (value) async {
                  if (value == 'settings') {
                    context.go(RouteConstants.settings);
                  } else if (value == 'logout') {
                    await ref.read(authControllerProvider.notifier).signOut();
                    if (context.mounted) {
                      context.go(RouteConstants.login);
                    }
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    enabled: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'व्यवस्थापक (Administrator)',
                          style: AppTypography.labelMd.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.onSurface,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Super Admin Access',
                          style: AppTypography.labelSm.copyWith(
                            color: AppColors.secondary,
                            fontSize: 11,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'settings',
                    child: Row(
                      children: [
                        const Icon(Icons.settings_outlined, size: 18, color: AppColors.onSurfaceVariant),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'सेटिङहरू (Settings)',
                            style: AppTypography.bodyMd.copyWith(fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        const Icon(Icons.logout, size: 18, color: AppColors.error),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'लगआउट (Log Out)',
                            style: AppTypography.bodyMd.copyWith(
                              color: AppColors.error,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                child: isCompact
                    ? const CircleAvatar(
                        radius: 14,
                        backgroundColor: AppColors.primary,
                        child: Text(
                          'A',
                          style: TextStyle(
                            color: AppColors.onPrimary,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLowest,
                          border: Border.all(color: AppColors.outlineVariant),
                          borderRadius: AppSpacing.roundedFull,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircleAvatar(
                              radius: 12,
                              backgroundColor: AppColors.primary,
                              child: Text(
                                'A',
                                style: TextStyle(
                                  color: AppColors.onPrimary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'व्यवस्थापक (Admin)',
                              style: AppTypography.labelSm.copyWith(
                                color: AppColors.onSurface,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.arrow_drop_down, size: 16, color: AppColors.secondary),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
