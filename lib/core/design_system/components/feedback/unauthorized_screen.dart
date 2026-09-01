import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../constants/route_constants.dart';
import '../../design_system.dart';

class UnauthorizedScreen extends StatelessWidget {
  final String? requiredRole;

  const UnauthorizedScreen({
    super.key,
    this.requiredRole,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520.0),
            child: SoftCard(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.errorContainer.withAlpha(60),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.lock_person_outlined,
                      size: 38,
                      color: AppColors.error,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'पहुँच निषेधित (Access Denied)',
                    style: AppTypography.headlineLg.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: AppColors.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    requiredRole != null
                        ? 'This section requires "$requiredRole" administrative privileges. Your current role does not have authorization.'
                        : 'You do not have the required administrative permissions to access this institutional resource.',
                    style: AppTypography.bodyMd.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  AppButton(
                    label: 'ड्यासबोर्डमा फर्कनुहोस् (Go to Dashboard)',
                    icon: Icons.dashboard_outlined,
                    variant: AppButtonVariant.primary,
                    onPressed: () => context.go(RouteConstants.dashboard),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
