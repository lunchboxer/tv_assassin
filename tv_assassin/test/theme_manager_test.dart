import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_assassin/viewmodel/theme_manager.dart';

void main() {
  group('ThemeManager', () {
    late ThemeManager themeManager;

    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      themeManager = ThemeManager();
    });

    test('should initialize with system theme by default', () {
      expect(themeManager.currentTheme, ThemeMode.system);
    });

    test('should set and save theme mode', () async {
      await themeManager.setTheme(ThemeMode.dark);
      expect(themeManager.currentTheme, ThemeMode.dark);
    });

    test('should load saved theme preference', () async {
      // Set a preference directly in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('@theme_mode', ThemeMode.light.index);

      // Create a new ThemeManager and load preferences
      final newThemeManager = ThemeManager();
      await newThemeManager.loadSavedTheme();

      expect(newThemeManager.currentTheme, ThemeMode.light);
    });

    test('should toggle between light and dark theme', () async {
      // Start with dark theme
      await themeManager.setTheme(ThemeMode.dark);
      expect(themeManager.currentTheme, ThemeMode.dark);

      // Toggle to light
      await themeManager.toggleTheme();
      expect(themeManager.currentTheme, ThemeMode.light);

      // Toggle back to dark
      await themeManager.toggleTheme();
      expect(themeManager.currentTheme, ThemeMode.dark);
    });

    test('should handle invalid saved theme index gracefully', () async {
      // Set an invalid theme index
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('@theme_mode', 999); // Invalid index

      // Create a new ThemeManager and load preferences
      final newThemeManager = ThemeManager();
      await newThemeManager.loadSavedTheme();

      // Should default to system theme
      expect(newThemeManager.currentTheme, ThemeMode.system);
    });
  });
}
