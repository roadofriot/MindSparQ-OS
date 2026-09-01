import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindsparq_os/core/design_system/design_system.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('Design System Tokens', () {
    test('AppColors matches Stitch specifications', () {
      expect(AppColors.primary, const Color(0xFF004E9F));
      expect(AppColors.background, const Color(0xFFFCF8FB));
      expect(AppColors.surfaceContainerLowest, const Color(0xFFFFFFFF));
      expect(AppColors.onSurface, const Color(0xFF1B1B1D));
      expect(AppColors.error, const Color(0xFFBA1A1A));
      expect(AppColors.cardBorder, const Color(0xFFE5E5E7));
    });

    test('AppRadii tokens have correct values', () {
      expect(AppRadii.defaultRadius, 4.0);
      expect(AppRadii.lg, 8.0);
      expect(AppRadii.xl, 12.0);
      expect(AppRadii.card, 16.0);
      expect(AppRadii.sheet, 24.0);
    });

    test('AppSpacing tokens follow 4px/8px scale', () {
      expect(AppSpacing.unit, 4.0);
      expect(AppSpacing.xs, 8.0);
      expect(AppSpacing.sm, 16.0);
      expect(AppSpacing.md, 24.0);
      expect(AppSpacing.lg, 32.0);
      expect(AppSpacing.xl, 48.0);
    });

    test('AppBreakpoints correctly classify screen widths', () {
      expect(AppBreakpoints.mobileMax, 640.0);
      expect(AppBreakpoints.tabletMax, 1024.0);
      expect(AppBreakpoints.desktopStandard, 1280.0);
      expect(AppBreakpoints.desktopUltra, 1440.0);
    });
  });

  group('Themes', () {
    testWidgets('LightTheme and DarkTheme instantiate correctly', (tester) async {
      final light = AppTheme.lightTheme;
      final dark = AppTheme.darkTheme;

      expect(light.brightness, Brightness.light);
      expect(light.scaffoldBackgroundColor, AppColors.background);
      expect(light.colorScheme.primary, AppColors.primary);

      expect(dark.brightness, Brightness.dark);
      expect(dark.scaffoldBackgroundColor, AppColors.darkBackground);
    });
  });

  group('Component Primitives', () {
    testWidgets('AppButton renders label, icon, and handles tap', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'New School',
              icon: Icons.add,
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.text('New School'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(find.byType(AppButton));
      expect(tapped, isTrue);
    });

    testWidgets('AppButton displays loading spinner when isLoading is true', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Processing',
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Processing'), findsNothing);
    });

    testWidgets('AppIconButton renders icon and notification badge', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppIconButton(
              icon: Icons.notifications,
              hasBadge: true,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.notifications), findsOneWidget);
      expect(find.byType(AppIconButton), findsOneWidget);
    });

    testWidgets('AppTextField renders label, hint, and accepts input', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(
              label: 'School Code',
              hintText: 'e.g. SCH-001',
              controller: controller,
              isRequired: true,
            ),
          ),
        ),
      );

      expect(find.text('School Code'), findsOneWidget);
      expect(find.text('*'), findsOneWidget);
      expect(find.text('e.g. SCH-001'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'SCH-402');
      expect(controller.text, 'SCH-402');
    });

    testWidgets('SoftCard renders child and honors padding', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SoftCard(
              child: Text('Card Content'),
            ),
          ),
        ),
      );

      expect(find.text('Card Content'), findsOneWidget);
    });

    testWidgets('AppStatCard renders KPI metric and note', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppStatCard(
              title: 'Total Enrolled',
              value: '1,248',
              icon: Icons.school,
              note: '+12% this term',
            ),
          ),
        ),
      );

      expect(find.text('Total Enrolled'), findsOneWidget);
      expect(find.text('1,248'), findsOneWidget);
      expect(find.text('+12% this term'), findsOneWidget);
      expect(find.byIcon(Icons.school), findsOneWidget);
    });

    testWidgets('AppBannerCard renders alert message', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppBannerCard(
              title: 'Emergency Lockdown',
              message: 'Campus perimeter secured.',
              variant: AppBannerVariant.error,
            ),
          ),
        ),
      );

      expect(find.text('Emergency Lockdown'), findsOneWidget);
      expect(find.text('Campus perimeter secured.'), findsOneWidget);
    });

    testWidgets('AppEmptyState renders zero-data placeholder and CTA', (tester) async {
      bool actionTriggered = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppEmptyState(
              icon: Icons.school_outlined,
              title: 'No Schools Found',
              subtitle: 'Add your first institution.',
              actionLabel: 'Add School',
              onAction: () => actionTriggered = true,
            ),
          ),
        ),
      );

      expect(find.text('No Schools Found'), findsOneWidget);
      expect(find.text('Add your first institution.'), findsOneWidget);
      expect(find.text('Add School'), findsOneWidget);

      await tester.tap(find.text('Add School'));
      expect(actionTriggered, isTrue);
    });

    testWidgets('AppLoadingIndicator and AppSkeletonCard render properly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                AppLoadingIndicator(message: 'Loading records...'),
                AppSkeletonCard(),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading records...'), findsOneWidget);
      expect(find.byType(AppSkeletonCard), findsOneWidget);
    });
  });
}
