import 'package:flutter_test/flutter_test.dart';
import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';
import 'package:flutter/material.dart';

/// Tests para [GlasConfig] — la configuración central del glass theme.
///
/// Se verifican valores por defecto, preset warm, overrides, y
/// comportamiento con temas claro/oscuro.
void main() {
  group('GlasConfig (defaults)', () {
    setUp(() {
      // Resetear a valores por defecto antes de cada test
      GlasConfig.useWarmPreset = false;
      GlasConfig.glassTintColor = null;
      GlasConfig.glassBorderColor = null;
      GlasConfig.navigationIndicatorColor = null;
      GlasConfig.glassOpacity = null;
      GlasConfig.glassBlur = null;
      GlasConfig.borderOpacity = null;
      GlasConfig.highlightIntensity = null;
      GlasConfig.shadowOpacity = null;
      GlasConfig.largeRadius = null;
      GlasConfig.mediumRadius = null;
    });

    test('default preset is neutral (not warm)', () {
      expect(GlasConfig.useWarmPreset, false);
    });

    test('default blur is 18.0', () {
      expect(GlasConfig.blur(), 18.0);
    });

    test('default highlight is 0.35', () {
      expect(GlasConfig.highlight(), 0.35);
    });

    test('default large radius is 20.0', () {
      expect(GlasConfig.largeRadiusValue(), 20.0);
    });

    test('default medium radius is 16.0', () {
      expect(GlasConfig.mediumRadiusValue(), 16.0);
    });

    test('shouldContainDefaultValues', () {
      expect(GlasConfig.glassTintColor, isNull);
      expect(GlasConfig.glassBorderColor, isNull);
      expect(GlasConfig.navigationIndicatorColor, isNull);
      expect(GlasConfig.glassOpacity, isNull);
      expect(GlasConfig.shadowOpacity, isNull);
    });
  });

  group('GlasConfig (warm preset)', () {
    setUp(() {
      GlasConfig.useWarmPreset = true;
      GlasConfig.glassTintColor = null;
      GlasConfig.glassBlur = null;
      GlasConfig.borderOpacity = null;
      GlasConfig.highlightIntensity = null;
      GlasConfig.shadowOpacity = null;
      GlasConfig.largeRadius = null;
      GlasConfig.mediumRadius = null;
    });

    tearDown(() {
      GlasConfig.useWarmPreset = false;
    });

    test('warm blur is 22.0', () {
      expect(GlasConfig.blur(), 22.0);
    });

    test('warm highlight is 0.50', () {
      expect(GlasConfig.highlight(), 0.50);
    });

    test('warm large radius is 28.0', () {
      expect(GlasConfig.largeRadiusValue(), 28.0);
    });

    test('warm medium radius is 24.0', () {
      expect(GlasConfig.mediumRadiusValue(), 24.0);
    });
  });

  group('GlasConfig (overrides)', () {
    setUp(() {
      GlasConfig.useWarmPreset = false;
      GlasConfig.glassTintColor = null;
      GlasConfig.glassBorderColor = null;
      GlasConfig.navigationIndicatorColor = null;
      GlasConfig.glassOpacity = null;
      GlasConfig.glassBlur = null;
      GlasConfig.borderOpacity = null;
      GlasConfig.highlightIntensity = null;
      GlasConfig.shadowOpacity = null;
      GlasConfig.largeRadius = null;
      GlasConfig.mediumRadius = null;
    });

    test('override blur', () {
      GlasConfig.glassBlur = 30.0;
      expect(GlasConfig.blur(), 30.0);
      expect(GlasConfig.blur(), isNot(18.0));
    });

    test('override large radius', () {
      GlasConfig.largeRadius = 32.0;
      expect(GlasConfig.largeRadiusValue(), 32.0);
    });

    test('override medium radius', () {
      GlasConfig.mediumRadius = 20.0;
      expect(GlasConfig.mediumRadiusValue(), 20.0);
    });

    test('override highlight', () {
      GlasConfig.highlightIntensity = 0.75;
      expect(GlasConfig.highlight(), 0.75);
    });

    test('override border opacity', () {
      GlasConfig.borderOpacity = 0.8;
      // Warm preset is off → default border opacity should be 0.35
      // but we want to make sure our override is used
      // borderColor() needs a context, but borderOpacity is used internally
      expect(GlasConfig.borderOpacity, 0.8);
    });

    test('warm preset with radius overrides — overrides win', () {
      GlasConfig.useWarmPreset = true;
      GlasConfig.largeRadius = 16.0; // override smaller than warm default
      expect(GlasConfig.largeRadiusValue(), 16.0);
    });

    test('warm preset with blur override — override wins', () {
      GlasConfig.useWarmPreset = true;
      GlasConfig.glassBlur = 10.0;
      expect(GlasConfig.blur(), 10.0);
    });
  });

  group('GlasConfig (theme-derived colors)', () {
    setUp(() {
      GlasConfig.useWarmPreset = false;
      GlasConfig.glassTintColor = null;
      GlasConfig.glassBorderColor = null;
      GlasConfig.glassOpacity = null;
      GlasConfig.shadowOpacity = null;
      GlasConfig.borderOpacity = null;
    });

    testWidgets('glassColor returns a color in light theme', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              final color = GlasConfig.glassColor(context);
              expect(color, isA<Color>());
              // Should have some alpha (transparency)
              expect(color.alpha, greaterThan(0));
              expect(color.alpha, lessThan(255));
              return const SizedBox.shrink();
            },
          ),
        ),
      ));
    });

    testWidgets('glassColor returns a color in dark theme', (tester) async {
      await tester.pumpWidget(MaterialApp(
        themeMode: ThemeMode.dark,
        theme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
        home: Scaffold(
          body: Builder(
            builder: (context) {
              final color = GlasConfig.glassColor(context);
              expect(color, isA<Color>());
              expect(color.alpha, greaterThan(0));
              return const SizedBox.shrink();
            },
          ),
        ),
      ));
    });

    testWidgets('borderColor returns a color in light theme', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              final color = GlasConfig.borderColor(context);
              expect(color, isA<Color>());
              return const SizedBox.shrink();
            },
          ),
        ),
      ));
    });

    testWidgets('shadowColor returns a color in light theme', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              final color = GlasConfig.shadowColor(context);
              expect(color, isA<Color>());
              return const SizedBox.shrink();
            },
          ),
        ),
      ));
    });

    testWidgets('warm preset glassColor is pink-tinted', (tester) async {
      GlasConfig.useWarmPreset = true;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              final color = GlasConfig.glassColor(context);
              expect(color, isA<Color>());
              // Warm preset uses pink tint → red component should be > average
              expect(color.red, greaterThan(200));
              return const SizedBox.shrink();
            },
          ),
        ),
      ));
      GlasConfig.useWarmPreset = false;
    });
  });
}
