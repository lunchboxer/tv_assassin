import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_assassin/ui/main_screen.dart';

void main() {
  group('MainScreen', () {
    testWidgets('should display title and instructions', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MainScreen(
            onAssassinButtonPressed: nop, // Use nop function instead of {}
            onThemeTogglePressed: nop, // Use nop function instead of {}
          ),
        ),
      );

      // Verify title is displayed
      expect(find.text('TV Assassin'), findsOneWidget);

      // Verify instructions are displayed
      expect(
        find.text('Point your device at TVs and press the button'),
        findsOneWidget,
      );
    });

    testWidgets('should display assassin button', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MainScreen(
            onAssassinButtonPressed: nop, // Use nop function instead of {}
            onThemeTogglePressed: nop, // Use nop function instead of {}
          ),
        ),
      );

      // Verify assassin button is displayed
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Kill TVs'), findsOneWidget);
    });

    testWidgets('should call callback when button is pressed', (
      WidgetTester tester,
    ) async {
      bool buttonPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: MainScreen(
            onAssassinButtonPressed: () => buttonPressed = true,
            onThemeTogglePressed: nop, // Use nop function instead of {}
          ),
        ),
      );

      // Tap the button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify callback was called
      expect(buttonPressed, isTrue);
    });

    testWidgets('should disable button when transmitting', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MainScreen(
            onAssassinButtonPressed: nop, // Use nop function instead of {}
            onThemeTogglePressed: nop, // Use nop function instead of {}
            isTransmitting: true,
          ),
        ),
      );

      // Verify button is disabled
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });
  });
}

// No-operation function
void nop() {}
