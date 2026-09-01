import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../constants/route_constants.dart';
import '../../design_system.dart';

class NotFoundScreen extends StatelessWidget {
  final String? attemptedPath;

  const NotFoundScreen({
    super.key,
    this.attemptedPath,
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
                      color: AppColors.primaryFixed.withAlpha(50),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.explore_off_outlined,
                      size: 38,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '४०४ / पृष्ठ फेला परेन',
                    style: AppTypography.headlineLg.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 26,
                      color: AppColors.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Page Not Found',
                    style: AppTypography.labelMd.copyWith(
                      color: AppColors.secondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    attemptedPath != null
                        ? 'The requested path "$attemptedPath" does not exist in MindSparQ OS or has been moved.'
                        : 'The requested page could not be located in the application network.',
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
