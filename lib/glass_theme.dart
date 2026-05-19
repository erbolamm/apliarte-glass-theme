import 'package:flutter/material.dart';

import 'glas_config.dart';

/// Proveedor único de [ThemeData] glass para cualquier app.
///
/// Uso:
/// ```dart
/// MaterialApp(
///   theme: GlassTheme.light(Colors.indigo),
///   darkTheme: GlassTheme.dark(Colors.indigo),
/// );
/// ```
///
/// Para extensiones de tema propias de la app (tipografía, etc.), usá [extensions]:
/// ```dart
/// GlassTheme.light(colorApp, extensions: [AppTypography.fromBase()])
/// ```
class GlassTheme {
  GlassTheme._();

  static const double _defaultFontSize = 16.0;

  /// Tema claro glass.
  static ThemeData light(
    MaterialColor seedColor, {
    double? fontSize,
    List<ThemeExtension> extensions = const [],
  }) {
    final scheme = ColorScheme.fromSeed(seedColor: seedColor);
    GlasConfig.updateColorScheme(scheme);
    final baseFontSize = fontSize ?? _defaultFontSize;
    final cardColor = seedColor.shade100.withValues(alpha: 200 / 255);
    final appBarTint = Colors.white.withValues(alpha: 0.05);
    final radius = GlasConfig.largeRadiusValue();
    final appBarRadius = GlasConfig.mediumRadiusValue();

    return ThemeData(
      useMaterial3: true,
      primarySwatch: seedColor,
      colorScheme: scheme,
      textTheme: _buildTextTheme(baseFontSize),
      extensions: extensions,
      appBarTheme: AppBarTheme(
        backgroundColor: appBarTint,
        foregroundColor: Colors.black,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(appBarRadius),
          ),
        ),
        toolbarHeight: kToolbarHeight,
      ),
      cardTheme: CardThemeData(
        margin: const EdgeInsets.all(4),
        color: cardColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: appBarTint,
        elevation: 0,
      ),
      scaffoldBackgroundColor: scheme.surface,
    );
  }

  /// Tema oscuro glass.
  static ThemeData dark(
    MaterialColor seedColor, {
    double? fontSize,
    List<ThemeExtension> extensions = const [],
  }) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    );
    GlasConfig.updateColorScheme(scheme);
    final baseFontSize = fontSize ?? _defaultFontSize;
    final cardColor = Colors.grey.shade900.withValues(alpha: 0.95);
    final dialogColor = Colors.grey.shade900.withValues(alpha: 0.98);
    final appBarTint = Colors.black.withValues(alpha: 0.5);
    final radius = GlasConfig.largeRadiusValue();
    final appBarRadius = GlasConfig.mediumRadiusValue();

    return ThemeData(
      useMaterial3: true,
      primarySwatch: seedColor,
      colorScheme: scheme,
      textTheme: _buildTextTheme(baseFontSize),
      extensions: extensions,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(appBarRadius),
          ),
        ),
        toolbarHeight: kToolbarHeight,
      ),
      cardTheme: CardThemeData(
        margin: EdgeInsets.zero,
        color: cardColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: dialogColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: appBarTint,
        elevation: 0,
      ),
      scaffoldBackgroundColor: Colors.grey.shade900,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: seedColor,
          foregroundColor: Colors.white,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: seedColor,
        foregroundColor: Colors.white,
      ),
    );
  }

  static TextTheme _buildTextTheme(double fontSize) {
    return TextTheme(
      bodySmall: TextStyle(fontSize: fontSize * 0.85),
      bodyMedium: TextStyle(fontSize: fontSize),
      bodyLarge: TextStyle(fontSize: fontSize * 1.15),
      titleSmall: TextStyle(fontSize: fontSize * 1.3, fontWeight: FontWeight.w500),
      titleMedium: TextStyle(fontSize: fontSize * 1.5, fontWeight: FontWeight.w500),
      titleLarge: TextStyle(fontSize: fontSize * 1.8, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(fontSize: fontSize * 1.4, fontWeight: FontWeight.w400),
      headlineMedium: TextStyle(fontSize: fontSize * 1.6, fontWeight: FontWeight.w400),
      headlineLarge: TextStyle(fontSize: fontSize * 2.0, fontWeight: FontWeight.w400),
      labelSmall: TextStyle(fontSize: fontSize * 0.75, fontWeight: FontWeight.w500),
      labelMedium: TextStyle(fontSize: fontSize * 0.85, fontWeight: FontWeight.w500),
      labelLarge: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
    );
  }
}
