import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindsparq_os/core/design_system/design_system.dart';
import 'package:mindsparq_os/features/auth/presentation/screens/login_screen.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  group('LoginScreen Tests', () {
    testWidgets('Renders all Stitch visual elements on desktop (Windows/Linux)',
        (tester) async {
      tester.view.physicalSize = const Size(1920, 1080);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Brand elements
      expect(find.text('MindSparQ OS'), findsOneWidget);
      expect(find.text('तपाईंको खातामा प्रवेश गर्नुहोस्'), findsOneWidget);
      expect(find.byIcon(Icons.all_inclusive), findsOneWidget);

      // Form inputs
      expect(find.text('इमेल ठेगाना'), findsOneWidget);
      expect(find.text('पासवर्ड'), findsOneWidget);
      expect(find.text('पासवर्ड बिर्सनुभयो?'), findsOneWidget);

      // Actions
      expect(find.byType(AppButton), findsOneWidget);
      expect(find.text('लगइन गर्नुहोस्'), findsOneWidget);
      expect(find.text('वा'), findsOneWidget);
      expect(find.byIcon(Icons.fingerprint), findsOneWidget);
      expect(find.text('बायोमेट्रिक प्रयोग गर्नुहोस्'), findsOneWidget);

      // Footer
      expect(find.textContaining('खाता छैन'), findsOneWidget);
      expect(find.text('साइन अप गर्नुहोस्'), findsOneWidget);
    });

    testWidgets('Renders responsive layout on mobile (Android/iOS)',
        (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('MindSparQ OS'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(AppButton), findsOneWidget);
    });

    testWidgets('Validates required fields when submitted empty',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap login without typing credentials
      await tester.tap(find.byType(AppButton));
      await tester.pumpAndSettle();

      expect(find.text('इमेल आवश्यक छ (Email required)'), findsOneWidget);
    });

    testWidgets('Toggles password visibility on eye icon tap',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Initially obscured with visibility_off icon
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);

      // Tap visibility toggle
      await tester.tap(find.byIcon(Icons.visibility_off_outlined));
      await tester.pumpAndSettle();

      // Now unobscured with visibility icon
      expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
    });
  });
}
