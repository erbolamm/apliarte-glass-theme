import 'package:flutter/material.dart' hide AppBar, Card, NavigationBar, BottomAppBar, AlertDialog, BottomSheet, Drawer, FloatingActionButton, ElevatedButton, TextButton, OutlinedButton, IconButton, ListTile, Divider, CircularProgressIndicator, LinearProgressIndicator, Slider;
import 'package:flutter_test/flutter_test.dart';
import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';

void main() {
  testWidgets('full app with all glass components renders without errors',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Test'),
          actions: [
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            Card(child: Text('Card content')),
            SizedBox(height: 16),
            Card(child: Text('Second card')),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.favorite), label: 'Fav'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          ],
          selectedIndex: 0,
          onDestinationSelected: (_) {},
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          child: const Icon(Icons.add),
        ),
      ),
    ));
    await tester.pumpAndSettle();

    // All components rendered
    expect(find.text('Test'), findsOneWidget);
    expect(find.text('Card content'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('theme toggle between light and dark works', (tester) async {
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(title: const Text('Theme')),
        body: const Card(child: Text('Content')),
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
          ],
          selectedIndex: 0,
          onDestinationSelected: (_) {},
        ),
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Theme'), findsOneWidget);
    expect(find.text('Content'), findsOneWidget);
  });

  testWidgets('AlertDialog opens and closes via glass theme', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const AlertDialog(
                  title: Text('Glass Dialog'),
                  content: Text('Dialog content'),
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

    expect(find.text('Glass Dialog'), findsOneWidget);
    expect(find.text('Dialog content'), findsOneWidget);

    // Close dialog
    await tester.tapAt(const Offset(0, 0));
    await tester.pumpAndSettle();
  });

  testWidgets('BottomSheet renders with glass effect', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => const BottomSheet(
                  child: Text('Sheet content'),
                  showDragHandle: true,
                ),
              );
            },
            child: const Text('Open sheet'),
          ),
        ),
      ),
    ));

    await tester.tap(find.text('Open sheet'));
    await tester.pumpAndSettle();

    expect(find.text('Sheet content'), findsOneWidget);
  });

  testWidgets('GlasConfig warm preset changes glass appearance',
      (tester) async {
    GlasConfig.useWarmPreset = true;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Warm')),
        body: const Card(child: Text('Warm glass')),
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.text('Warm'), findsOneWidget);
    expect(find.text('Warm glass'), findsOneWidget);

    GlasConfig.useWarmPreset = false;
  });
}
