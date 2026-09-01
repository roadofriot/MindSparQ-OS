import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindsparq_os/app.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('MindSparQ OS app launches and loads root dashboard on desktop', (WidgetTester tester) async {
    // Configure desktop viewport
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const ProviderScope(
        child: MindSparqApp(),
      ),
    );

    await tester.pumpAndSettle();

    // Verify desktop sidebar branding & dashboard header
    expect(find.text('MindSparQ OS'), findsWidgets);
    expect(find.text('Good Morning, Admin 👋'), findsOneWidget);
  });

  testWidgets('MindSparQ OS app launches and loads on mobile layout', (WidgetTester tester) async {
    // Configure mobile viewport
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const ProviderScope(
        child: MindSparqApp(),
      ),
    );

    await tester.pumpAndSettle();

    // Verify mobile bottom navigation items
    expect(find.text('ड्यासबोर्ड'), findsWidgets);
    expect(find.text('विद्यालय'), findsWidgets);
    expect(find.text('हाजिरी'), findsWidgets);
  });
}
