import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';
import 'package:apliarte_glass_theme/glass_widgets.dart' as glass;

/// Integration-style tests that verify multiple glass widgets
/// work together in a single app.
void main() {
  group('Full app integration', () {
    testWidgets('AppBar + Card + FAB render together', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: _testTheme(),
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Integration Test'),
              actions: [
                IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
              ],
            ),
            body: ListView(
              children: const [
                Card(child: Text('Card 1')),
                Card(child: Text('Card 2')),
                Card(child: Text('Card 3')),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // All components rendered
      expect(find.text('Integration Test'), findsOneWidget);
      expect(find.text('Card 1'), findsOneWidget);
      expect(find.text('Card 2'), findsOneWidget);
      expect(find.text('Card 3'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('NavigationBar + AlertDialog interaction', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: _testTheme(),
          home: Scaffold(
            body: const Center(child: Text('Home Screen')),
            bottomNavigationBar: NavigationBar(
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(icon: Icon(Icons.info), label: 'Info'),
              ],
              selectedIndex: 0,
              onDestinationSelected: (_) {},
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Home Screen'), findsOneWidget);
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.info), findsOneWidget);
    });

    testWidgets('BottomAppBar + FAB (extended) layout', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: _testTheme(),
          home: Scaffold(
            appBar: AppBar(title: const Text('Layout Test')),
            body: const Center(child: Text('Content area')),
            bottomNavigationBar: BottomAppBar(
              child: Row(
                children: [
                  IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
                  const Spacer(),
                  IconButton(icon: const Icon(Icons.search), onPressed: () {}),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Layout Test'), findsOneWidget);
      expect(find.text('Content area'), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('AlertDialog with actions works inside Scaffold', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: _testTheme(),
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Confirm'),
                      content: const Text('Are you sure?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Show Dialog'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Confirm'), findsOneWidget);
      expect(find.text('Are you sure?'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);

      // Tap Cancel to close
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(find.text('Confirm'), findsNothing);
    });

    testWidgets('Card inside ScrollView maintains glass effect', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: _testTheme(),
          home: Scaffold(
            body: ListView.builder(
              itemCount: 20,
              itemBuilder: (ctx, i) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Item $i'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // First items visible
      expect(find.text('Item 0'), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);

      // Scroll down
      await tester.drag(find.byType(ListView), const Offset(0, -500));
      await tester.pumpAndSettle();

      // New items visible, old ones gone
      expect(find.text('Item 0'), findsNothing);
    });

    testWidgets(
      'explicit glass wrappers keep shared press feedback inside a Scaffold',
      (tester) async {
        GlasConfig.buttonPressFeedbackEnabled = true;
        GlasConfig.buttonPressScale = 0.94;
        final focusNode = FocusNode(debugLabel: 'integration-fab-focus');
        addTearDown(() {
          GlasConfig.buttonPressFeedbackEnabled = false;
          GlasConfig.buttonPressScale = 0.97;
          focusNode.dispose();
        });

        var bodyPressed = 0;
        var fabPressed = 0;

        await tester.pumpWidget(
          MaterialApp(
            theme: _testTheme(),
            home: Scaffold(
              appBar: glass.AppBar(
                title: const Text('Press Feedback Integration'),
              ),
              body: Center(
                child: glass.ElevatedButton(
                  onPressed: () => bodyPressed += 1,
                  child: const Text('Body CTA'),
                ),
              ),
              floatingActionButton: glass.FloatingActionButton(
                tooltip: 'Add item',
                focusNode: focusNode,
                autofocus: true,
                onPressed: () => fabPressed += 1,
                child: const Icon(Icons.add),
              ),
            ),
          ),
        );

        expect(find.byType(AnimatedScale), findsNWidgets(2));

        final fabScaleFinder = find.descendant(
          of: find.byType(glass.FloatingActionButton),
          matching: find.byType(AnimatedScale),
        );
        final buttonScaleFinder = find.descendant(
          of: find.byType(glass.ElevatedButton),
          matching: find.byType(AnimatedScale),
        );

        expect(tester.widget<AnimatedScale>(fabScaleFinder).scale, 1.0);
        expect(tester.widget<AnimatedScale>(buttonScaleFinder).scale, 1.0);
        expect(focusNode.hasFocus, isTrue);

        await tester.sendKeyDownEvent(LogicalKeyboardKey.space);
        await tester.pump();

        expect(
          tester.widget<AnimatedScale>(fabScaleFinder).scale,
          closeTo(GlasConfig.buttonPressScaleValue(), 0.0001),
        );
        expect(tester.widget<AnimatedScale>(buttonScaleFinder).scale, 1.0);

        await tester.sendKeyUpEvent(LogicalKeyboardKey.space);
        await tester.pumpAndSettle();

        expect(tester.widget<AnimatedScale>(fabScaleFinder).scale, 1.0);
        expect(find.byTooltip('Add item'), findsOneWidget);
        expect(bodyPressed, 0);
        expect(fabPressed, 1);
      },
    );
  });
}

ThemeData _testTheme({Brightness brightness = Brightness.light}) {
  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    splashFactory: InkRipple.splashFactory,
  );
}
