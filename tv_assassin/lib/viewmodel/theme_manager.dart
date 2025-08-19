import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages the application theme and persists user preference
class ThemeManager with ChangeNotifier {
  static const String _themeKey = '@theme_mode';

  ThemeMode _currentTheme = ThemeMode.system;

  /// Get the current theme mode
  ThemeMode get currentTheme => _currentTheme;

  /// Initialize the theme manager by loading saved preferences
  Future<void> init() async {
    await loadSavedTheme();
  }

  /// Load saved theme preference from SharedPreferences
  Future<void> loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();

    // Default to system theme if no preference saved
    final themeIndex = prefs.getInt(_themeKey) ?? ThemeMode.system.index;

    // Validate the index is within ThemeMode enum bounds
    if (themeIndex >= 0 && themeIndex < ThemeMode.values.length) {
      _currentTheme = ThemeMode.values[themeIndex];
    } else {
      _currentTheme = ThemeMode.system;
    }

    notifyListeners();
  }

  /// Set and save the theme mode
  Future<void> setTheme(ThemeMode mode) async {
    _currentTheme = mode;
    notifyListeners();

    // Save preference
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, mode.index);
  }

  /// Toggle between light and dark theme (skipping system mode)
  Future<void> toggleTheme() async {
    if (_currentTheme == ThemeMode.dark) {
      await setTheme(ThemeMode.light);
    } else {
      await setTheme(ThemeMode.dark);
    }
  }
}
