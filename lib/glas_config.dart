import 'package:flutter/material.dart';

/// Single configuration file for all glass theme settings.
///
/// To disable the glass theme entirely:
/// 1. Remove this file from the project
/// 2. Remove `apliarte_glass_theme` from `pubspec.yaml`
/// 3. Change `import 'package:apliarte_glass_theme/...'` back to `package:flutter/material.dart'
///
/// All values are overridable by the user at app startup.
class GlasConfig {
  /// ──────────────────────────────────────────────
  /// Global glass defaults
  /// ──────────────────────────────────────────────
  static double thickness = 20.0;
  static double blur = 16.0;
  static double lightIntensity = 0.6;
  static double refractiveIndex = 1.5;

  /// Colors for light theme
  static Color lightGlassColor = const Color(0xCCFFFFFF);
  static Color lightBorderColor = const Color(0x99FFFFFF);
  static Color lightShadowColor = const Color(0x1A000000);

  /// Colors for dark theme
  static Color darkGlassColor = const Color(0xCC1E1E2E);
  static Color darkBorderColor = const Color(0x33FFFFFF);
  static Color darkShadowColor = const Color(0x40000000);

  /// ──────────────────────────────────────────────
  /// Per-component overrides (null = use global defaults)
  /// ──────────────────────────────────────────────
  static double? appBarBlur;
  static double? appBarBorderRadius;
  static double? appBarHeight;

  static double? cardBlur;
  static double? cardBorderRadius;
  static double? cardElevation;

  static double? navBarBlur;
  static double? navBarBorderRadius;
  static double? navBarHeight;

  static double? bottomAppBarBlur;
  static double? bottomAppBarBorderRadius;

  static double? dialogBlur;
  static double? dialogBorderRadius;

  /// ──────────────────────────────────────────────
  /// Helpers
  /// ──────────────────────────────────────────────
  static Color glassColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkGlassColor
          : lightGlassColor;

  static Color borderColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkBorderColor
          : lightBorderColor;

  static Color shadowColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkShadowColor
          : lightShadowColor;
}
