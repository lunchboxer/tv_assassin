import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_assassin/ui/assassin_button.dart';

void main() {
  group('AssassinButton', () {
    testWidgets('should display button with text and icon', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AssassinButton(onPressed: nop)),
        ),
      );

      // Verify button is displayed
      expect(find.byType(ElevatedButton), findsOneWidget);

      // Verify text is displayed
      expect(find.text('Kill TVs'), findsOneWidget);

      // Verify icon is displayed
      expect(find.byIcon(Icons.tv_off), findsOneWidget);
    });

    testWidgets('should call callback when pressed', (
      WidgetTester tester,
    ) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: AssassinButton(onPressed: () => pressed = true)),
        ),
      );

      // Tap the button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify callback was called
      expect(pressed, isTrue);
    });

    testWidgets('should be disabled when transmitting', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AssassinButton(onPressed: nop, isTransmitting: true),
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
