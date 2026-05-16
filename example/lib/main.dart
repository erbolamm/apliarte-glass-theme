import 'package:flutter/material.dart' hide AppBar, Card, NavigationBar, BottomAppBar, AlertDialog;
import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const GlassShowcaseApp());
}

class GlassShowcaseApp extends StatelessWidget {
  const GlassShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ApliArte Glass Theme',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF005FA9),
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.interTextTheme(),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F5F7),
      ),
      home: const ShowcaseHome(),
    );
  }
}

class ShowcaseHome extends StatelessWidget {
  const ShowcaseHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            _NavBar(),
            _HeroSection(),
            _ComponentSection(
              title: 'AppBar',
              subtitle: 'Toolbar con efecto glass. Misma API que Material 3.',
              icon: Icons.vertical_align_top,
              child: _AppBarDemo(),
            ),
            _ComponentSection(
              title: 'Card',
              subtitle: 'Cards con frosted glass. Se adaptan a cualquier contenido.',
              icon: Icons.credit_card,
              child: _CardDemo(),
            ),
            _ComponentSection(
              title: 'NavigationBar',
              subtitle: 'Bottom nav con vidrio + indicador deslizante + drag lateral.',
              icon: Icons.explore,
              child: _NavBarDemo(),
            ),
            _ComponentSection(
              title: 'BottomAppBar',
              subtitle: 'Barra inferior de vidrio. Ideal con FAB.',
              icon: Icons.keyboard_arrow_up,
              child: _BottomAppBarDemo(),
            ),
            _ComponentSection(
              title: 'AlertDialog',
              subtitle: 'Diálogos modales de vidrio. Misma API que Material.',
              icon: Icons.chat,
              child: _DialogDemo(),
            ),
            _FooterSection(),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// NAVBAR
// ═══════════════════════════════════════════════════════════

class _NavBar extends StatelessWidget {
  const _NavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF005FA9),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 52,
      child: Row(
        children: [
          Icon(Icons.blur_on, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          const Text(
            'APLIARTE GLASS',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 14,
              letterSpacing: 2,
            ),
          ),
          const Spacer(),
          _NavLink(
            label: 'GitHub',
            onTap: () => launchUrl(
              Uri.parse('https://github.com/erbolamm/apliarte-glass-theme'),
            ),
          ),
          _NavLink(
            label: 'pub.dev',
            onTap: () => launchUrl(
              Uri.parse('https://pub.dev/packages/apliarte_glass_theme'),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _NavLink({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white24),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// HERO
// ═══════════════════════════════════════════════════════════

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.of(context).size.width < 600;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: isNarrow ? 48 : 80,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF005FA9),
            Color(0xFF00467B),
            Color(0xFF1A1A2E),
          ],
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white30),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Drop-in replacement · Material 3 · MIT',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Icon(Icons.blur_on, size: 56, color: Colors.white.withValues(alpha: 0.9)),
          const SizedBox(height: 16),
          Text(
            'ApliArte\nGlass Theme',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: isNarrow ? 36 : 52,
              fontWeight: FontWeight.w900,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: const Text(
              'Las mismas clases de Material 3 (AppBar, Card, NavigationBar...)\n'
              'pero con efecto glass morphism. Adaptación dark/light automática.\n'
              'Un solo cambio de import y todo tu proyecto se vuelve vidrio.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                height: 1.7,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF22C55E).withValues(alpha: 0.5),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'v0.2.0 — Listo para usar',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _Badge('AppBar de vidrio', const Color(0xFF22C55E)),
              _Badge('Card frosted', const Color(0xFF6366F1)),
              _Badge('NavBar + drag', const Color(0xFFF59E0B)),
              _Badge('BottomAppBar', const Color(0xFF8B5CF6)),
              _Badge('AlertDialog', const Color(0xFFEC4899)),
            ],
          ),
        ],
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
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// COMPONENT SECTION WRAPPER
// ═══════════════════════════════════════════════════════════

class _ComponentSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget child;
  const _ComponentSection({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF005FA9), size: 22),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF303030),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// CODE SNIPPET WIDGET
// ═══════════════════════════════════════════════════════════

class _CodeCard extends StatelessWidget {
  final List<String> lines;
  const _CodeCard({required this.lines});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines.map((line) => Text(
          line,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            color: Color(0xFFA6E3A1),
            height: 1.6,
          ),
        )).toList(),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// APPBAR DEMO
// ═══════════════════════════════════════════════════════════

class _AppBarDemo extends StatelessWidget {
  const _AppBarDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Live demo
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 120,
              child: Column(
                children: [
                  const AppBar(
                    title: Text('AppBar de vidrio'),
                    actions: [
                      IconButton(icon: Icon(Icons.search), onPressed: null),
                      IconButton(icon: Icon(Icons.more_vert), onPressed: null),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      color: const Color(0xFFF4F5F7),
                      child: const Center(
                        child: Text('Contenido debajo del AppBar',
                            style: TextStyle(color: Color(0xFF9CA3AF))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Code
        const _CodeCard(lines: [
          "AppBar(",
          "  title: const Text('Título'),",
          "  actions: [IconButton(...)],",
          "  bottom: TabBar(tabs: [...]),",
          ")",
        ]),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// CARD DEMO
// ═══════════════════════════════════════════════════════════

class _CardDemo extends StatelessWidget {
  const _CardDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Variante 1
        const Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Card simple',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Este card usa efecto glass morphism. '
                    'Se adapta a tema claro y oscuro automáticamente.'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Variante 2
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
                      Text('Ideal para listas con icono + texto.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Variante 3
        Card(
          child: Column(
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF005FA9).withValues(alpha: 0.1),
                      const Color(0xFF005FA9).withValues(alpha: 0.02),
                    ],
                  ),
                ),
                child: const Center(child: Icon(Icons.image, size: 32, color: Color(0xFF005FA9))),
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
        // Code
        const _CodeCard(lines: [
          "Card(",
          "  child: Column(children: [",
          "    Text('Título'),",
          "    Text('Contenido'),",
          "  ]),",
          ")",
        ]),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// NAVIGATIONBAR DEMO
// ═══════════════════════════════════════════════════════════

class _NavBarDemo extends StatelessWidget {
  const _NavBarDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 100,
              child: NavigationBar(
                destinations: const [
                  NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),
                  NavigationDestination(icon: Icon(Icons.favorite), label: 'Fav'),
                  NavigationDestination(icon: Icon(Icons.person), label: 'Perfil'),
                ],
                selectedIndex: 0,
                onDestinationSelected: (_) {},
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.gesture, size: 18, color: Color(0xFF005FA9)),
                    SizedBox(width: 8),
                    Text('Drag lateral entre tabs'),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.animation, size: 18, color: Color(0xFF005FA9)),
                    SizedBox(width: 8),
                    Text('Indicador deslizante animado'),
                  ],
                ),
              ],
            ),
          ),
        ),
        const _CodeCard(lines: [
          "NavigationBar(",
          "  destinations: [",
          "    NavigationDestination(",
          "      icon: Icon(Icons.home),",
          "      label: 'Inicio',",
          "    ),",
          "  ],",
          "  selectedIndex: _index,",
          "  onDestinationSelected: (i) {},",
          ")",
        ]),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// BOTTOMAPPBAR DEMO
// ═══════════════════════════════════════════════════════════

class _BottomAppBarDemo extends StatelessWidget {
  const _BottomAppBarDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 80,
              child: BottomAppBar(
                child: Row(
                  children: [
                    IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
                    const Spacer(),
                    IconButton(icon: const Icon(Icons.search), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.add), onPressed: () {}),
                  ],
                ),
              ),
            ),
          ),
        ),
        const _CodeCard(lines: [
          "BottomAppBar(",
          "  child: Row(children: [",
          "    IconButton(icon: Icon(Icons.menu), ...),",
          "    Spacer(),",
          "    IconButton(icon: Icon(Icons.search), ...),",
          "  ]),",
          ")",
        ]),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// ALERTDIALOG DEMO
// ═══════════════════════════════════════════════════════════

class _DialogDemo extends StatelessWidget {
  const _DialogDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Abrir diálogo glass'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Diálogo Glass'),
                          content: const Text(
                            'Este diálogo usa el efecto glass morphism.\n'
                            'Misma API que Material 3.\n'
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
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.tonalIcon(
                    icon: const Icon(Icons.celebration),
                    label: const Text('Abrir con icono'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          icon: Icon(Icons.celebration,
                              size: 40, color: Colors.amber),
                          title: const Text('¡Celebración!'),
                          content: const Text(
                            'Diálogo glass con icono decorativo arriba.\n'
                            'Misma API que AlertDialog de Material.',
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
                ),
              ],
            ),
          ),
        ),
        const _CodeCard(lines: [
          "showDialog(",
          "  context: context,",
          "  builder: (_) => AlertDialog(",
          "    title: const Text('Título'),",
          "    content: const Text('Mensaje'),",
          "    actions: [TextButton(...)],",
          "  ),",
          ");",
        ]),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// FOOTER
// ═══════════════════════════════════════════════════════════

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      color: const Color(0xFF00467B),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'ApliArte Glass Theme — Creado por ',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => launchUrl(Uri.parse('https://apliarte.com')),
                  child: const Text(
                    'ApliArte.com',
                    style: TextStyle(
                      color: Color(0xFF8FD5FA),
                      fontSize: 13,
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFF8FD5FA),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'Drop-in replacement de Material 3 · v0.2.0 · MIT',
            style: TextStyle(color: Colors.white38, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
