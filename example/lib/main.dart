import 'package:flutter/material.dart' hide AppBar, Card, NavigationBar, BottomAppBar, AlertDialog;
import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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
      home: const ShowcaseHome(),
    );
  }

  ThemeData _theme(Brightness b) => ThemeData(
    useMaterial3: true, brightness: b,
    colorScheme: ColorScheme.fromSeed(seedColor: primary, brightness: b),
    textTheme: GoogleFonts.interTextTheme(b == Brightness.dark ? ThemeData.dark().textTheme : null),
    scaffoldBackgroundColor: b == Brightness.dark ? const Color(0xFF0F0F1A) : const Color(0xFFF8F9FC),
  );
}

const primary = Color(0xFF005FA9);
const shareUrl = 'https://erbolamm.github.io/apliarte-glass-theme/';
const shareText = 'ApliArte%20Glass%20Theme%20%E2%80%94%20Drop-in%20replacement%20de%20Material%203%20con%20efecto%20glass%20morphism.';

// ─────────────────────────────────────────────────────────────
// SECTIONS
// ─────────────────────────────────────────────────────────────

enum Section {
  overview('Inicio', Icons.home_rounded),
  appbar('AppBar', Icons.vertical_align_top_rounded),
  card('Card', Icons.credit_card_rounded),
  navPreview('NavBar', Icons.explore_rounded),
  bottomAppBar('BtmAppBar', Icons.keyboard_arrow_up_rounded),
  dialog('Dialog', Icons.chat_rounded),
  code('Código', Icons.code_rounded);

  final String label;
  final IconData icon;
  const Section(this.label, this.icon);
}

// ─────────────────────────────────────────────────────────────
// HOME — ADAPTIVE SCAFFOLD
// ─────────────────────────────────────────────────────────────

class ShowcaseHome extends StatefulWidget {
  const ShowcaseHome({super.key});

  @override
  State<ShowcaseHome> createState() => _ShowcaseHomeState();
}

class _ShowcaseHomeState extends State<ShowcaseHome> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      selectedIndex: _selectedIndex,
      onSelectedIndexChange: (i) => setState(() => _selectedIndex = i),
      destinations: [
        for (final s in Section.values)
          NavigationDestination(icon: Icon(s.icon), label: s.label),
      ],
      smallBody: (_) => _body(context),
      body: (_) => _body(context),
      largeBody: (_) => _body(context),
    );
  }

  Widget _body(BuildContext context) => _SectionPage(section: Section.values[_selectedIndex]);
}

// ─────────────────────────────────────────────────────────────
// SECTION PAGE
// ─────────────────────────────────────────────────────────────

class _SectionPage extends StatelessWidget {
  final Section section;
  const _SectionPage({required this.section});

  @override
  Widget build(BuildContext context) {
    switch (section) {
      case Section.overview: return const _OverviewPage();
      case Section.appbar: return const _AppBarPage();
      case Section.card: return const _CardPage();
      case Section.navPreview: return const _NavBarPreviewPage();
      case Section.bottomAppBar: return const _BottomAppBarPage();
      case Section.dialog: return const _DialogPage();
      case Section.code: return const _CodePage();
    }
  }
}

// ─────────────────────────────────────────────────────────────
// HEADER / HELPERS
// ─────────────────────────────────────────────────────────────

class _PageHeader extends StatelessWidget {
  final Section section;
  const _PageHeader(this.section);
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Row(children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: t.colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(section.icon, color: t.colorScheme.primary, size: 20),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(section.label,
              style: t.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
          Text(_subtitle(section),
              style: TextStyle(color: t.colorScheme.onSurface.withValues(alpha: 0.5))),
        ]),
      ),
      _ThemeToggle(),
    ]);
  }

  String _subtitle(Section s) {
    switch (s) {
      case Section.overview: return 'Drop-in replacement de Material 3';
      case Section.appbar: return 'Toolbar de vidrio';
      case Section.card: return 'Frosted glass cards';
      case Section.navPreview: return 'La barra que empezó todo ✨';
      case Section.bottomAppBar: return 'Barra inferior glass';
      case Section.dialog: return 'Diálogos modales';
      case Section.code: return 'Ejemplo completo';
    }
  }
}

class _ThemeToggle extends StatelessWidget {
  const _ThemeToggle();
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return IconButton(
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: isDark
            ? const Icon(Icons.light_mode, key: ValueKey('l'))
            : const Icon(Icons.dark_mode, key: ValueKey('d')),
      ),
      tooltip: isDark ? 'Modo claro' : 'Modo oscuro',
      onPressed: () => _rebuild(context, isDark ? ThemeMode.light : ThemeMode.dark),
    );
  }

  void _rebuild(BuildContext context, ThemeMode mode) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => MaterialApp(
          title: 'ApliArte Glass Theme', debugShowCheckedModeBanner: false,
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
          home: const ShowcaseHome(),
        ),
        transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }
}

Widget _page(BuildContext context, Section s, List<Widget> children) => SingleChildScrollView(
  padding: const EdgeInsets.all(32),
  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    _PageHeader(s),
    const SizedBox(height: 28),
    ...children,
    const SizedBox(height: 48),
  ]),
);

class _CodeCard extends StatelessWidget {
  final List<String> lines;
  const _CodeCard({required this.lines});
  @override
  Widget build(BuildContext context) {
    final d = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity, margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: d ? const Color(0xFF1A1A2E) : const Color(0xFF1E1E2E),
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
        for (final l in lines) Text(l, style: const TextStyle(
          fontFamily: 'monospace', fontSize: 13, color: Color(0xFFA6E3A1), height: 1.6,
        )),
      ]),
    );
  }
  Widget _dot(int h) => Container(width: 10, height: 10,
      decoration: BoxDecoration(color: Color(h), shape: BoxShape.circle));
}

class _DemoFrame extends StatelessWidget {
  final Widget child;
  const _DemoFrame({required this.child});
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: t.dividerColor),
      ),
      child: ClipRRect(borderRadius: BorderRadius.circular(12), child: child),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// 0 — OVERVIEW
// ─────────────────────────────────────────────────────────────

class _OverviewPage extends StatelessWidget {
  const _OverviewPage();
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final isDark = t.brightness == Brightness.dark;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _PageHeader(Section.overview),
        const SizedBox(height: 28),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(40, 48, 40, 40),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft, end: Alignment.bottomRight,
              colors: isDark
                  ? [const Color(0xFF001F3F), const Color(0xFF0F0F1A)]
                  : [primary, const Color(0xFF00467B), const Color(0xFF1A1A2E)],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(children: [
            Icon(Icons.blur_on, size: 56, color: Colors.white.withValues(alpha: 0.9)),
            const SizedBox(height: 16),
            const Text('ApliArte Glass Theme',
                style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            const Text('Drop-in replacement de Material 3 con efecto glass morphism',
                style: TextStyle(color: Colors.white70, fontSize: 16), textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Wrap(spacing: 8, runSpacing: 8, alignment: WrapAlignment.center, children: [
              _badge('v0.2.0', const Color(0xFF22C55E)),
              _badge('Drop-in', const Color(0xFF6366F1)),
              _badge('Material 3', const Color(0xFFF59E0B)),
              _badge('Dark/Light', const Color(0xFF8B5CF6)),
              _badge('MIT', const Color(0xFFEC4899)),
            ]),
          ]),
        ),
        const SizedBox(height: 32),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: _MigrateCard(
            title: 'Antes (Material)', icon: Icons.close,
            iconColor: t.colorScheme.error,
            bgColor: t.colorScheme.errorContainer.withValues(alpha: 0.3),
            borderColor: t.colorScheme.error.withValues(alpha: 0.2),
            lines: [
              "import 'package:flutter/material.dart';",
              '', 'AppBar(title: ...);', 'Card(child: ...);',
            ],
          )),
          const SizedBox(width: 16),
          Expanded(child: _MigrateCard(
            title: 'Ahora (Glass ✨)', icon: Icons.check,
            iconColor: t.colorScheme.primary,
            bgColor: t.colorScheme.primaryContainer.withValues(alpha: 0.3),
            borderColor: t.colorScheme.primary.withValues(alpha: 0.2),
            lines: [
              "import 'package:apliarte_glass_theme/...';",
              '', 'AppBar(title: ...); // glass', 'Card(child: ...);   // glass',
            ],
          )),
        ]),
        const SizedBox(height: 24),
        Card(child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(children: [
            Icon(Icons.info_outline, color: primary),
            const SizedBox(width: 12),
            const Expanded(child: Text(
              'Para desinstalar: borrá glas_config.dart, sacá el paquete del pubspec, '
              'volvé al import de material.dart. Cero cambios en tu código.',
            )),
          ]),
        )),
        // Share, Support, Footer
        const SizedBox(height: 48), _ShareSection(),
        const SizedBox(height: 48), _SupportSection(),
        const SizedBox(height: 48), _FooterSection(),
        const SizedBox(height: 48),
      ]),
    );
  }

  Widget _badge(String l, Color c) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    decoration: BoxDecoration(
      color: c.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: c.withValues(alpha: 0.3), width: 0.5),
    ),
    child: Text(l, style: TextStyle(color: c, fontSize: 12, fontWeight: FontWeight.w600)),
  );
}

class _MigrateCard extends StatelessWidget {
  final String title; final IconData icon; final Color iconColor, bgColor, borderColor;
  final List<String> lines;
  const _MigrateCard({
    required this.title, required this.icon, required this.iconColor,
    required this.bgColor, required this.borderColor, required this.lines,
  });
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: bgColor, borderRadius: BorderRadius.circular(12),
      border: Border.all(color: borderColor),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Icon(icon, color: iconColor, size: 18),
        const SizedBox(width: 6),
        Text(title, style: TextStyle(fontWeight: FontWeight.w700, color: iconColor)),
      ]),
      const SizedBox(height: 12),
      for (final l in lines) Text(l, style: const TextStyle(
        fontFamily: 'monospace', fontSize: 12, color: Color(0xFFA6E3A1), height: 1.6,
      )),
    ]),
  );
}

// ─────────────────────────────────────────────────────────────
// 1 — APPBAR
// ─────────────────────────────────────────────────────────────

class _AppBarPage extends StatelessWidget {
  const _AppBarPage();
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return _page(context, Section.appbar, [
      _DemoFrame(child: SizedBox(height: 160, child: Column(children: [
        const AppBar(
          title: Text('AppBar de vidrio'),
          actions: [
            IconButton(icon: Icon(Icons.search), onPressed: null),
            IconButton(icon: Icon(Icons.more_vert), onPressed: null),
          ],
        ),
        Expanded(child: Container(
          color: t.scaffoldBackgroundColor,
          child: const Center(child: Text('Contenido debajo del AppBar',
              style: TextStyle(color: Color(0xFF9CA3AF)))),
        )),
      ]))),
      const _CodeCard(lines: [
        "AppBar(",
        "  title: const Text('Título'),",
        "  actions: [IconButton(...)],",
        ")",
      ]),
    ]);
  }
}

// ─────────────────────────────────────────────────────────────
// 2 — CARD
// ─────────────────────────────────────────────────────────────

class _CardPage extends StatelessWidget {
  const _CardPage();
  @override
  Widget build(BuildContext context) => _page(context, Section.card, [
    const Card(child: Padding(padding: EdgeInsets.all(24), child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Card simple', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text('Este card usa efecto glass morphism.'),
    ]))),
    const SizedBox(height: 12),
    const Card(child: Padding(padding: EdgeInsets.all(20), child: Row(children: [
      Icon(Icons.star, color: Colors.amber, size: 40),
      SizedBox(width: 16),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Card con icono', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 4), Text('Row con icono + texto.'),
      ])),
    ]))),
    const _CodeCard(lines: [
      "Card(",
      "  child: Column(children: [",
      "    Text('Título'), Text('Contenido'),",
      "  ]),",
      ")",
    ]),
  ]);
}

// ─────────────────────────────────────────────────────────────
// 3 — NAVBAR PREVIEW (standalone)
// ─────────────────────────────────────────────────────────────

class _NavBarPreviewPage extends StatelessWidget {
  const _NavBarPreviewPage();
  @override
  Widget build(BuildContext context) => _page(context, Section.navPreview, [
    // Preview aislado del NavigationBar glass
    _DemoFrame(child: SizedBox(
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
    )),
    const SizedBox(height: 16),
    Row(children: [
      Expanded(child: _FCard(Icons.gesture, 'Drag lateral')),
      const SizedBox(width: 12),
      Expanded(child: _FCard(Icons.animation, 'Indicador deslizante')),
      const SizedBox(width: 12),
      Expanded(child: _FCard(Icons.palette, 'Color del tema')),
    ]),
    const SizedBox(height: 16),
    Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          Icon(Icons.info, color: primary, size: 20),
          const SizedBox(width: 12),
          const Expanded(child: Text(
            'Este NavigationBar también se usa como navegación principal '
            'de la demo en pantallas pequeñas (< 600px). ¡Mismo componente!',
            style: TextStyle(fontSize: 13),
          )),
        ]),
      ),
    ),
    const _CodeCard(lines: [
      "NavigationBar(",
      "  destinations: [",
      "    NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),",
      "  ],",
      "  selectedIndex: i,",
      "  onDestinationSelected: (i) {},",
      ")",
    ]),
  ]);
}

class _FCard extends StatelessWidget {
  final IconData icon; final String label;
  const _FCard(this.icon, this.label);
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
      Icon(icon, color: primary), const SizedBox(height: 8),
      Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    ])),
  );
}

// ─────────────────────────────────────────────────────────────
// 4 — BOTTOMAPPBAR
// ─────────────────────────────────────────────────────────────

class _BottomAppBarPage extends StatelessWidget {
  const _BottomAppBarPage();
  @override
  Widget build(BuildContext context) => _page(context, Section.bottomAppBar, [
    _DemoFrame(child: const SizedBox(height: 80, child: BottomAppBar(child: Row(children: [
      IconButton(icon: Icon(Icons.menu), onPressed: null),
      Spacer(),
      IconButton(icon: Icon(Icons.search), onPressed: null),
      IconButton(icon: Icon(Icons.add), onPressed: null),
    ])))),
    const _CodeCard(lines: [
      "BottomAppBar(",
      "  child: Row(children: [",
      "    IconButton(icon: Icon(Icons.menu), ...),",
      "    Spacer(),",
      "  ]),",
      ")",
    ]),
  ]);
}

// ─────────────────────────────────────────────────────────────
// 5 — DIALOG
// ─────────────────────────────────────────────────────────────

class _DialogPage extends StatelessWidget {
  const _DialogPage();
  @override
  Widget build(BuildContext context) => _page(context, Section.dialog, [
    Row(children: [
      Expanded(child: _DCard(
        'Diálogo simple',
        false,
        () => showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Diálogo Glass'),
            content: const Text('Misma API que Material 3.\nSe adapta a dark/light.'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
              FilledButton(onPressed: () => Navigator.pop(ctx), child: const Text('Aceptar')),
            ],
          ),
        ),
      )),
      const SizedBox(width: 12),
      Expanded(child: _DCard(
        'Con icono', true,
        () => showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            icon: const Icon(Icons.celebration, size: 40, color: Colors.amber),
            title: const Text('¡Celebración!'),
            content: const Text('Diálogo glass con icono decorativo.'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cerrar')),
            ],
          ),
        ),
      )),
    ]),
    const _CodeCard(lines: [
      "showDialog(context: context,",
      "  builder: (_) => AlertDialog(",
      "    title: Text('Título'),",
      "    content: Text('Mensaje'),",
      "  ),",
      ");",
    ]),
  ]);
}

class _DCard extends StatelessWidget {
  final String title; final bool tonal; final VoidCallback onPressed;
  const _DCard(this.title, this.tonal, this.onPressed);
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      const SizedBox(height: 12),
      SizedBox(
        width: double.infinity,
        child: (tonal ? FilledButton.tonalIcon : FilledButton.icon)(
          icon: const Icon(Icons.open_in_new), label: const Text('Abrir'),
          onPressed: onPressed,
        ),
      ),
    ])),
  );
}

// ─────────────────────────────────────────────────────────────
// 6 — CÓDIGO
// ─────────────────────────────────────────────────────────────

class _CodePage extends StatelessWidget {
  const _CodePage();
  @override
  Widget build(BuildContext context) {
    final d = Theme.of(context).brightness == Brightness.dark;
    return _page(context, Section.code, [
      Container(
        width: double.infinity, padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: d ? const Color(0xFF1A1A2E) : const Color(0xFF1E1E2E),
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
          _CL(''), _CL('void main() => runApp(const MyApp());'),
          _CL(''), _CL('class MyApp extends StatelessWidget {'),
          _CL('  Widget build(BuildContext context) {'),
          _CL('    return MaterialApp('),
          _CL("      title: 'Mi App Glass',"),
          _CL('      home: Scaffold('),
          _CL('        appBar: AppBar(title: Text(\'Inicio\')), // glass'),
          _CL('        body: Card(child: Text(\'Hola glass!\')),  // glass'),
          _CL('        bottomNavigationBar: NavigationBar('),
          _CL("          destinations: const ["),
          _CL("            NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),"),
          _CL('          ], selectedIndex: 0, onDestinationSelected: (_) {},'),
          _CL('        ),'),
          _CL('      ),'),
          _CL('    );'),
          _CL('  }'), _CL('}'),
          _CL(''), _CL('showDialog(context: context, builder: (_) => AlertDialog('),
          _CL("  title: Text('Título'), content: Text('Mensaje'),"), _CL('));'),
        ]),
      ),
      const SizedBox(height: 24),
      SizedBox(
        width: double.infinity,
        child: FilledButton.icon(
          icon: const Icon(Icons.open_in_new), label: const Text('Ver en GitHub'),
          onPressed: () => launchUrl(Uri.parse('https://github.com/erbolamm/apliarte-glass-theme')),
        ),
      ),
    ]);
  }
  Widget _dot(int h) => Container(width: 10, height: 10,
      decoration: BoxDecoration(color: Color(h), shape: BoxShape.circle));
}

Widget _CL(String t) => Text(t, style: const TextStyle(
  fontFamily: 'monospace', fontSize: 12, color: Color(0xFFA6E3A1), height: 1.6,
));

// ─────────────────────────────────────────────────────────────
// SHARE · SUPPORT · FOOTER
// ─────────────────────────────────────────────────────────────

class _ShareSection extends StatelessWidget {
  const _ShareSection();
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Comparte', style: t.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
      const SizedBox(height: 4),
      Text('Si te gusta ApliArte Glass Theme, ayuda a que más gente lo conozca.',
          style: TextStyle(color: t.colorScheme.onSurface.withValues(alpha: 0.5))),
      const SizedBox(height: 24),
      Wrap(spacing: 12, runSpacing: 12, children: [
        const _ShareBtn('𝕏 Twitter',
            'https://twitter.com/intent/tweet?text=$shareText&url=$shareUrl'),
        const _ShareBtn('💼 LinkedIn',
            'https://www.linkedin.com/sharing/share-offsite/?url=$shareUrl'),
        const _ShareBtn('🟠 Reddit',
            'https://www.reddit.com/submit?url=$shareUrl&title=ApliArte%20Glass%20Theme'),
        const _ShareBtn('💬 WhatsApp',
            'https://api.whatsapp.com/send?text=$shareText%20$shareUrl'),
      ]),
    ]);
  }
}

class _ShareBtn extends StatelessWidget {
  final String label, url;
  const _ShareBtn(this.label, this.url);
  @override
  Widget build(BuildContext context) => OutlinedButton.icon(
    icon: const Icon(Icons.open_in_new, size: 16), label: Text(label),
    onPressed: () => launchUrl(Uri.parse(url)),
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      side: BorderSide(color: Theme.of(context).dividerColor),
    ),
  );
}

class _SupportSection extends StatelessWidget {
  const _SupportSection();
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Apoya el proyecto',
          style: t.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
      const SizedBox(height: 4),
      Text('Herramienta gratuita y open source. Si te ahorra tiempo, un café ayuda.',
          style: TextStyle(color: t.colorScheme.onSurface.withValues(alpha: 0.5))),
      const SizedBox(height: 24),
      Wrap(spacing: 12, runSpacing: 12, children: [
        _supportBtn('PayPal', Icons.payment, 'https://paypal.me/erbolamm'),
        _supportBtn('Ko-fi', Icons.coffee, 'https://ko-fi.com/C0C11TWR1K'),
        _supportBtn('Twitch Tip', Icons.live_tv,
            'https://streamelements.com/apliarte/tip'),
      ]),
    ]);
  }
}

Widget _supportBtn(String label, IconData icon, String url) => FilledButton.tonalIcon(
  icon: Icon(icon, size: 18), label: Text(label),
  onPressed: () => launchUrl(Uri.parse(url)),
);

class _FooterSection extends StatelessWidget {
  const _FooterSection();
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Container(
      width: double.infinity, padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: t.colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: [
        Text('v0.2.0  ·  Hecho por Javier Mateo (ApliArte)',
            textAlign: TextAlign.center,
            style: TextStyle(color: t.colorScheme.onSurface.withValues(alpha: 0.6), fontSize: 13)),
        const SizedBox(height: 8),
        Wrap(spacing: 16, runSpacing: 8, alignment: WrapAlignment.center, children: [
          _footerBtn('GitHub', 'https://github.com/erbolamm/apliarte-glass-theme'),
          _footerBtn('pub.dev', 'https://pub.dev/packages/apliarte_glass_theme'),
          _footerBtn('apliarte.com', 'https://apliarte.com'),
          _footerBtn('MIT License',
              'https://github.com/erbolamm/apliarte-glass-theme/blob/main/LICENSE'),
        ]),
      ]),
    );
  }
}

Widget _footerBtn(String label, String url) => TextButton(
  onPressed: () => launchUrl(Uri.parse(url)),
  child: Text(label, style: const TextStyle(fontSize: 13)),
);
