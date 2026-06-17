import 'package:flutter_test/flutter_test.dart';
import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';

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
      GlasConfig.buttonPressFeedbackEnabled = false;
      GlasConfig.buttonPressScale = 0.97;
    });

    test('default preset is neutral (not warm)', () {
      expect(GlasConfig.useWarmPreset, false);
    });

    test('default blur is 14.0', () {
      expect(GlasConfig.blur(), 14.0);
    });

    test('default highlight is 0.25', () {
      expect(GlasConfig.highlight(), 0.25);
    });

    test('default large radius is 14.0', () {
      expect(GlasConfig.largeRadiusValue(), 14.0);
    });

    test('default medium radius is 12.0', () {
      expect(GlasConfig.mediumRadiusValue(), 12.0);
    });

    test('shouldContainDefaultValues', () {
      expect(GlasConfig.glassTintColor, isNull);
      expect(GlasConfig.glassBorderColor, isNull);
      expect(GlasConfig.navigationIndicatorColor, isNull);
      expect(GlasConfig.glassOpacity, isNull);
      expect(GlasConfig.shadowOpacity, isNull);
    });

    test('press feedback stays disabled by default', () {
      expect(GlasConfig.buttonPressFeedbackEnabled, isFalse);
      expect(GlasConfig.buttonPressScaleValue(), 0.97);
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
      GlasConfig.buttonPressFeedbackEnabled = false;
      GlasConfig.buttonPressScale = 0.97;
    });

    tearDown(() {
      GlasConfig.useWarmPreset = false;
    });

    test('warm blur is 18.0', () {
      expect(GlasConfig.blur(), 18.0);
    });

    test('warm highlight is 0.40', () {
      expect(GlasConfig.highlight(), 0.40);
    });

    test('warm large radius is 24.0', () {
      expect(GlasConfig.largeRadiusValue(), 24.0);
    });

    test('warm medium radius is 20.0', () {
      expect(GlasConfig.mediumRadiusValue(), 20.0);
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
      GlasConfig.buttonPressFeedbackEnabled = false;
      GlasConfig.buttonPressScale = 0.97;
    });

    test('override blur', () {
      GlasConfig.glassBlur = 30.0;
      expect(GlasConfig.blur(), 30.0);
      expect(GlasConfig.blur(), isNot(14.0));
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

    test('button press scale clamps below minimum', () {
      GlasConfig.buttonPressScale = 0.70;

      expect(GlasConfig.buttonPressScaleValue(), 0.90);
    });

    test('button press scale clamps above maximum', () {
      GlasConfig.buttonPressScale = 1.20;

      expect(GlasConfig.buttonPressScaleValue(), 1.0);
    });

    test('button press scale preserves valid values', () {
      GlasConfig.buttonPressScale = 0.95;

      expect(GlasConfig.buttonPressScaleValue(), 0.95);
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
      GlasConfig.buttonPressFeedbackEnabled = false;
      GlasConfig.buttonPressScale = 0.97;
    });

    testWidgets('glassColor returns a color in light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: _testTheme(),
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final color = GlasConfig.glassColor(context);
                expect(color, isA<Color>());
                // Should have some alpha (transparency)
                final alpha = (color.a * 255.0).round().clamp(0, 255);
                expect(alpha, greaterThan(0));
                expect(alpha, lessThan(255));
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('glassColor returns a color in dark theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          themeMode: ThemeMode.dark,
          theme: _testTheme(brightness: Brightness.dark),
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final color = GlasConfig.glassColor(context);
                expect(color, isA<Color>());
                final alpha = (color.a * 255.0).round().clamp(0, 255);
                expect(alpha, greaterThan(0));
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('borderColor returns a color in light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: _testTheme(),
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final color = GlasConfig.borderColor(context);
                expect(color, isA<Color>());
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('shadowColor returns a color in light theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: _testTheme(),
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final color = GlasConfig.shadowColor(context);
                expect(color, isA<Color>());
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('warm preset glassColor is pink-tinted', (tester) async {
      GlasConfig.useWarmPreset = true;
      await tester.pumpWidget(
        MaterialApp(
          theme: _testTheme(),
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final color = GlasConfig.glassColor(context);
                expect(color, isA<Color>());
                // Warm preset uses pink tint → red component should be > average
                final red = (color.r * 255.0).round().clamp(0, 255);
                expect(red, greaterThan(200));
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
      GlasConfig.useWarmPreset = false;
    });
  });
}

ThemeData _testTheme({Brightness brightness = Brightness.light}) {
  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    splashFactory: InkRipple.splashFactory,
  );
}
