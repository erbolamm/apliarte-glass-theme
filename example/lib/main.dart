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
      theme: _buildTheme(Brightness.dark),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: ThemeMode.dark,
      home: const ShowcasePage(),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorSchemeSeed: const Color(0xFF10B981),
      scaffoldBackgroundColor: const Color(0xFF0B0B1A),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}

class ShowcasePage extends StatefulWidget {
  const ShowcasePage({super.key});

  @override
  State<ShowcasePage> createState() => _ShowcasePageState();
}

class _ShowcasePageState extends State<ShowcasePage> {
  int _selectedSection = 0;
  final _sections = <String>['Inicio', 'AppBar', 'Card', 'NavBar', 'Dialogs', 'Todo junto'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _buildBody(),
      bottomNavigationBar: NavigationBar(
        destinations: [
          for (int i = 0; i < _sections.length; i++)
            NavigationDestination(icon: Icon(_iconFor(i)), label: _sections[i]),
        ],
        selectedIndex: _selectedSection,
        onDestinationSelected: (i) => setState(() => _selectedSection = i),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
    );
  }

  IconData _iconFor(int i) {
    const icons = [
      Icons.home_rounded,
      Icons.vertical_align_top_rounded,
      Icons.credit_card_rounded,
      Icons.explore_rounded,
      Icons.chat_rounded,
      Icons.widgets_rounded,
    ];
    return icons[i % icons.length];
  }

  Widget _buildBody() {
    switch (_selectedSection) {
      case 0: return const _HeroSection();
      case 1: return const _AppBarShowcase();
      case 2: return const _CardShowcase();
      case 3: return const _NavBarShowcase();
      case 4: return const _DialogShowcase();
      case 5: return const _AllTogetherSection();
      default: return const _HeroSection();
    }
  }
}

// ═══════════════════════════════════════════════════════════
// BACKGROUND WIDGET — estrellas + glow
// ═══════════════════════════════════════════════════════════ 

class _StarsBackground extends StatelessWidget {
  final Widget child;
  const _StarsBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0.2, -0.3),
          radius: 0.8,
          colors: [
            Color(0xFF1A1040),
            Color(0xFF0B0B1A),
            Color(0xFF05050F),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Estrellas
          Positioned.fill(
            child: CustomPaint(
              painter: _StarsPainter(),
            ),
          ),
          // Glow central
          Positioned(
            top: -100,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0.5, 0),
                    radius: 0.6,
                    colors: [
                      const Color(0xFF10B981).withValues(alpha: 0.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Content
          child,
        ],
      ),
    );
  }
}

class _StarsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rng = _SeededRandom(42);
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.4);
    for (int i = 0; i < 80; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height;
      final radius = rng.nextDouble() * 1.5 + 0.5;
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SeededRandom {
  int _seed;
  _SeededRandom(this._seed);
  double nextDouble() {
    _seed = (_seed * 1103515245 + 12345) & 0x7fffffff;
    return _seed / 0x7fffffff;
  }
}

// ═══════════════════════════════════════════════════════════
// SECCIÓN 0: HERO
// ═══════════════════════════════════════════════════════════

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _StarsBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            children: [
              // Badge row
              Wrap(
                spacing: 8,
                runSpacing: 6,
                alignment: WrapAlignment.center,
                children: [
                  _Badge('v0.2.0', const Color(0xFF10B981)),
                  _Badge('Drop-in', const Color(0xFF6366F1)),
                  _Badge('Material 3', const Color(0xFFF59E0B)),
                  _Badge('MIT', const Color(0xFF8B5CF6)),
                ],
              ),
              const SizedBox(height: 40),
              // Logo / Icon
              Icon(Icons.blur_on_rounded, size: 72,
                   color: theme.colorScheme.primary),
              const SizedBox(height: 20),
              Text('ApliArte\nGlass Theme',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    height: 1.15,
                    letterSpacing: -1,
                  )),
              const SizedBox(height: 12),
              Text(
                'Drop-in replacement de Material 3\n'
                'con efecto glass morphism.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 32),
              // CTA buttons
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _GlassCtaButton(
                    label: 'Ver componentes',
                    icon: Icons.explore_rounded,
                    primary: true,
                    onTap: () {},
                  ),
                  const SizedBox(width: 12),
                  _GlassCtaButton(
                    label: 'GitHub ↗',
                    icon: Icons.code_rounded,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 48),
              // Diagrama de componentes
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          _CompIcon(Icons.vertical_align_top_rounded, 'AppBar'),
                          _CompIcon(Icons.credit_card_rounded, 'Card'),
                          _CompIcon(Icons.explore_rounded, 'NavBar'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          _CompIcon(Icons.keyboard_arrow_up_rounded, 'BtmAppBar'),
                          _CompIcon(Icons.chat_rounded, 'Dialog'),
                          _CompIcon(Icons.widgets_rounded, '+ más'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text('Mismas clases, mismas APIs, mismo código.',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 13,
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Cómo empezar
              Text('Empieza en segundos',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _CodeLine(r"flutter pub add apliarte_glass_theme"),
                      const SizedBox(height: 8),
                      _CodeLine("import 'package:apliarte_glass_theme/...';"),
                      const SizedBox(height: 4),
                      _CodeLine(''),
                      _CodeLine('// Todo igual que Material 3:'),
                      _CodeLine("AppBar(title: const Text('Hola'));"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 48),
              // Footer
              Text('MIT — © 2026 ApliArte',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.3),
                    fontSize: 12,
                  )),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color color;
  const _Badge(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 0.5),
      ),
      child: Text(label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          )),
    );
  }
}

class _GlassCtaButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool primary;
  final VoidCallback onTap;
  const _GlassCtaButton({
    required this.label,
    required this.icon,
    this.primary = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: primary ? theme.colorScheme.primary : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: primary ? null : Border.all(color: Colors.white.withValues(alpha: 0.15)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16,
                   color: primary ? Colors.white : Colors.white.withValues(alpha: 0.7)),
              const SizedBox(width: 6),
              Text(label,
                  style: TextStyle(
                    color: primary ? Colors.white : Colors.white.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class _CompIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  const _CompIcon(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}

class _CodeLine extends StatelessWidget {
  final String text;
  const _CodeLine(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 13,
          color: Color(0xFFA6E3A1),
          height: 1.6,
        ));
  }
}

// ═══════════════════════════════════════════════════════════
// SECCIÓN 1: APPBAR SHOWCASE
// ═══════════════════════════════════════════════════════════

class _AppBarShowcase extends StatelessWidget {
  const _AppBarShowcase();

  @override
  Widget build(BuildContext context) {
    return _StarsBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('AppBar',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text('Toolbar de vidrio. Misma API que Material 3.',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.5))),
              const SizedBox(height: 24),
              // Live demo
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Text('Demo en vivo',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                    ),
                    const AppBar(
                      title: Text('Título glass'),
                      actions: [
                        IconButton(icon: Icon(Icons.search), onPressed: null),
                        IconButton(icon: Icon(Icons.more_vert), onPressed: null),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 80,
                      color: Colors.transparent,
                      child: const Center(
                        child: Text('Contenido debajo del AppBar',
                            style: TextStyle(color: Colors.white38)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // AppBar with TabBar
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Text('Con TabBar',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                    ),
                    const DefaultTabController(
                      length: 3,
                      child: Column(
                        children: [
                          AppBar(
                            title: Text('Tabs'),
                            bottom: TabBar(
                              tabs: [
                                Tab(text: 'Primero'),
                                Tab(text: 'Segundo'),
                                Tab(text: 'Tercero'),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            child: TabBarView(
                              children: [
                                Center(child: Text('Pestaña 1', style: TextStyle(color: Colors.white54))),
                                Center(child: Text('Pestaña 2', style: TextStyle(color: Colors.white54))),
                                Center(child: Text('Pestaña 3', style: TextStyle(color: Colors.white54))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Código
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Código',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      const SizedBox(height: 8),
                      _CodeLine("/** Misma API que Material 3 */"),
                      _CodeLine("AppBar("),
                      _CodeLine("  title: const Text('Título'),"),
                      _CodeLine("  actions: [IconButton(...)],"),
                      _CodeLine("  bottom: TabBar(tabs: [...]),"),
                      _CodeLine(")"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// SECCIÓN 2: CARD SHOWCASE
// ═══════════════════════════════════════════════════════════

class _CardShowcase extends StatelessWidget {
  const _CardShowcase();

  @override
  Widget build(BuildContext context) {
    return _StarsBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Card',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text('Cards de vidrio. Se adaptan a cualquier contenido.',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.5))),
              const SizedBox(height: 24),
              // Card simple
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Card simple',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('Este card usa el efecto glass morphism. '
                          'El fondo estrellado se ve a través del vidrio.'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Card con icono + row
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 40),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Card con icono',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text('Row con icono + texto. Ideal para listas.'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Card con header visual
              Card(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                            Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Icon(Icons.image_rounded, size: 40,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Card con header',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text('Área visual destacada en la parte superior.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Código
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Código',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      const SizedBox(height: 8),
                      _CodeLine("Card("),
                      _CodeLine("  child: Column(children: ["),
                      _CodeLine("    Text('Título'),"),
                      _CodeLine("    Text('Contenido'),"),
                      _CodeLine("  ]),"),
                      _CodeLine(")"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// SECCIÓN 3: NAVIGATIONBAR SHOWCASE
// ═══════════════════════════════════════════════════════════

class _NavBarShowcase extends StatelessWidget {
  const _NavBarShowcase();

  @override
  Widget build(BuildContext context) {
    return _StarsBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('NavigationBar',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text('Bottom nav con glass + indicador deslizante + drag.',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.5))),
              const SizedBox(height: 24),
              // Preview del navbar
              const Card(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Demo',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      SizedBox(height: 4),
                      Text('El NavigationBar que ves abajo es el componente glass.',
                          style: TextStyle(color: Colors.white54, fontSize: 13)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text('✨ Características',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      _FeatureRow(Icons.gesture_rounded, 'Drag lateral entre tabs'),
                      _FeatureRow(Icons.animation_rounded, 'Indicador deslizante animado'),
                      _FeatureRow(Icons.palette_rounded, 'Color activo desde Theme'),
                      _FeatureRow(Icons.nights_stay_rounded, 'Adaptación dark/light'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Preview aislado',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 72,
                        child: NavigationBar(
                          destinations: const [
                            NavigationDestination(icon: Icon(Icons.home), label: 'Uno'),
                            NavigationDestination(icon: Icon(Icons.favorite), label: 'Dos'),
                            NavigationDestination(icon: Icon(Icons.person), label: 'Tres'),
                          ],
                          selectedIndex: 0,
                          onDestinationSelected: (_) {},
                          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Código',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      const SizedBox(height: 8),
                      _CodeLine("NavigationBar("),
                      _CodeLine("  destinations: ["),
                      _CodeLine("    NavigationDestination("),
                      _CodeLine("      icon: Icon(Icons.home),"),
                      _CodeLine("      label: 'Inicio',"),
                      _CodeLine("    ),"),
                      _CodeLine("    // ... más destinos"),
                      _CodeLine("  ],"),
                      _CodeLine("  selectedIndex: _index,"),
                      _CodeLine("  onDestinationSelected: (i) {},"),
                      _CodeLine(")"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _FeatureRow(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// SECCIÓN 4: ALERTDIALOG SHOWCASE
// ═══════════════════════════════════════════════════════════

class _DialogShowcase extends StatelessWidget {
  const _DialogShowcase();

  @override
  Widget build(BuildContext context) {
    return _StarsBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('AlertDialog',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text('Diálogos modales de vidrio. Misma API que Material.',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.5))),
              const SizedBox(height: 24),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text('Diálogo simple',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          icon: const Icon(Icons.open_in_new),
                          label: const Text('Abrir diálogo glass'),
                          onPressed: () => _showDialog(context, false),
                        ),
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
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.tonalIcon(
                          icon: const Icon(Icons.celebration),
                          label: const Text('Abrir con icono'),
                          onPressed: () => _showDialog(context, true),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Código',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      const SizedBox(height: 8),
                      _CodeLine("showDialog("),
                      _CodeLine("  context: context,"),
                      _CodeLine("  builder: (_) => AlertDialog("),
                      _CodeLine("    title: const Text('Título'),"),
                      _CodeLine("    content: const Text('Mensaje'),"),
                      _CodeLine("    actions: [TextButton(...)],"),
                      _CodeLine("  ),"),
                      _CodeLine(");"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, bool withIcon) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: withIcon
            ? Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Icon(Icons.celebration, size: 36, color: Colors.amber),
              )
            : null,
        title: Text(withIcon ? '¡Celebración!' : 'Diálogo Glass'),
        content: Text(
          withIcon
              ? 'Diálogo glass con icono decorativo. El efecto vidrio se adapta al fondo.'
              : 'Este diálogo usa el efecto glass morphism.\n'
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
  }
}

// ═══════════════════════════════════════════════════════════
// SECCIÓN 5: TODO JUNTO
// ═══════════════════════════════════════════════════════════

class _AllTogetherSection extends StatefulWidget {
  const _AllTogetherSection();

  @override
  State<_AllTogetherSection> createState() => _AllTogetherSectionState();
}

class _AllTogetherSectionState extends State<_AllTogetherSection> {
  int _navIdx = 0;
  int _selectedFab = 0;

  @override
  Widget build(BuildContext context) {
    return _StarsBackground(
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('App completa'),
            actions: [
              IconButton(icon: const Icon(Icons.favorite), onPressed: () {}),
              IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Ejemplo completo',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text('Todos los componentes glass funcionando juntos.',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.5))),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView(
                    children: [
                      const Card(
                        child: ListTile(
                          leading: Icon(Icons.notifications, color: Colors.amber),
                          title: Text('Notificación importante'),
                          subtitle: Text('Este es un ListTile dentro de un Card glass.'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text('Estadísticas',
                                  style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _StatChip('Usuarios', '1.2K'),
                                  _StatChip('Visitas', '8.5K'),
                                  _StatChip('Estrellas', '42'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Icon(Icons.info_outline,
                                  color: Theme.of(context).colorScheme.primary),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Text(
                                  'Probá abrir un diálogo desde la sección anterior. '
                                  'El NavigationBar de abajo tiene drag lateral.'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _FabOption(Icons.edit, 0),
                                  _FabOption(Icons.share, 1),
                                  _FabOption(Icons.delete, 2),
                                ],
                              ),
                              const SizedBox(height: 12),
                              FloatingActionButton.extended(
                                heroTag: 'fab_demo',
                                onPressed: () {},
                                icon: const Icon(Icons.add),
                                label: const Text('Crear nuevo'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: NavigationBar(
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Inicio'),
              NavigationDestination(icon: Icon(Icons.favorite_rounded), label: 'Favoritos'),
              NavigationDestination(icon: Icon(Icons.person_rounded), label: 'Perfil'),
            ],
            selectedIndex: _navIdx,
            onDestinationSelected: (i) => setState(() => _navIdx = i),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          ),
        ),
      ),
    );
  }

  Widget _FabOption(IconData icon, int idx) {
    final selected = _selectedFab == idx;
    return GestureDetector(
      onTap: () => setState(() => _selectedFab = idx),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: selected
              ? Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.4))
              : null,
        ),
        child: Icon(icon, color: selected ? Theme.of(context).colorScheme.primary : Colors.white54),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  const _StatChip(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.w800,
              color: Colors.white,
            )),
        Text(label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withValues(alpha: 0.5),
            )),
      ],
    );
  }
}
