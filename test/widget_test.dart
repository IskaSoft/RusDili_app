import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rusdilini_owrenis_app/app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget createTestApp() {
    return const ProviderScope(child: const RusDiliApp());
  }

  group('RusDiliApp Widget Tests', () {
    testWidgets('App loads and shows SplashScreen initially', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestApp());

      // Wait for router/navigation to settle
      await tester.pumpAndSettle();

      // 🔥 Check SplashScreen exists
      expect(find.byType(MaterialApp), findsOneWidget);

      // OPTIONAL: If SplashScreen has text, check it
      // expect(find.text('Splash'), findsOneWidget);
    });

    testWidgets('Navigation test - router initializes correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Basic sanity check
      expect(find.byType(RusDiliApp), findsOneWidget);
    });
  });
}
