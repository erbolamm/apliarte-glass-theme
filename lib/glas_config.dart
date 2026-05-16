import 'package:flutter/material.dart';

/// Single configuration point for ApliArte Glass Theme.
///
/// By default, everything is derived from [Theme.of(context).colorScheme]
/// at runtime — no external setup needed. Just install and import.
///
/// To customize, override any static field before running your app:
/// ```dart
/// void main() {
///   GlasConfig.useWarmPreset = true;
///   runApp(const MyApp());
/// }
/// ```
///
/// To disable glass entirely: remove this package from pubspec.yaml
/// and switch back to `import 'package:flutter/material.dart'`.
class GlasConfig {
  /// ──────────────────────────────────────────────────────────
  /// Preset: warm glass
  /// ──────────────────────────────────────────────────────────
  ///
  /// When true, glass defaults shift towards a warmer, rosier tone
  /// with larger radii and softer contrast.
  static bool useWarmPreset = false;

  /// ──────────────────────────────────────────────────────────
  /// Optional overrides (null → derived from Theme + preset)
  /// ──────────────────────────────────────────────────────────

  /// Base tint blended over [ColorScheme.surface].
  static Color? glassTintColor;

  /// Color for glass borders.
  static Color? glassBorderColor;

  /// Color for the NavigationBar sliding indicator.
  static Color? navigationIndicatorColor;

  /// Opacity of the glass overlay (0.0 – 1.0).
  static double? glassOpacity;       // null → 0.80

  /// Gaussian blur in pixels.
  static double? glassBlur;          // null → 20.0 (warm) / 16.0 (default)

  /// Border opacity (0.0 – 1.0).
  static double? borderOpacity;      // null → 0.55 (warm) / 0.40 (default)

  /// Highlight / specular intensity (0.0 – 1.0).
  static double? highlightIntensity; // null → 0.55 (warm) / 0.40 (default)

  /// Shadow opacity (0.0 – 1.0).
  static double? shadowOpacity;      // null → 0.12 (warm) / 0.08 (default)

  /// Corner radius for cards, dialogs, sheets.
  static double? largeRadius;        // null → 28 (warm) / 20 (default)

  /// Corner radius for nav bar, app bar.
  static double? mediumRadius;       // null → 24 (warm) / 16 (default)

  /// ──────────────────────────────────────────────────────────
  /// Derived values (read from theme at runtime)
  /// ──────────────────────────────────────────────────────────

  static bool get _warm => useWarmPreset;

  /// Returns the effective glass color for the current theme.
  static Color glassColor(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final base = glassTintColor ?? (_warm
        ? Color.lerp(cs.surface, const Color(0xFFFFF0F5), 0.35)!
        : cs.surface);
    return base.withValues(alpha: glassOpacity ?? (_warm ? 0.78 : 0.82));
  }

  /// Returns the effective glass border color.
  static Color borderColor(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final raw = glassBorderColor ?? cs.outlineVariant;
    return raw.withValues(alpha: borderOpacity ?? (_warm ? 0.55 : 0.40));
  }

  /// Returns the effective shadow color.
  static Color shadowColor(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return cs.shadow.withValues(alpha: shadowOpacity ?? (_warm ? 0.12 : 0.08));
  }

  /// Returns the effective blur in pixels.
  static double blur() => glassBlur ?? (_warm ? 20.0 : 16.0);

  /// Returns the effective highlight intensity.
  static double highlight() => highlightIntensity ?? (_warm ? 0.55 : 0.40);

  /// Returns the effective large corner radius.
  static double largeRadiusValue() => largeRadius ?? (_warm ? 28.0 : 20.0);

  /// Returns the effective medium corner radius.
  static double mediumRadiusValue() => mediumRadius ?? (_warm ? 24.0 : 16.0);
}
