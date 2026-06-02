import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

// Import ONLY the glass theme package — it re-exports everything from
// package:flutter/material.dart with our glass overrides.
import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';
import 'package:apliarte_glass_theme/glass_widgets.dart' as glass;

void main() {
  group('AppBar (glass)', () {
    testWidgets('renders title', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: _testTheme(),
          home: Scaffold(
            appBar: AppBar(title: const Text('Test Title')),
            body: const SizedBox.expand(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('renders actions', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: _testTheme(),
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Title'),
              actions: [
                IconButton(icon: const Icon(Icons.search), onPressed: () {}),
              ],
            ),
            body: const SizedBox.expand(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('is our AppBar type', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: _testTheme(),
          home: Scaffold(
            appBar: AppBar(title: const Text('Test')),
            body: const SizedBox.expand(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      // Verifies our AppBar type is used, not Material's
      expect(find.byType(AppBar), findsOneWidget);
    });
  });

  group('Card (glass)', () {
    testWidgets('renders child', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: _testTheme(),
          home: Scaffold(body: const Card(child: Text('Card Content'))),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Card Content'), findsOneWidget);
    });

    testWidgets('is our Card type', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: _testTheme(),
          home: Scaffold(body: const Card(child: Text('X'))),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(Card), findsOneWidget);
    });
  });

  group('NavigationBar (glass)', () {
    testWidgets('renders selected destination label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: _testTheme(),
          home: Scaffold(
            body: const SizedBox.expand(),
            bottomNavigationBar: NavigationBar(
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
              ],
              selectedIndex: 0,
              onDestinationSelected: (_) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      // Material 3 default: only selected item shows label
      expect(find.text('Home'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('shows all labels with alwaysShow behavior', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: _testTheme(),
          home: Scaffold(
            body: const SizedBox.expand(),
            bottomNavigationBar: NavigationBar(
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
              ],
              selectedIndex: 0,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              onDestinationSelected: (_) {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
    });

    testWidgets('calls onDestinationSelected on tap', (tester) async {
      int? tappedIndex;
      await tester.pumpWidget(
        MaterialApp(
          theme: _testTheme(),
          home: _NavBarTestHost(onTap: (i) => tappedIndex = i),
        ),
      );
      await tester.pumpAndSettle();

      // Tap on unselected icon (Search at index 1)
      await tester.tap(find.byIcon(Icons.search));
      expect(tappedIndex, 1);
    });
  });

  group('AlertDialog (glass)', () {
    testWidgets('renders title and content', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: _testTheme(),
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => const AlertDialog(
                      title: Text('Dialog Title'),
                      content: Text('Dialog Content'),
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

      expect(find.text('Dialog Title'), findsOneWidget);
      expect(find.text('Dialog Content'), findsOneWidget);
    });

    testWidgets('renders actions', (tester) async {
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
                      title: const Text('Title'),
                      content: const Text('Content'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
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
      expect(find.text('OK'), findsOneWidget);
    });
  });

  group('BottomAppBar (glass)', () {
    testWidgets('renders child', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: _testTheme(),
          home: Scaffold(
            appBar: AppBar(title: const Text('Test')),
            body: const SizedBox.expand(),
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
      expect(find.byIcon(Icons.menu), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });
  });

  group('FloatingActionButton (glass)', () {
    testWidgets('renders FAB with icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: _testTheme(),
          home: Scaffold(
            body: const SizedBox.expand(),
            floatingActionButton: glass.FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('renders extended FAB', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: _testTheme(),
          home: Scaffold(
            body: const SizedBox.expand(),
            floatingActionButton: glass.FloatingActionButton.extended(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Crear'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Crear'), findsOneWidget);
    });

    testWidgets('scales regular FAB only while pressed by pointer', (
      tester,
    ) async {
      GlasConfig.buttonPressFeedbackEnabled = true;
      GlasConfig.buttonPressScale = 0.94;
      addTearDown(_resetPressFeedbackConfig);

      var pressedCount = 0;

      await tester.pumpWidget(
        _FabTestHarness(
          floatingActionButton: glass.FloatingActionButton(
            onPressed: () => pressedCount += 1,
            child: const Icon(Icons.add),
          ),
        ),
      );

      expect(
        _animatedScaleIn(tester, find.byType(glass.FloatingActionButton)).scale,
        1.0,
      );

      final gesture = await tester.startGesture(
        tester.getCenter(find.byIcon(Icons.add)),
      );
      await tester.pump();

      expect(
        _animatedScaleIn(tester, find.byType(glass.FloatingActionButton)).scale,
        closeTo(GlasConfig.buttonPressScaleValue(), 0.0001),
      );

      await gesture.up();
      await tester.pumpAndSettle();

      expect(
        _animatedScaleIn(tester, find.byType(glass.FloatingActionButton)).scale,
        1.0,
      );
      expect(pressedCount, 1);
    });

    testWidgets(
      'scales extended FAB on keyboard activation without stealing focus flow',
      (tester) async {
        GlasConfig.buttonPressFeedbackEnabled = true;
        GlasConfig.buttonPressScale = 0.94;
        addTearDown(_resetPressFeedbackConfig);

        final focusNode = FocusNode(debugLabel: 'fab-focus');
        addTearDown(focusNode.dispose);

        var pressedCount = 0;

        await tester.pumpWidget(
          _FabTestHarness(
            floatingActionButton: glass.FloatingActionButton.extended(
              onPressed: () => pressedCount += 1,
              focusNode: focusNode,
              autofocus: true,
              tooltip: 'Crear elemento',
              icon: const Icon(Icons.add),
              label: const Text('Crear'),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(focusNode.hasFocus, isTrue);
        expect(
          _animatedScaleIn(
            tester,
            find.byType(glass.FloatingActionButton),
          ).scale,
          1.0,
        );

        await tester.sendKeyDownEvent(LogicalKeyboardKey.space);
        await tester.pump();

        expect(
          _animatedScaleIn(
            tester,
            find.byType(glass.FloatingActionButton),
          ).scale,
          closeTo(GlasConfig.buttonPressScaleValue(), 0.0001),
        );

        await tester.sendKeyUpEvent(LogicalKeyboardKey.space);
        await tester.pumpAndSettle();

        expect(
          _animatedScaleIn(
            tester,
            find.byType(glass.FloatingActionButton),
          ).scale,
          1.0,
        );
        expect(pressedCount, 1);
      },
    );

    testWidgets('disabled regular and extended FAB stay idle', (tester) async {
      GlasConfig.buttonPressFeedbackEnabled = true;
      GlasConfig.buttonPressScale = 0.94;
      addTearDown(_resetPressFeedbackConfig);

      await tester.pumpWidget(
        _FabTestHarness(
          body: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Body content')],
          ),
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              glass.FloatingActionButton(
                heroTag: 'regular-disabled',
                onPressed: null,
                tooltip: 'Disabled add',
                child: Icon(Icons.block_outlined),
              ),
              SizedBox(height: 16),
              glass.FloatingActionButton.extended(
                heroTag: 'extended-disabled',
                onPressed: null,
                icon: Icon(Icons.block),
                label: Text('Deshabilitado'),
              ),
            ],
          ),
        ),
      );

      expect(find.byType(AnimatedScale), findsNWidgets(2));
      expect(_animatedScaleByIcon(tester, Icons.block_outlined).scale, 1.0);
      expect(_animatedScaleByText(tester, 'Deshabilitado').scale, 1.0);

      final regularGesture = await tester.startGesture(
        tester.getCenter(find.byTooltip('Disabled add')),
      );
      await tester.pump();
      expect(_animatedScaleByIcon(tester, Icons.block_outlined).scale, 1.0);
      await regularGesture.up();
      await tester.pumpAndSettle();

      final extendedGesture = await tester.startGesture(
        tester.getCenter(find.text('Deshabilitado')),
      );
      await tester.pump();
      expect(_animatedScaleByText(tester, 'Deshabilitado').scale, 1.0);
      await extendedGesture.up();
      await tester.pumpAndSettle();

      expect(_animatedScaleByIcon(tester, Icons.block_outlined).scale, 1.0);
      expect(_animatedScaleByText(tester, 'Deshabilitado').scale, 1.0);
    });
  });

  group('BottomSheet', () {
    testWidgets('renders content via showModalBottomSheet', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: _testTheme(),
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Sheet content'),
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
      expect(find.text('Sheet content'), findsOneWidget);
    });

    testWidgets('renders with drag handle', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: _testTheme(),
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    builder: (_) => const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Content'),
                    ),
                  );
                },
                child: const Text('Sheet'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Sheet'));
      await tester.pumpAndSettle();
      expect(find.text('Content'), findsOneWidget);
    });
  });

  group('Drawer (glass)', () {
    testWidgets('renders child inside drawer', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: _testTheme(),
          home: Scaffold(
            drawer: Drawer(
              child: ListView(
                children: const [
                  DrawerHeader(child: Text('Header')),
                  ListTile(title: Text('Option 1')),
                ],
              ),
            ),
            body: const SizedBox.expand(),
          ),
        ),
      );

      // Open drawer via ScaffoldState
      final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold));
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      expect(find.text('Header'), findsOneWidget);
      expect(find.text('Option 1'), findsOneWidget);
    });
  });

  group('Standard button press feedback', () {
    for (final testCase in _standardButtonCases) {
      testWidgets('${testCase.name} scales only while pressed by pointer', (
        tester,
      ) async {
        GlasConfig.buttonPressFeedbackEnabled = true;
        GlasConfig.buttonPressScale = 0.94;
        addTearDown(_resetPressFeedbackConfig);

        var pressedCount = 0;

        await tester.pumpWidget(
          _ButtonTestHarness(
            child: testCase.build(onPressed: () => pressedCount += 1),
          ),
        );

        expect(_animatedScale(tester).scale, 1.0);

        final gesture = await tester.startGesture(
          tester.getCenter(testCase.pressFinder),
        );
        await tester.pump();

        expect(
          _animatedScale(tester).scale,
          closeTo(GlasConfig.buttonPressScaleValue(), 0.0001),
        );

        await gesture.up();
        await tester.pumpAndSettle();

        expect(_animatedScale(tester).scale, 1.0);
        expect(pressedCount, 1);
      });

      testWidgets(
        '${testCase.name} scales on keyboard activation without stealing Material focus flow',
        (tester) async {
          GlasConfig.buttonPressFeedbackEnabled = true;
          GlasConfig.buttonPressScale = 0.94;
          addTearDown(_resetPressFeedbackConfig);

          final focusNode = FocusNode(debugLabel: '${testCase.name}-focus');
          addTearDown(focusNode.dispose);

          var pressedCount = 0;

          await tester.pumpWidget(
            _ButtonTestHarness(
              child: testCase.build(
                onPressed: () => pressedCount += 1,
                focusNode: focusNode,
                autofocus: true,
              ),
            ),
          );
          await tester.pumpAndSettle();

          expect(focusNode.hasFocus, isTrue);
          expect(_animatedScale(tester).scale, 1.0);

          await tester.sendKeyDownEvent(LogicalKeyboardKey.space);
          await tester.pump();

          expect(
            _animatedScale(tester).scale,
            closeTo(GlasConfig.buttonPressScaleValue(), 0.0001),
          );

          await tester.sendKeyUpEvent(LogicalKeyboardKey.space);
          await tester.pumpAndSettle();

          expect(_animatedScale(tester).scale, 1.0);
          expect(pressedCount, 1);
        },
      );

      testWidgets(
        '${testCase.name} stays idle when disabled and keeps disabled button semantics',
        (tester) async {
          GlasConfig.buttonPressFeedbackEnabled = true;
          GlasConfig.buttonPressScale = 0.94;
          addTearDown(_resetPressFeedbackConfig);

          final semantics = tester.ensureSemantics();

          try {
            await tester.pumpWidget(
              _ButtonTestHarness(child: testCase.build(onPressed: null)),
            );

            expect(_animatedScale(tester).scale, 1.0);

            final gesture = await tester.startGesture(
              tester.getCenter(testCase.pressFinder),
            );
            await tester.pump();

            expect(_animatedScale(tester).scale, 1.0);

            await gesture.up();
            await tester.pumpAndSettle();

            expect(
              tester.getSemantics(testCase.semanticsFinder),
              testCase.semanticTooltip == null
                  ? matchesSemantics(
                      isButton: true,
                      hasEnabledState: true,
                      isEnabled: false,
                      label: testCase.semanticLabel,
                    )
                  : matchesSemantics(
                      isButton: true,
                      hasEnabledState: true,
                      isEnabled: false,
                      tooltip: testCase.semanticTooltip,
                    ),
            );
          } finally {
            semantics.dispose();
          }
        },
      );

      testWidgets('${testCase.name} reuses an external statesController', (
        tester,
      ) async {
        GlasConfig.buttonPressFeedbackEnabled = true;
        GlasConfig.buttonPressScale = 0.94;
        addTearDown(_resetPressFeedbackConfig);

        final controller = WidgetStatesController();

        await tester.pumpWidget(
          _ButtonTestHarness(
            child: testCase.build(
              onPressed: () {},
              statesController: controller,
            ),
          ),
        );

        expect(_animatedScale(tester).scale, 1.0);

        controller.update(WidgetState.pressed, true);
        await tester.pump();

        expect(
          _animatedScale(tester).scale,
          closeTo(GlasConfig.buttonPressScaleValue(), 0.0001),
        );

        controller.update(WidgetState.pressed, false);
        await tester.pumpAndSettle();

        expect(_animatedScale(tester).scale, 1.0);
      });
    }
  });
}

// Helper stateful wrapper for NavigationBar tap tests
class _NavBarTestHost extends StatefulWidget {
  final void Function(int) onTap;
  const _NavBarTestHost({required this.onTap});

  @override
  State<_NavBarTestHost> createState() => _NavBarTestHostState();
}

class _NavBarTestHostState extends State<_NavBarTestHost> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SizedBox.expand(),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedIndex: _index,
        onDestinationSelected: (i) {
          setState(() => _index = i);
          widget.onTap(i);
        },
      ),
    );
  }
}

class _ButtonTestHarness extends StatelessWidget {
  const _ButtonTestHarness({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _testTheme(),
      home: Scaffold(body: Center(child: child)),
    );
  }
}

class _FabTestHarness extends StatelessWidget {
  const _FabTestHarness({
    required this.floatingActionButton,
    this.body = const SizedBox.expand(),
  });

  final Widget floatingActionButton;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _testTheme(),
      home: Scaffold(body: body, floatingActionButton: floatingActionButton),
    );
  }
}

ThemeData _testTheme({Brightness brightness = Brightness.light}) {
  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    splashFactory: InkRipple.splashFactory,
  );
}

AnimatedScale _animatedScale(WidgetTester tester) {
  return tester.widget<AnimatedScale>(find.byType(AnimatedScale));
}

AnimatedScale _animatedScaleIn(WidgetTester tester, Finder ancestor) {
  return tester.widget<AnimatedScale>(
    find.descendant(of: ancestor, matching: find.byType(AnimatedScale)),
  );
}

AnimatedScale _animatedScaleByIcon(WidgetTester tester, IconData icon) {
  return tester.widget<AnimatedScale>(
    find.ancestor(of: find.byIcon(icon), matching: find.byType(AnimatedScale)),
  );
}

AnimatedScale _animatedScaleByText(WidgetTester tester, String label) {
  return tester.widget<AnimatedScale>(
    find.ancestor(of: find.text(label), matching: find.byType(AnimatedScale)),
  );
}

void _resetPressFeedbackConfig() {
  GlasConfig.buttonPressFeedbackEnabled = false;
  GlasConfig.buttonPressScale = 0.97;
}

typedef _BuildButton =
    Widget Function({
      required VoidCallback? onPressed,
      FocusNode? focusNode,
      bool autofocus,
      WidgetStatesController? statesController,
    });

class _StandardButtonCase {
  const _StandardButtonCase({
    required this.name,
    required this.pressFinder,
    required this.semanticsFinder,
    required this.build,
    this.semanticLabel,
    this.semanticTooltip,
  });

  final String name;
  final Finder pressFinder;
  final Finder semanticsFinder;
  final String? semanticLabel;
  final String? semanticTooltip;
  final _BuildButton build;
}

const _elevatedLabel = 'Feedback elevated';
const _textLabel = 'Feedback text';
const _outlinedLabel = 'Feedback outlined';
const _iconTooltip = 'Feedback icon';

final List<_StandardButtonCase> _standardButtonCases = [
  _StandardButtonCase(
    name: 'ElevatedButton',
    pressFinder: find.text(_elevatedLabel),
    semanticsFinder: find.text(_elevatedLabel),
    semanticLabel: _elevatedLabel,
    build:
        ({
          required VoidCallback? onPressed,
          FocusNode? focusNode,
          bool autofocus = false,
          WidgetStatesController? statesController,
        }) {
          return glass.ElevatedButton(
            onPressed: onPressed,
            focusNode: focusNode,
            autofocus: autofocus,
            statesController: statesController,
            child: const Text(_elevatedLabel),
          );
        },
  ),
  _StandardButtonCase(
    name: 'TextButton',
    pressFinder: find.text(_textLabel),
    semanticsFinder: find.text(_textLabel),
    semanticLabel: _textLabel,
    build:
        ({
          required VoidCallback? onPressed,
          FocusNode? focusNode,
          bool autofocus = false,
          WidgetStatesController? statesController,
        }) {
          return glass.TextButton(
            onPressed: onPressed,
            focusNode: focusNode,
            autofocus: autofocus,
            statesController: statesController,
            child: const Text(_textLabel),
          );
        },
  ),
  _StandardButtonCase(
    name: 'OutlinedButton',
    pressFinder: find.text(_outlinedLabel),
    semanticsFinder: find.text(_outlinedLabel),
    semanticLabel: _outlinedLabel,
    build:
        ({
          required VoidCallback? onPressed,
          FocusNode? focusNode,
          bool autofocus = false,
          WidgetStatesController? statesController,
        }) {
          return glass.OutlinedButton(
            onPressed: onPressed,
            focusNode: focusNode,
            autofocus: autofocus,
            statesController: statesController,
            child: const Text(_outlinedLabel),
          );
        },
  ),
  _StandardButtonCase(
    name: 'IconButton',
    pressFinder: find.byType(IconButton),
    semanticsFinder: find.byTooltip(_iconTooltip),
    semanticTooltip: _iconTooltip,
    build:
        ({
          required VoidCallback? onPressed,
          FocusNode? focusNode,
          bool autofocus = false,
          WidgetStatesController? statesController,
        }) {
          return glass.IconButton(
            onPressed: onPressed,
            focusNode: focusNode,
            autofocus: autofocus,
            tooltip: _iconTooltip,
            statesController: statesController,
            icon: const Icon(Icons.touch_app),
          );
        },
  ),
];
