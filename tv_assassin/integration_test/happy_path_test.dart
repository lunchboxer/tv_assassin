import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tv_assassin/main.dart' as app;
import 'package:tv_assassin/repository/command_repository.dart';
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Happy Path Integration Test', () {
    testWidgets('Full app flow with UI interaction', (
      WidgetTester tester,
    ) async {
      // Build the app
      app.main();
      await tester.pumpAndSettle();

      // Verify initial state - app title is displayed
      expect(find.text('TV Assassin'), findsOneWidget);

      // Verify assassin button is displayed
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Kill TVs'), findsOneWidget);

      // Tap the assassin button to trigger transmission
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify button is pressed (animation happens quickly)
      await tester.pump(Duration(milliseconds: 100));

      // Wait for transmission to complete
      await tester.pump(Duration(seconds: 1));

      // Verify app is still running and UI is responsive
      expect(find.text('TV Assassin'), findsOneWidget);

      // Verify command repository has expected data
      final commandRepository = CommandRepository();
      expect(commandRepository.brandCount, greaterThanOrEqualTo(15));
      expect(commandRepository.totalCodeCount, greaterThanOrEqualTo(15));

      // Verify specific brands exist
      expect(commandRepository.getCodesForBrand('Samsung'), isNotNull);
      expect(commandRepository.getCodesForBrand('LG'), isNotNull);
    });
  });
}
