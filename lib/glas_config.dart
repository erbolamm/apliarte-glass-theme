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
  /// AppBar (BackdropFilter nativo)
  /// ──────────────────────────────────────────────────────────

  /// Intensidad de blur del AppBar. null → usa [blur].
  static double? appBarBlurSigma;

  /// Radio inferior del AppBar. null → usa [mediumRadiusValue].
  static double? appBarBottomRadius;

  /// Tinte del vidrio del AppBar. null → usa [glassColor] con [appBarGlassOpacity].
  static Color? appBarGlassTint;

  /// Opacidad del vidrio del AppBar (0.0 – 1.0).
  /// Un valor bajo (~0.15) deja respirar el blur y se ve frosted glass real.
  /// null → 0.18 en claro / 0.25 en oscuro.
  static double? appBarGlassOpacity;

  /// ──────────────────────────────────────────────────────────
  /// Liquid highlight system (acento líquido)
  /// ──────────────────────────────────────────────────────────

  /// Master switch para el acento líquido/glow en todos los componentes.
  static bool liquidHighlightEnabled = true;

  /// Intensidad global del acento líquido (0.0 – 1.0).
  /// Cada componente escala esta intensidad según su jerarquía:
  ///   AppBar → 0.3× | Card → 0.5× | NavBar selected → 1.0× | CTA → 1.4×
  static double liquidHighlightIntensity = 0.18;

  /// Color del acento líquido. null → [ColorScheme.primary].
  static Color? liquidHighlightColor;

  /// Blur del glow líquido en píxeles. null → automático según intensidad.
  static double? liquidHighlightBlur;

  /// Opacidad base del acento. null → automática según intensidad.
  static double? liquidHighlightOpacity;

  /// Preset rápido para el sistema de acentos.
  ///   subtle    → intensidad baja, apenas perceptible
  ///   balanced  → intensidad media, valor por defecto
  ///   expressive → intensidad alta, glow marcado
  static String liquidHighlightPreset = 'balanced';

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
  static double blur() => glassBlur ?? (_w ? 18.0 : 14.0);

  /// Returns the effective highlight / specular intensity.
  static double highlight() => highlightIntensity ?? (_w ? 0.40 : 0.25);

  /// Returns the effective large corner radius (cards, dialogs).
  static double largeRadiusValue() => largeRadius ?? (_w ? 24.0 : 14.0);

  /// Returns the effective medium corner radius (bars).
  static double mediumRadiusValue() => mediumRadius ?? (_w ? 20.0 : 12.0);

  /// Returns the AppBar glass color with its propia opacidad baja.
  /// Un valor ~0.15 deja respirar el blur para un frosted glass real.
  static Color appBarColor(BuildContext context) {
    if (appBarGlassTint != null) return appBarGlassTint!;
    final cs = Theme.of(context).colorScheme;
    final isDark = cs.brightness == Brightness.dark;
    final opacity = appBarGlassOpacity ?? (isDark ? 0.25 : 0.18);
    final base = glassTintColor ?? cs.surface;
    return base.withValues(alpha: opacity);
  }

  // ── Color scheme storage ─────────────────────────────
  //
  // Allows semantic color access without [BuildContext].
  // [GlassTheme.light] / [GlassTheme.dark] populate this
  // automatically. Falls back to a blue seed scheme when
  // uninitialized.

  static ColorScheme? _colorScheme;
  static final ColorScheme _defaultScheme =
      ColorScheme.fromSeed(seedColor: Colors.blue);
  static ColorScheme get _scheme => _colorScheme ?? _defaultScheme;

  /// Called by [GlassTheme] when a new theme is created.
  static void updateColorScheme(ColorScheme scheme) {
    _colorScheme = scheme;
  }

  /// Full [ColorScheme] for bulk access.
  static ColorScheme get colorScheme => _scheme;

  // ── Primary ──────────────────────────────────────────

  static Color get primary => _scheme.primary;
  static Color get onPrimary => _scheme.onPrimary;
  static Color get primaryContainer => _scheme.primaryContainer;
  static Color get onPrimaryContainer => _scheme.onPrimaryContainer;

  // ── Secondary ────────────────────────────────────────

  static Color get secondary => _scheme.secondary;
  static Color get onSecondary => _scheme.onSecondary;
  static Color get secondaryContainer => _scheme.secondaryContainer;
  static Color get onSecondaryContainer => _scheme.onSecondaryContainer;

  // ── Tertiary ─────────────────────────────────────────

  static Color get tertiary => _scheme.tertiary;
  static Color get onTertiary => _scheme.onTertiary;
  static Color get tertiaryContainer => _scheme.tertiaryContainer;
  static Color get onTertiaryContainer => _scheme.onTertiaryContainer;

  // ── Surface ──────────────────────────────────────────

  static Color get surface => _scheme.surface;
  static Color get onSurface => _scheme.onSurface;
  // ignore: deprecated_member_use
  static Color get surfaceVariant => _scheme.surfaceVariant;
  static Color get onSurfaceVariant => _scheme.onSurfaceVariant;
  static Color get surfaceContainerHighest => _scheme.surfaceContainerHighest;

  // ── Error ────────────────────────────────────────────

  static Color get error => _scheme.error;
  static Color get onError => _scheme.onError;
  static Color get errorContainer => _scheme.errorContainer;
  static Color get onErrorContainer => _scheme.onErrorContainer;

  // ── Outline ──────────────────────────────────────────

  static Color get outline => _scheme.outline;
  static Color get outlineVariant => _scheme.outlineVariant;

  // ── Misc ─────────────────────────────────────────────

  static Color get shadow => _scheme.shadow;
  static Color get scrim => _scheme.scrim;
}
