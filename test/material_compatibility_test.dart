import 'dart:io';

import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';
import 'package:apliarte_glass_theme/glass_widgets.dart' as glass;
import 'package:flutter/material.dart' as material;
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('default entrypoint exposes Material Card without replacement', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: _testTheme(),
        home: Scaffold(
          body: Card(
            child: SizedBox(width: 100, height: 50, child: Text('content')),
          ),
        ),
      ),
    );

    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(material.Card), findsOneWidget);
    expect(find.byType(glass.Card), findsNothing);
  });

  testWidgets('default entrypoint keeps Material primitives available', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: _testTheme(),
        home: Scaffold(
          body: Center(
            child: Row(
              children: [Icon(Icons.check), Text('Material primitives')],
            ),
          ),
        ),
      ),
    );

    expect(find.byType(material.Scaffold), findsOneWidget);
    expect(find.byType(material.Center), findsWidgets);
    expect(find.byIcon(Icons.check), findsOneWidget);
    expect(find.text('Material primitives'), findsOneWidget);
  });

  testWidgets('default entrypoint uses Material AlertDialog', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: _testTheme(),
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (_) => const AlertDialog(
                    title: Text('Title'),
                    content: Text('Content'),
                  ),
                );
              },
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.text('Title'), findsOneWidget);
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.byType(material.AlertDialog), findsOneWidget);
    expect(find.byType(glass.AlertDialog), findsNothing);
    expect(find.byType(material.Dialog), findsOneWidget);
  });

  testWidgets('glass widgets remain explicit and prefix-friendly', (
    tester,
  ) async {
    await tester.pumpWidget(
      material.MaterialApp(
        theme: _testTheme(),
        home: material.Scaffold(
          body: glass.Card(child: material.Text('Glass content')),
        ),
      ),
    );

    expect(find.byType(glass.Card), findsOneWidget);
    expect(find.text('Glass content'), findsOneWidget);
  });

  testWidgets(
    'default entrypoint keeps Material FAB free of glass press feedback wrappers',
    (tester) async {
      GlasConfig.buttonPressFeedbackEnabled = true;
      addTearDown(() => GlasConfig.buttonPressFeedbackEnabled = false);

      await tester.pumpWidget(
        MaterialApp(
          theme: _testTheme(),
          home: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ),
        ),
      );

      expect(find.byType(material.FloatingActionButton), findsOneWidget);
      expect(find.byType(glass.FloatingActionButton), findsNothing);
      expect(find.byType(AnimatedScale), findsNothing);
    },
  );

  testWidgets(
    'glass FAB remains opt-in through glass_widgets and follows press feedback config',
    (tester) async {
      GlasConfig.buttonPressFeedbackEnabled = true;
      GlasConfig.buttonPressScale = 0.94;
      addTearDown(() {
        GlasConfig.buttonPressFeedbackEnabled = false;
        GlasConfig.buttonPressScale = 0.97;
      });

      await tester.pumpWidget(
        material.MaterialApp(
          theme: _testTheme(),
          home: material.Scaffold(
            floatingActionButton: glass.FloatingActionButton(
              onPressed: () {},
              child: const material.Icon(material.Icons.add),
            ),
          ),
        ),
      );

      expect(find.byType(glass.FloatingActionButton), findsOneWidget);
      expect(find.byType(material.FloatingActionButton), findsNothing);
      expect(find.byType(AnimatedScale), findsOneWidget);
    },
  );

  test('public entrypoints do not leak a Pressable API surface', () {
    final defaultEntrypoint = File(
      'lib/apliarte_glass_theme.dart',
    ).readAsStringSync();
    final glassEntrypoint = File('lib/glass_widgets.dart').readAsStringSync();

    expect(defaultEntrypoint, isNot(contains('Pressable')));
    expect(glassEntrypoint, isNot(contains('Pressable')));
  });
}

material.ThemeData _testTheme({
  material.Brightness brightness = material.Brightness.light,
}) {
  return material.ThemeData(
    useMaterial3: true,
    brightness: brightness,
    splashFactory: material.InkRipple.splashFactory,
  );
}
