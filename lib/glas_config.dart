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
  /// with larger radii, softer contrast, and a more editorial feel.
  /// Recommended for lifestyle, creative, or content-focused apps.
  static bool useWarmPreset = false;

  /// ──────────────────────────────────────────────────────────
  /// Optional overrides (null → derived from Theme + preset)
  /// ──────────────────────────────────────────────────────────

  /// Base tint blended over [ColorScheme.surface].
  /// Default: neutral (null) or warm pink when preset is active.
  static Color? glassTintColor;

  /// Color for glass borders.
  static Color? glassBorderColor;

  /// Color for the NavigationBar sliding indicator highlight.
  /// Default: derived from [ColorScheme.primary] at runtime.
  static Color? navigationIndicatorColor;

  /// Opacity of the glass overlay (0.0 – 1.0).
  static double? glassOpacity;

  /// Gaussian blur in pixels applied to content behind the glass.
  static double? glassBlur;

  /// Border opacity (0.0 – 1.0). Controls how visible the glass edge is.
  static double? borderOpacity;

  /// Highlight / specular light intensity (0.0 – 1.0).
  /// Higher values = more glossy, reflective glass.
  static double? highlightIntensity;

  /// Shadow opacity (0.0 – 1.0).
  static double? shadowOpacity;

  /// Corner radius for cards, dialogs, sheets.
  static double? largeRadius;

  /// Corner radius for nav bar, app bar.
  static double? mediumRadius;

  /// ──────────────────────────────────────────────────────────
  /// Derived values — read theme at runtime.
  /// ──────────────────────────────────────────────────────────

  static bool get _w => useWarmPreset;

  /// Returns the effective glass color for the current [context] theme.
  static Color glassColor(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final base = glassTintColor ?? (_w
        ? Color.lerp(cs.surface, const Color(0xFFFFF0F5), 0.30)!
        : cs.surface);
    return base.withValues(alpha: glassOpacity ?? (_w ? 0.78 : 0.82));
  }

  /// Returns the effective glass border color.
  static Color borderColor(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final raw = glassBorderColor ?? (_w
        ? Color.lerp(cs.outlineVariant, const Color(0xFFFFC0CB), 0.20)!
        : cs.outlineVariant);
    return raw.withValues(alpha: borderOpacity ?? (_w ? 0.50 : 0.35));
  }

  /// Returns the effective shadow color.
  static Color shadowColor(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return cs.shadow.withValues(alpha: shadowOpacity ?? (_w ? 0.15 : 0.10));
  }

  /// Returns the effective blur amount in pixels.
  static double blur() => glassBlur ?? (_w ? 22.0 : 18.0);

  /// Returns the effective highlight / specular intensity.
  static double highlight() => highlightIntensity ?? (_w ? 0.50 : 0.35);

  /// Returns the effective large corner radius (cards, dialogs).
  static double largeRadiusValue() => largeRadius ?? (_w ? 28.0 : 20.0);

  /// Returns the effective medium corner radius (bars).
  static double mediumRadiusValue() => mediumRadius ?? (_w ? 24.0 : 16.0);
}
