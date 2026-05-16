import 'package:flutter/material.dart';
import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ApliArte Glass Theme Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF10B981),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  static const _items = [
    ApliGlasBarItem(iconData: Icons.home_rounded, label: 'Home'),
    ApliGlasBarItem(iconData: Icons.search_rounded, label: 'Search'),
    ApliGlasBarItem(
      iconData: Icons.bookmark_rounded,
      label: 'Collections',
    ),
    ApliGlasBarItem(iconData: Icons.public_rounded, label: 'Community'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: ApliGlasAppBar(
        title: const Text('ApliArte Glass'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _PageContent(title: 'Home', color: Colors.teal.shade50),
          _PageContent(title: 'Search', color: Colors.blue.shade50),
          _PageContent(title: 'Collections', color: Colors.purple.shade50),
          _PageContent(title: 'Community', color: Colors.orange.shade50),
        ],
      ),
      bottomNavigationBar: ApliGlasBar(
        items: _items,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}

class _PageContent extends StatelessWidget {
  final String title;
  final Color color;

  const _PageContent({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            const ApliGlasCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Glass Card',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'This card uses the same glass morphism effect.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
