import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_assassin/ui/theme_toggle.dart';

void main() {
  group('ThemeToggle', () {
    testWidgets('should display light mode icon in dark theme', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(brightness: Brightness.dark),
          home: Scaffold(body: ThemeToggle(onToggle: nop)),
        ),
      );

      // Verify light mode icon is displayed
      expect(find.byIcon(Icons.light_mode), findsOneWidget);
    });

    testWidgets('should display dark mode icon in light theme', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(brightness: Brightness.light),
          home: Scaffold(body: ThemeToggle(onToggle: nop)),
        ),
      );

      // Verify dark mode icon is displayed
      expect(find.byIcon(Icons.dark_mode), findsOneWidget);
    });

    testWidgets('should call callback when pressed', (
      WidgetTester tester,
    ) async {
      bool toggled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: ThemeToggle(onToggle: () => toggled = true)),
        ),
      );

      // Tap the toggle
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      // Verify callback was called
      expect(toggled, isTrue);
    });
  });
}

// No-operation function
void nop() {}
