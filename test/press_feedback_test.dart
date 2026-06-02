import 'package:apliarte_glass_theme/src/helpers/press_feedback.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('buildPressFeedback', () {
    testWidgets(
      'animates only while a Material owner keeps the shared controller pressed',
      (tester) async {
        final controller = WidgetStatesController();

        await tester.pumpWidget(
          _TestHarness(
            child: buildPressFeedback(
              statesController: controller,
              enabled: true,
              pressedScale: 0.94,
              child: material.TextButton(
                statesController: controller,
                onPressed: () {},
                child: const material.Text('Tap me'),
              ),
            ),
          ),
        );

        expect(_animatedScale(tester).scale, 1.0);

        final gesture = await tester.press(find.byType(material.TextButton));
        await tester.pump();

        expect(_animatedScale(tester).scale, 0.94);

        await gesture.up();
        await tester.pumpAndSettle();

        expect(_animatedScale(tester).scale, 1.0);
      },
    );

    testWidgets('does not animate when enabled is false', (tester) async {
      final controller = WidgetStatesController();

      await tester.pumpWidget(
        _TestHarness(
          child: buildPressFeedback(
            statesController: controller,
            enabled: false,
            pressedScale: 0.94,
            child: material.TextButton(
              statesController: controller,
              onPressed: () {},
              child: const material.Text('Tap me'),
            ),
          ),
        ),
      );

      final gesture = await tester.press(find.byType(material.TextButton));
      await tester.pump();

      expect(_animatedScale(tester).scale, 1.0);

      await gesture.up();
      await tester.pumpAndSettle();
    });

    testWidgets(
      'does not animate when pressed state comes from a different controller',
      (tester) async {
        final helperController = WidgetStatesController();
        final ownerController = WidgetStatesController();

        await tester.pumpWidget(
          _TestHarness(
            child: buildPressFeedback(
              statesController: helperController,
              enabled: true,
              pressedScale: 0.94,
              child: material.TextButton(
                statesController: ownerController,
                onPressed: () {},
                child: const material.Text('Tap me'),
              ),
            ),
          ),
        );

        final gesture = await tester.press(find.byType(material.TextButton));
        await tester.pump();

        expect(_animatedScale(tester).scale, 1.0);

        await gesture.up();
        await tester.pumpAndSettle();
      },
    );
  });
}

material.AnimatedScale _animatedScale(WidgetTester tester) {
  return tester.widget<material.AnimatedScale>(
    find.byType(material.AnimatedScale),
  );
}

class _TestHarness extends StatelessWidget {
  const _TestHarness({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return material.MaterialApp(
      theme: material.ThemeData(
        useMaterial3: true,
        splashFactory: material.InkRipple.splashFactory,
      ),
      home: material.Scaffold(body: material.Center(child: child)),
    );
  }
}
