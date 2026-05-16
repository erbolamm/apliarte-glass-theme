import 'package:flutter/material.dart' hide AppBar, Card, NavigationBar, BottomAppBar, AlertDialog;
import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

// ─────────────────────────────────────────────────────────────
// ENTRY
// ─────────────────────────────────────────────────────────────

void main() => runApp(const GlassShowcaseApp());

class GlassShowcaseApp extends StatelessWidget {
  const GlassShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ApliArte Glass Theme',
      debugShowCheckedModeBanner: false,
      theme: _theme(Brightness.light),
      darkTheme: _theme(Brightness.dark),
      themeMode: ThemeMode.system,
      home: const ShowcasePage(),
    );
  }

  ThemeData _theme(Brightness b) => ThemeData(
    useMaterial3: true,
    brightness: b,
    colorScheme: ColorScheme.fromSeed(seedColor: primary, brightness: b),
    textTheme: GoogleFonts.interTextTheme(
      b == Brightness.dark ? ThemeData.dark().textTheme : null,
    ),
    scaffoldBackgroundColor:
        b == Brightness.dark ? const Color(0xFF0F0F1A) : const Color(0xFFF8F9FC),
  );
}

const primary = Color(0xFF005FA9);
const shareUrl = 'https://erbolamm.github.io/apliarte-glass-theme/';
const shareText =
    'ApliArte%20Glass%20Theme%20%E2%80%94%20Drop-in%20replacement%20de%20Material%203%20con%20efecto%20glass%20morphism.';

// ─────────────────────────────────────────────────────────────
// SHOWCASE PAGE
// ─────────────────────────────────────────────────────────────

class ShowcasePage extends StatefulWidget {
  const ShowcasePage({super.key});

  @override
  State<ShowcasePage> createState() => _ShowcasePageState();
}

class _ShowcasePageState extends State<ShowcasePage> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _NavBar(),
            _HeroSection(),
            SizedBox(
              height: 100,
              child: NavigationBar(
                selectedIndex: 0,
                onDestinationSelected: (_) {},
                labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                destinations: const [
                  NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),
                  NavigationDestination(icon: Icon(Icons.favorite), label: 'Favoritos'),
                  NavigationDestination(icon: Icon(Icons.person), label: 'Perfil'),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text('↑ NavigationBar glass — el que empezó todo',
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
            ),
            _Section(
              title: 'AppBar',
              icon: Icons.vertical_align_top,
              child: _AppBarDemo(),
            ),
            _Section(
              title: 'Card',
              icon: Icons.credit_card,
              child: _CardDemo(),
            ),
            _Section(
              title: 'NavigationBar',
              icon: Icons.explore,
              child: _NavBarDemo(),
            ),
            _Section(
              title: 'BottomAppBar',
              icon: Icons.keyboard_arrow_up,
              child: _BottomAppBarDemo(),
            ),
            _Section(
              title: 'AlertDialog',
              icon: Icons.chat,
              child: _DialogDemo(),
            ),
            _Section(
              title: 'Código completo',
              icon: Icons.code,
              child: _CodeDemo(),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 48, 24, 0),
              child: _ShareSection(),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 48, 24, 0),
              child: _SupportSection(),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 48, 24, 48),
              child: _FooterSection(),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// NAVBAR
// ─────────────────────────────────────────────────────────────

class _NavBar extends StatelessWidget {
  _NavBar();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: primary,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 52,
      child: Row(
        children: [
          Icon(Icons.blur_on, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          const Text('APLIARTE GLASS',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  letterSpacing: 2)),
          const Spacer(),
          _NavLink('GitHub', () => launchUrl(
              Uri.parse('https://github.com/erbolamm/apliarte-glass-theme'))),
          _NavLink('pub.dev', () => launchUrl(
              Uri.parse('https://pub.dev/packages/apliarte_glass_theme'))),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode,
                color: Colors.white, size: 20),
            tooltip: isDark ? 'Modo claro' : 'Modo oscuro',
            onPressed: () => _rebuild(context, isDark ? ThemeMode.light : ThemeMode.dark),
          ),
        ],
      ),
    );
  }

  void _rebuild(BuildContext context, ThemeMode mode) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => MaterialApp(
          title: 'ApliArte Glass Theme',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true, brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(seedColor: primary, brightness: Brightness.light),
            textTheme: GoogleFonts.interTextTheme(),
            scaffoldBackgroundColor: const Color(0xFFF8F9FC),
          ),
          darkTheme: ThemeData(
            useMaterial3: true, brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(seedColor: primary, brightness: Brightness.dark),
            textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
            scaffoldBackgroundColor: const Color(0xFF0F0F1A),
          ),
          themeMode: mode,
          home: const ShowcasePage(),
        ),
        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _NavLink(this.label, this.onTap);

  @override
  Widget build(BuildContext context) => Padding(
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
          child: Text(label,
              style: const TextStyle(
                  color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
        ),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// HERO
// ─────────────────────────────────────────────────────────────

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final narrow = MediaQuery.of(context).size.width < 600;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: narrow ? 48 : 80),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primary, Color(0xFF00467B), Color(0xFF1A1A2E)],
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
            child: const Text('Drop-in replacement · Material 3 · MIT',
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5)),
          ),
          const SizedBox(height: 24),
          Icon(Icons.blur_on, size: 56, color: Colors.white.withValues(alpha: 0.9)),
          const SizedBox(height: 16),
          Text('ApliArte Glass Theme',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: narrow ? 36 : 48,
                  fontWeight: FontWeight.w900,
                  height: 1.1)),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: const Text(
              'Las mismas clases de Material 3 (AppBar, Card, NavigationBar…)\n'
              'pero con efecto glass morphism. Adaptación dark/light automática.\n'
              'Un solo cambio de import y toda tu app se vuelve vidrio.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.7),
            ),
          ),
          const SizedBox(height: 24),
          Wrap(spacing: 8, runSpacing: 8, alignment: WrapAlignment.center, children: [
            _Badge('v0.2.0', const Color(0xFF22C55E)),
            _Badge('Drop-in', const Color(0xFF6366F1)),
            _Badge('Material 3', const Color(0xFFF59E0B)),
            _Badge('Dark/Light', const Color(0xFF8B5CF6)),
            _Badge('MIT', const Color(0xFFEC4899)),
          ]),
          const SizedBox(height: 24),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10, height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF22C55E).withValues(alpha: 0.5),
                      blurRadius: 8, spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Text('v0.2.0 — Listo para usar',
                  style: TextStyle(color: Colors.white60, fontSize: 14, fontWeight: FontWeight.w500)),
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
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 0.5),
    ),
    child: Text(label,
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
  );
}

// ─────────────────────────────────────────────────────────────
// SECTION WRAPPER
// ─────────────────────────────────────────────────────────────

class _Section extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  const _Section({required this.title, required this.icon, required this.child});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: t.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: t.colorScheme.primary, size: 20),
            ),
            const SizedBox(width: 12),
            Text(title,
                style: t.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
          ]),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// CODE CARD
// ─────────────────────────────────────────────────────────────

class _CodeCard extends StatelessWidget {
  final List<String> lines;
  const _CodeCard({required this.lines});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A2E) : const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          _dot(0xFFFF5F57), const SizedBox(width: 6),
          _dot(0xFFFEBC2E), const SizedBox(width: 6),
          _dot(0xFF28C840), const SizedBox(width: 12),
          Text('code.dart',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 12)),
        ]),
        const SizedBox(height: 16),
        for (final l in lines)
          Text(l, style: const TextStyle(
            fontFamily: 'monospace', fontSize: 13, color: Color(0xFFA6E3A1), height: 1.6,
          )),
      ]),
    );
  }

  Widget _dot(int h) =>
      Container(width: 10, height: 10,
          decoration: BoxDecoration(color: Color(h), shape: BoxShape.circle));
}

// ─────────────────────────────────────────────────────────────
// 1 — APPBAR DEMO
// ─────────────────────────────────────────────────────────────

class _AppBarDemo extends StatelessWidget {
  const _AppBarDemo();

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: t.dividerColor),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              height: 160,
              child: Column(children: [
                const AppBar(
                  title: Text('AppBar de vidrio'),
                  actions: [
                    IconButton(icon: Icon(Icons.search), onPressed: null),
                    IconButton(icon: Icon(Icons.more_vert), onPressed: null),
                  ],
                ),
                Expanded(
                  child: Container(
                    color: t.scaffoldBackgroundColor,
                    child: const Center(
                      child: Text('Contenido debajo del AppBar',
                          style: TextStyle(color: Color(0xFF9CA3AF))),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
        const _CodeCard(lines: [
          "AppBar(",
          "  title: const Text('Título'),",
          "  actions: [IconButton(...)],",
          ")",
        ]),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// 2 — CARD DEMO
// ─────────────────────────────────────────────────────────────

class _CardDemo extends StatelessWidget {
  const _CardDemo();

  @override
  Widget build(BuildContext context) => Column(
    children: [
      const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Card simple', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Este card usa efecto glass morphism. '
                'El fondo se ve a través del vidrio.'),
          ]),
        ),
      ),
      const SizedBox(height: 12),
      const Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(children: [
            Icon(Icons.star, color: Colors.amber, size: 40),
            SizedBox(width: 16),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Card con icono',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Row con icono + texto. Ideal para listas.'),
              ]),
            ),
          ]),
        ),
      ),
      const _CodeCard(lines: [
        "Card(",
        "  child: Column(children: [",
        "    Text('Título'), Text('Contenido'),",
        "  ]),",
        ")",
      ]),
    ],
  );
}

// ─────────────────────────────────────────────────────────────
// 3 — NAVBAR DEMO (PREVIEW)
// ─────────────────────────────────────────────────────────────

class _NavBarDemo extends StatelessWidget {
  const _NavBarDemo();

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: double.infinity,
            child: NavigationBar(
              selectedIndex: 1,
              onDestinationSelected: (_) {},
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),
                NavigationDestination(icon: Icon(Icons.favorite), label: 'Fav'),
                NavigationDestination(icon: Icon(Icons.person), label: 'Perfil'),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 16),
      Row(children: [
        Expanded(child: _FCard(Icons.gesture, 'Drag lateral')),
        const SizedBox(width: 12),
        Expanded(child: _FCard(Icons.animation, 'Indicador animado')),
        const SizedBox(width: 12),
        Expanded(child: _FCard(Icons.palette, 'Color del tema')),
      ]),
      const _CodeCard(lines: [
        "NavigationBar(",
        "  destinations: [",
        "    NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),",
        "  ],",
        "  selectedIndex: i,",
        "  onDestinationSelected: (i) {},",
        ")",
      ]),
    ],
  );
}

class _FCard extends StatelessWidget {
  final IconData icon;
  final String label;
  const _FCard(this.icon, this.label);

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        Icon(icon, color: primary),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ]),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// 4 — BOTTOMAPPBAR DEMO
// ─────────────────────────────────────────────────────────────

class _BottomAppBarDemo extends StatelessWidget {
  const _BottomAppBarDemo();

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: const SizedBox(
            height: 80,
            child: BottomAppBar(
              child: Row(children: [
                IconButton(icon: Icon(Icons.menu), onPressed: null),
                Spacer(),
                IconButton(icon: Icon(Icons.search), onPressed: null),
                IconButton(icon: Icon(Icons.add), onPressed: null),
              ]),
            ),
          ),
        ),
      ),
      const _CodeCard(lines: [
        "BottomAppBar(",
        "  child: Row(children: [",
        "    IconButton(icon: Icon(Icons.menu), ...),",
        "    Spacer(),",
        "  ]),",
        ")",
      ]),
    ],
  );
}

// ─────────────────────────────────────────────────────────────
// 5 — DIALOG DEMO
// ─────────────────────────────────────────────────────────────

class _DialogDemo extends StatelessWidget {
  const _DialogDemo();

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(children: [
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                const Text('Diálogo simple',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Abrir'),
                    onPressed: () => _showSimple(context),
                  ),
                ),
              ]),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                const Text('Con icono',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.tonalIcon(
                    icon: const Icon(Icons.celebration),
                    label: const Text('Abrir'),
                    onPressed: () => _showWithIcon(context),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ]),
      const _CodeCard(lines: [
        "showDialog(",
        "  context: context,",
        "  builder: (_) => AlertDialog(",
        "    title: Text('Título'),",
        "    content: Text('Mensaje'),",
        "    actions: [TextButton(...)],",
        "  ),",
        ");",
      ]),
    ],
  );

  void _showSimple(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Diálogo Glass'),
        content: const Text('Misma API que Material 3.\nSe adapta a dark/light automáticamente.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
          FilledButton(onPressed: () => Navigator.pop(ctx), child: const Text('Aceptar')),
        ],
      ),
    );
  }

  void _showWithIcon(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.celebration, size: 40, color: Colors.amber),
        title: const Text('¡Celebración!'),
        content: const Text('Diálogo glass con icono decorativo arriba.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cerrar')),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// 6 — CÓDIGO
// ─────────────────────────────────────────────────────────────

class _CodeDemo extends StatelessWidget {
  const _CodeDemo();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A2E) : const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          _dot(0xFFFF5F57), const SizedBox(width: 6),
          _dot(0xFFFEBC2E), const SizedBox(width: 6),
          _dot(0xFF28C840), const SizedBox(width: 12),
          Text('main.dart',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 12)),
        ]),
        const SizedBox(height: 16),
        _CL(r"import 'package:flutter/material.dart' hide AppBar, Card, NavigationBar, BottomAppBar, AlertDialog;"),
        _CL(r"import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';"),
        _CL(''),
        _CL('void main() => runApp(const MyApp());'),
        _CL(''),
        _CL('class MyApp extends StatelessWidget {'),
        _CL('  @override'),
        _CL('  Widget build(BuildContext context) {'),
        _CL('    return MaterialApp('),
        _CL("      title: 'Mi App Glass',"),
        _CL('      home: Scaffold('),
        _CL('        appBar: AppBar(title: Text(\'Inicio\')), // glass'),
        _CL('        body: Card(child: Text(\'Hola glass!\')),  // glass'),
        _CL('        bottomNavigationBar: NavigationBar('),
        _CL("          destinations: const ["),
        _CL("            NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),"),
        _CL('          ],'),
        _CL('          selectedIndex: 0,'),
        _CL('          onDestinationSelected: (_) {},'),
        _CL('        ),'),
        _CL('      ),'),
        _CL('    );'),
        _CL('  }'),
        _CL('}'),
        _CL(''),
        _CL('// Diálogos:'),
        _CL("showDialog(context: context, builder: (_) => AlertDialog("),
        _CL("  title: Text('Título'), content: Text('Mensaje'),"),
        _CL('));'),
      ]),
    );
  }

  Widget _dot(int h) =>
      Container(width: 10, height: 10,
          decoration: BoxDecoration(color: Color(h), shape: BoxShape.circle));
}

Widget _CL(String t) => Text(t, style: const TextStyle(
  fontFamily: 'monospace', fontSize: 12, color: Color(0xFFA6E3A1), height: 1.6,
));

// ─────────────────────────────────────────────────────────────
// SHARE
// ─────────────────────────────────────────────────────────────

class _ShareSection extends StatelessWidget {
  const _ShareSection();

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Comparte',
            style: t.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text('Si te gusta ApliArte Glass Theme, ayuda a que más gente lo conozca.',
            style: TextStyle(color: t.colorScheme.onSurface.withValues(alpha: 0.5))),
        const SizedBox(height: 24),
        Wrap(spacing: 12, runSpacing: 12, children: [
          _ShareBtn('𝕏 Twitter',
              'https://twitter.com/intent/tweet?text=$shareText&url=$shareUrl'),
          _ShareBtn('💼 LinkedIn',
              'https://www.linkedin.com/sharing/share-offsite/?url=$shareUrl'),
          _ShareBtn('🟠 Reddit',
              'https://www.reddit.com/submit?url=$shareUrl&title=ApliArte%20Glass%20Theme'),
          _ShareBtn('💬 WhatsApp',
              'https://api.whatsapp.com/send?text=$shareText%20$shareUrl'),
        ]),
      ],
    );
  }
}

class _ShareBtn extends StatelessWidget {
  final String label, url;
  const _ShareBtn(this.label, this.url);

  @override
  Widget build(BuildContext context) => OutlinedButton.icon(
    icon: const Icon(Icons.open_in_new, size: 16),
    label: Text(label),
    onPressed: () => launchUrl(Uri.parse(url)),
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      side: BorderSide(color: Theme.of(context).dividerColor),
    ),
  );
}

// ─────────────────────────────────────────────────────────────
// SUPPORT
// ─────────────────────────────────────────────────────────────

class _SupportSection extends StatelessWidget {
  const _SupportSection();

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Apoya el proyecto',
            style: t.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text('Herramienta gratuita y open source. Si te ahorra tiempo, un café ayuda a mantener el desarrollo.',
            style: TextStyle(color: t.colorScheme.onSurface.withValues(alpha: 0.5))),
        const SizedBox(height: 24),
        Wrap(spacing: 12, runSpacing: 12, children: [
          _SupportBtn('PayPal', Icons.payment, 'https://paypal.me/erbolamm'),
          _SupportBtn('Ko-fi', Icons.coffee, 'https://ko-fi.com/C0C11TWR1K'),
          _SupportBtn('Twitch Tip', Icons.live_tv,
              'https://streamelements.com/apliarte/tip'),
        ]),
      ],
    );
  }
}

class _SupportBtn extends StatelessWidget {
  final String label, url;
  final IconData icon;
  const _SupportBtn(this.label, this.icon, this.url);

  @override
  Widget build(BuildContext context) => FilledButton.tonalIcon(
    icon: Icon(icon, size: 18),
    label: Text(label),
    onPressed: () => launchUrl(Uri.parse(url)),
  );
}

// ─────────────────────────────────────────────────────────────
// FOOTER
// ─────────────────────────────────────────────────────────────

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: t.colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: [
        Text('v0.2.0  ·  Hecho por Javier Mateo (ApliArte)',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: t.colorScheme.onSurface.withValues(alpha: 0.6), fontSize: 13)),
        const SizedBox(height: 8),
        Wrap(spacing: 16, runSpacing: 8, alignment: WrapAlignment.center, children: [
          _FooterBtn('GitHub', 'https://github.com/erbolamm/apliarte-glass-theme'),
          _FooterBtn('pub.dev', 'https://pub.dev/packages/apliarte_glass_theme'),
          _FooterBtn('apliarte.com', 'https://apliarte.com'),
          _FooterBtn('MIT License',
              'https://github.com/erbolamm/apliarte-glass-theme/blob/main/LICENSE'),
        ]),
      ]),
    );
  }
}

class _FooterBtn extends StatelessWidget {
  final String label, url;
  const _FooterBtn(this.label, this.url);

  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: () => launchUrl(Uri.parse(url)),
    child: Text(label, style: const TextStyle(fontSize: 13)),
  );
}
