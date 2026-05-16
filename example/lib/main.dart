import 'package:flutter/material.dart' hide AppBar, Card, NavigationBar, BottomAppBar, AlertDialog;
import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';

void main() {
  runApp(const GlassThemeShowcase());
}

class GlassThemeShowcase extends StatelessWidget {
  const GlassThemeShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ApliArte Glass Theme',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF10B981),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: const Color(0xFF10B981),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: const ShowcasePage(),
    );
  }
}

class ShowcasePage extends StatefulWidget {
  const ShowcasePage({super.key});

  @override
  State<ShowcasePage> createState() => _ShowcasePageState();
}

class _ShowcasePageState extends State<ShowcasePage> {
  int _navIndex = 0;
  bool _showCode = false;
  String? _selectedComponent;
  final _codeScaffoldKey = GlobalKey<ScaffoldState>();

  final _pages = <Widget>[
    const _HomeSection(),
    const _AppBarSection(),
    const _CardSection(),
    const _NavBarSection(),
    const _BottomAppBarSection(),
    const _DialogSection(),
  ];

  final _pageLabels = const [
    'Inicio',
    'AppBar',
    'Card',
    'NavigationBar',
    'BottomAppBar',
    'AlertDialog',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      key: _codeScaffoldKey,
      appBar: AppBar(
        title: const Text('ApliArte Glass Theme'),
        automaticallyImplyLeading: false,
        actions: [
          // Toggle code view
          IconButton(
            icon: Icon(_showCode ? Icons.visibility : Icons.code),
            tooltip: _showCode ? 'Ver diseño' : 'Ver código',
            onPressed: () => setState(() => _showCode = !_showCode),
          ),
          // Dark/light toggle
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            tooltip: 'Cambiar tema',
            onPressed: () {
              final mode = Theme.of(context).brightness == Brightness.dark
                  ? ThemeMode.light
                  : ThemeMode.dark;
              // We need to rebuild the app with new theme
              final app = MaterialApp(
                title: 'ApliArte Glass Theme',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  colorSchemeSeed: const Color(0xFF10B981),
                  useMaterial3: true,
                  brightness: Brightness.light,
                ),
                darkTheme: ThemeData(
                  colorSchemeSeed: const Color(0xFF10B981),
                  useMaterial3: true,
                  brightness: Brightness.dark,
                ),
                themeMode: mode,
                home: const ShowcasePage(),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => app),
              );
            },
          ),
        ],
      ),
      body: _showCode ? _buildCodeView() : _pages[_navIndex],
      bottomNavigationBar: NavigationBar(
        destinations: [
          for (int i = 0; i < _pageLabels.length; i++)
            NavigationDestination(
              icon: Icon(_iconForIndex(i)),
              label: _pageLabels[i],
            ),
        ],
        selectedIndex: _navIndex,
        onDestinationSelected: (i) {
          setState(() {
            _navIndex = i;
            _showCode = false;
          });
        },
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
    );
  }

  IconData _iconForIndex(int i) {
    switch (i) {
      case 0: return Icons.home_rounded;
      case 1: return Icons.vertical_align_top_rounded;
      case 2: return Icons.credit_card_rounded;
      case 3: return Icons.explore_rounded;
      case 4: return Icons.keyboard_arrow_up_rounded;
      case 5: return Icons.chat_rounded;
      default: return Icons.circle;
    }
  }

  Widget _buildCodeView() {
    final snippets = _codeSnippets;
    final label = _pageLabels[_navIndex].toLowerCase();
    final code = snippets[label] ?? snippets['inicio']!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Código: ${_pageLabels[_navIndex]}',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E2E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SelectableText(
              code,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: Color(0xFFCDD6F4),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Map<String, String> get _codeSnippets => {
    'inicio': '''
import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';

// Mismas clases que Material 3
// pero con efecto vidrio ✨

AppBar(title: const Text('Hola'));
Card(child: const Text('Contenido'));
NavigationBar(
  destinations: [...],
  selectedIndex: 0,
  onDestinationSelected: (i) {},
);
''',
    'appbar': '''
AppBar(
  title: const Text('Título'),
  actions: [
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () {},
    ),
  ],
)

// Con bottom (TabBar):
AppBar(
  title: const Text('Tabs'),
  bottom: TabBar(
    tabs: [
      Tab(text: 'Tab 1'),
      Tab(text: 'Tab 2'),
    ],
  ),
)
''',
    'card': '''
Card(
  child: Column(
    children: [
      Text('Título'),
      Text('Contenido del card'),
    ],
  ),
)

// Con padding personalizado:
Card(
  margin: EdgeInsets.all(16),
  child: Padding(
    padding: EdgeInsets.all(24),
    child: Text('Contenido'),
  ),
)
''',
    'navigationbar': '''
NavigationBar(
  destinations: [
    NavigationDestination(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.search),
      label: 'Search',
    ),
  ],
  selectedIndex: _index,
  onDestinationSelected: (i) {
    setState(() => _index = i);
  },
)

// Drag lateral incluido ✨
''',
    'bottomappbar': '''
BottomAppBar(
  child: Row(
    children: [
      IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {},
      ),
      Spacer(),
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {},
      ),
    ],
  ),
)
''',
    'alertdialog': '''
showDialog(
  context: context,
  builder: (_) => AlertDialog(
    title: Text('Título'),
    content: Text('Mensaje'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text('Cerrar'),
      ),
    ],
  ),
);
''',
  };
}

// ─── Sections ─────────────────────────────────────────────

class _HomeSection extends StatelessWidget {
  const _HomeSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 32),
          Icon(Icons.blur_on_rounded, size: 80,
               color: theme.colorScheme.primary),
          const SizedBox(height: 16),
          Text('ApliArte Glass Theme',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Drop-in replacement de Material 3 con efecto vidrio',
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center),
          const SizedBox(height: 32),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text('✨ Componentes disponibles',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _FeatureRow(Icons.vertical_align_top_rounded, 'AppBar'),
                  _FeatureRow(Icons.credit_card_rounded, 'Card'),
                  _FeatureRow(Icons.explore_rounded, 'NavigationBar'),
                  _FeatureRow(Icons.keyboard_arrow_up_rounded, 'BottomAppBar'),
                  _FeatureRow(Icons.chat_rounded, 'AlertDialog'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text('🎯 ¿Cómo empezar?',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _CodeLine("import 'package:apliarte_glass_theme/...';"),
                  _CodeLine(''),
                  _CodeLine('// Mismas clases que Material'),
                  _CodeLine('AppBar(title: ...);'),
                  _CodeLine('Card(child: ...);'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: theme.colorScheme.primary),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Usá el NavigationBar de abajo para explorar cada componente.\n'
                      'Toggle 🌙/☀️ para ver la adaptación dark/light.\n'
                      'Toggle </> para ver el código de cada ejemplo.'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String label;
  const _FeatureRow(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

class _CodeLine extends StatelessWidget {
  final String text;
  const _CodeLine(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text,
          style: const TextStyle(fontFamily: 'monospace', fontSize: 13,
              color: Color(0xFFCDD6F4)),
      ),
    );
  }
}

class _AppBarSection extends StatelessWidget {
  const _AppBarSection();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('AppBar de vidrio', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          const Text('El mismo AppBar de Material 3, pero con efecto glass.'),
          const SizedBox(height: 24),
          // Demo 1: Simple
          const Text('AppBar simple', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Card(
            child: SizedBox(
              height: 200,
              child: Center(child: Text('Contenido con AppBar glass arriba')),
            ),
          ),
          const SizedBox(height: 24),
          // Demo 2: With TabBar
          const Text('AppBar con TabBar', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const SizedBox(
            height: 280,
            child: Card(
              child: Column(
                children: [
                  Expanded(
                    child: Center(child: Text('Pestaña actual')),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardSection extends StatelessWidget {
  const _CardSection();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Card de vidrio', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          const Text('Cards con efecto frosted glass. Se adaptan a dark/light.'),
          const SizedBox(height: 24),
          const Card(
            child: Column(
              children: [
                Text('Card simple', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Este es un card de vidrio. El contenido se ve a través del glass.'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 40),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Card con icono', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('Row + icono + texto adentro del card'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Center(child: Icon(Icons.image, size: 48,
                      color: Theme.of(context).colorScheme.onPrimaryContainer)),
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Card con header', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('Un card con área superior destacada.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _NavBarSection extends StatelessWidget {
  const _NavBarSection();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('NavigationBar de vidrio', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          const Text(
            'Bottom navigation con efecto glass, indicador deslizante y drag lateral. '
            'Mismas NavigationDestination que Material 3.',
          ),
          const SizedBox(height: 24),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('✅ Mismas NavigationDestination',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(
                    'Usá exactamente los mismos widgets que en Material 3.\n'
                    'NavigationDestination con icon + label.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Text('Preview del NavigationBar',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 80,
                  child: NavigationBar(
                    destinations: const [
                      NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),
                      NavigationDestination(icon: Icon(Icons.favorite), label: 'Fav'),
                      NavigationDestination(icon: Icon(Icons.person), label: 'Perfil'),
                    ],
                    selectedIndex: 0,
                    onDestinationSelected: (_) {},
                    labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                    height: 64,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _BottomAppBarSection extends StatelessWidget {
  const _BottomAppBarSection();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('BottomAppBar de vidrio', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          const Text('Bottom app bar con efecto glass. Ideal con FAB.'),
          const SizedBox(height: 24),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Text('Preview del BottomAppBar',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 80,
                  child: BottomAppBar(
                    height: 64,
                    child: Row(
                      children: [
                        IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
                        const Spacer(),
                        IconButton(icon: const Icon(Icons.search), onPressed: () {}),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Card(
            child: ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('BottomAppBar con FAB'),
              subtitle: Text('Combiná con un FloatingActionButton para el patrón típico.'),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _DialogSection extends StatelessWidget {
  const _DialogSection();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('AlertDialog de vidrio', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          const Text('Diálogos modales con efecto glass. Misma API que Material.'),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text('Probá el diálogo glass',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Abrir diálogo glass'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Diálogo Glass'),
                          content: const Text(
                            'Este diálogo usa el efecto glass morphism.\n'
                            'El fondo se ve a través del vidrio.\n'
                            'Se adapta a dark/light automáticamente.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text('Cancelar'),
                            ),
                            FilledButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text('Aceptar'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text('Diálogo con icono',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  FilledButton.tonalIcon(
                    icon: const Icon(Icons.celebration),
                    label: const Text('Abrir con icono'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          icon: const Icon(Icons.celebration, size: 48,
                              color: Colors.amber),
                          title: const Text('¡Celebración!'),
                          content: const Text(
                            'Diálogo glass con icono decorativo arriba.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text('Cerrar'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
