import 'package:apliarte_glass_theme/glass_widgets.dart' as glass;
import 'package:flutter/material.dart' as material;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('glass.AppBar Material compatibility', () {
    testWidgets('uses backgroundColor as glass tint fallback', (tester) async {
      const background = material.Color(0x66112233);

      await tester.pumpWidget(
        const material.MaterialApp(
          home: material.Scaffold(
            appBar: glass.AppBar(
              title: material.Text('Title'),
              backgroundColor: background,
            ),
          ),
        ),
      );

      expect(_boxWithColor(background), findsOneWidget);
    });

    testWidgets('glassTint takes precedence over backgroundColor', (
      tester,
    ) async {
      const background = material.Color(0x66112233);
      const tint = material.Color(0x66445566);

      await tester.pumpWidget(
        const material.MaterialApp(
          home: material.Scaffold(
            appBar: glass.AppBar(
              title: material.Text('Title'),
              backgroundColor: background,
              glassTint: tint,
            ),
          ),
        ),
      );

      expect(_boxWithColor(tint), findsOneWidget);
      expect(_boxWithColor(background), findsNothing);
    });

    testWidgets('centerTitle centers the title', (tester) async {
      await tester.pumpWidget(
        const material.MaterialApp(
          home: material.Scaffold(
            appBar: glass.AppBar(
              centerTitle: true,
              leading: material.Icon(material.Icons.menu),
              title: material.Text('Centered'),
              actions: [material.Icon(material.Icons.search)],
            ),
          ),
        ),
      );

      final titleCenter = tester.getCenter(find.text('Centered')).dx;
      final screenCenter =
          tester.view.physicalSize.width / tester.view.devicePixelRatio / 2;
      expect(titleCenter, moreOrLessEquals(screenCenter, epsilon: 1));
    });

    testWidgets('titleSpacing affects title position', (tester) async {
      Future<double> titleLeftFor(double titleSpacing) async {
        await tester.pumpWidget(
          material.MaterialApp(
            home: material.Scaffold(
              appBar: glass.AppBar(
                leading: const material.Icon(material.Icons.menu),
                titleSpacing: titleSpacing,
                title: const material.Text('Spaced'),
              ),
            ),
          ),
        );
        return tester.getTopLeft(find.text('Spaced')).dx;
      }

      final leftWithZeroSpacing = await titleLeftFor(0);
      final leftWithWideSpacing = await titleLeftFor(40);

      expect(leftWithWideSpacing - leftWithZeroSpacing, moreOrLessEquals(40));
    });

    testWidgets('leadingWidth affects title position', (tester) async {
      Future<double> titleLeftFor(double leadingWidth) async {
        await tester.pumpWidget(
          material.MaterialApp(
            home: material.Scaffold(
              appBar: glass.AppBar(
                leading: const material.Icon(material.Icons.menu),
                leadingWidth: leadingWidth,
                titleSpacing: 0,
                title: const material.Text('Width'),
              ),
            ),
          ),
        );
        return tester.getTopLeft(find.text('Width')).dx;
      }

      final leftWithNarrowLeading = await titleLeftFor(32);
      final leftWithWideLeading = await titleLeftFor(96);

      expect(leftWithWideLeading - leftWithNarrowLeading, moreOrLessEquals(64));
    });

    testWidgets('uses Material default leadingWidth', (tester) async {
      await tester.pumpWidget(
        const material.MaterialApp(
          home: material.Scaffold(
            appBar: glass.AppBar(
              leading: material.Icon(material.Icons.menu),
              titleSpacing: 0,
              title: material.Text('Default width'),
            ),
          ),
        ),
      );

      expect(
        tester.getTopLeft(find.text('Default width')).dx,
        moreOrLessEquals(material.kToolbarHeight),
      );
    });

    testWidgets('uses AppBarTheme leadingWidth and titleSpacing', (
      tester,
    ) async {
      await tester.pumpWidget(
        material.MaterialApp(
          theme: material.ThemeData(
            appBarTheme: const material.AppBarTheme(
              leadingWidth: 88,
              titleSpacing: 24,
            ),
          ),
          home: const material.Scaffold(
            appBar: glass.AppBar(
              leading: material.Icon(material.Icons.menu),
              title: material.Text('Themed spacing'),
            ),
          ),
        ),
      );

      expect(
        tester.getTopLeft(find.text('Themed spacing')).dx,
        moreOrLessEquals(112),
      );
    });

    testWidgets('iconTheme and actionsIconTheme are resolved separately', (
      tester,
    ) async {
      await tester.pumpWidget(
        const material.MaterialApp(
          home: material.Scaffold(
            appBar: glass.AppBar(
              leading: material.Icon(material.Icons.menu),
              title: material.Text('Icons'),
              iconTheme: material.IconThemeData(
                color: material.Colors.red,
                size: 31,
              ),
              actionsIconTheme: material.IconThemeData(
                color: material.Colors.blue,
                size: 29,
              ),
              actions: [material.Icon(material.Icons.search)],
            ),
          ),
        ),
      );

      final leadingContext = tester.element(find.byIcon(material.Icons.menu));
      final actionContext = tester.element(find.byIcon(material.Icons.search));

      expect(material.IconTheme.of(leadingContext).color, material.Colors.red);
      expect(material.IconTheme.of(leadingContext).size, 31);
      expect(material.IconTheme.of(actionContext).color, material.Colors.blue);
      expect(material.IconTheme.of(actionContext).size, 29);
    });
  });
}

Finder _boxWithColor(material.Color color) {
  return find.byWidgetPredicate((widget) {
    final decoration = widget is material.Container ? widget.decoration : null;
    return decoration is material.BoxDecoration && decoration.color == color;
  });
}
