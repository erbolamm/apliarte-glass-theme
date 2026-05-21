import 'package:flutter_test/flutter_test.dart';

// Import ONLY the glass theme package — it re-exports everything from
// package:flutter/material.dart with our glass overrides.
import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';

void main() {
  group('AppBar (glass)', () {
    testWidgets('renders title', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('Test Title')),
          body: const SizedBox.expand(),
        ),
      ));
      await tester.pumpAndSettle();
      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('renders actions', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Title'),
            actions: [
              IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            ],
          ),
          body: const SizedBox.expand(),
        ),
      ));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('is our AppBar type', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('Test')),
          body: const SizedBox.expand(),
        ),
      ));
      await tester.pumpAndSettle();
      // Verifies our AppBar type is used, not Material's
      expect(find.byType(AppBar), findsOneWidget);
    });
  });

  group('Card (glass)', () {
    testWidgets('renders child', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: const Card(child: Text('Card Content')),
        ),
      ));
      await tester.pumpAndSettle();
      expect(find.text('Card Content'), findsOneWidget);
    });

    testWidgets('is our Card type', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: const Card(child: Text('X')),
        ),
      ));
      await tester.pumpAndSettle();
      expect(find.byType(Card), findsOneWidget);
    });
  });

  group('NavigationBar (glass)', () {
    testWidgets('renders selected destination label', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: const SizedBox.expand(),
          bottomNavigationBar: NavigationBar(
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
            ],
            selectedIndex: 0,
            onDestinationSelected: (_) {},
          ),
        ),
      ));
      await tester.pumpAndSettle();
      // Material 3 default: only selected item shows label
      expect(find.text('Home'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('shows all labels with alwaysShow behavior', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: const SizedBox.expand(),
          bottomNavigationBar: NavigationBar(
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
            ],
            selectedIndex: 0,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            onDestinationSelected: (_) {},
          ),
        ),
      ));
      await tester.pumpAndSettle();
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
    });

    testWidgets('calls onDestinationSelected on tap', (tester) async {
      int? tappedIndex;
      await tester.pumpWidget(MaterialApp(
        home: _NavBarTestHost(
          onTap: (i) => tappedIndex = i,
        ),
      ));
      await tester.pumpAndSettle();

      // Tap on unselected icon (Search at index 1)
      await tester.tap(find.byIcon(Icons.search));
      expect(tappedIndex, 1);
    });
  });

  group('AlertDialog (glass)', () {
    testWidgets('renders title and content', (tester) async {
      await tester.pumpWidget(MaterialApp(
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
      ));

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Dialog Title'), findsOneWidget);
      expect(find.text('Dialog Content'), findsOneWidget);
    });

    testWidgets('renders actions', (tester) async {
      await tester.pumpWidget(MaterialApp(
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
      ));

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('Title'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });
  });

  group('BottomAppBar (glass)', () {
    testWidgets('renders child', (tester) async {
      await tester.pumpWidget(MaterialApp(
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
      ));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.menu), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });
  });

  group('FloatingActionButton (glass)', () {
    testWidgets('renders FAB with icon', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: const SizedBox.expand(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        ),
      ));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('renders extended FAB', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: const SizedBox.expand(),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Crear'),
          ),
        ),
      ));
      await tester.pumpAndSettle();
      expect(find.text('Crear'), findsOneWidget);
    });
  });

  group('BottomSheet', () {
    testWidgets('renders content via showModalBottomSheet', (tester) async {
      await tester.pumpWidget(MaterialApp(
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
      ));

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text('Sheet content'), findsOneWidget);
    });

    testWidgets('renders with drag handle', (tester) async {
      await tester.pumpWidget(MaterialApp(
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
      ));

      await tester.tap(find.text('Sheet'));
      await tester.pumpAndSettle();
      expect(find.text('Content'), findsOneWidget);
    });
  });

  group('Drawer (glass)', () {
    testWidgets('renders child inside drawer', (tester) async {
      await tester.pumpWidget(MaterialApp(
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
      ));

      // Open drawer via ScaffoldState
      final scaffoldState = tester.state<ScaffoldState>(
        find.byType(Scaffold),
      );
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      expect(find.text('Header'), findsOneWidget);
      expect(find.text('Option 1'), findsOneWidget);
    });
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
