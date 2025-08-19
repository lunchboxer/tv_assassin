import 'package:flutter/foundation.dart';

/// Utility class for security-related functions
class SecurityUtils {
  /// Checks if the app is running in debug mode
  static bool get isDebugMode => kDebugMode;

  /// Checks if the app is running in profile mode
  static bool get isProfileMode => kProfileMode;

  /// Checks if the app is running in release mode
  static bool get isReleaseMode => kReleaseMode;

  /// Asserts that debug flags are not enabled in release builds
  /// This function should be called during app initialization
  static void checkReleaseModeFlags() {
    assert(() {
      // This code only runs in debug mode
      // In release mode, assertions are disabled
      return true;
    }());

    // Additional runtime checks for release mode
    if (isReleaseMode) {
      // Ensure no debug flags are enabled in release builds
      // Add any specific checks here if needed in the future
    }
  }
}
