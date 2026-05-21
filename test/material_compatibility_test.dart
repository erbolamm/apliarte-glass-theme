import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';
import 'package:apliarte_glass_theme/glass_widgets.dart' as glass;
import 'package:flutter/material.dart' as material;
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('default entrypoint exposes Material Card without replacement', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
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
      const MaterialApp(
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
      const material.MaterialApp(
        home: material.Scaffold(
          body: glass.Card(child: material.Text('Glass content')),
        ),
      ),
    );

    expect(find.byType(glass.Card), findsOneWidget);
    expect(find.text('Glass content'), findsOneWidget);
  });
}
