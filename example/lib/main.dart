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
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: ThemeMode.system,
      home: const ShowcaseHome(),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF005FA9),
        brightness: brightness,
      ),
      textTheme: GoogleFonts.interTextTheme(
        brightness == Brightness.dark ? ThemeData.dark().textTheme : null,
      ),
      scaffoldBackgroundColor: isDark ? const Color(0xFF0F0F1A) : const Color(0xFFF8F9FC),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// CONSTANTS
// ═══════════════════════════════════════════════════════════

class AppColors {
  static const primary = Color(0xFF005FA9);
  static const primaryDark = Color(0xFF00467B);
  static const accent = Color(0xFFE8955E);
  static const success = Color(0xFF22C55E);
  static const warning = Color(0xFFF59E0B);
}

// ═══════════════════════════════════════════════════════════
// MAIN SHOWCASE
// ═══════════════════════════════════════════════════════════

class ShowcaseHome extends StatefulWidget {
  const ShowcaseHome({super.key});

  @override
  State<ShowcaseHome> createState() => _ShowcaseHomeState();
}

class _ShowcaseHomeState extends State<ShowcaseHome> {
  int _selectedIndex = 0;
  bool _useRail = true;

  final _sections = <_Section>[
    _Section('Inicio', Icons.home_rounded, 'Vista general'),
    _Section('AppBar', Icons.vertical_align_top_rounded, 'Toolbar de vidrio'),
    _Section('Card', Icons.credit_card_rounded, 'Frosted glass cards'),
    _Section('NavBar', Icons.explore_rounded, 'Navegación inferior'),
    _Section('BottomAppBar', Icons.keyboard_arrow_up_rounded, 'Barra inferior'),
    _Section('Dialog', Icons.chat_rounded, 'Diálogos modales'),
    _Section('Código', Icons.code_rounded, 'Ejemplo completo'),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateLayout(MediaQuery.of(context).size.width);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    _updateLayout(width);

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            // NavigationRail — visible en pantallas ≥ 720px
            if (_useRail)
              NavigationRail(
                selectedIndex: _selectedIndex,
                onDestinationSelected: (i) => setState(() => _selectedIndex = i),
                labelType: width < 900
                    ? NavigationRailLabelType.selected
                    : NavigationRailLabelType.all,
                leading: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Icon(Icons.blur_on, color: AppColors.primary, size: 28),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _ThemeToggle(
                    onChanged: () => setState(() {}),
                  ),
                ),
                groupAlignment: 0.0,
                destinations: [
                  for (final s in _sections)
                    NavigationRailDestination(
                      icon: Icon(s.icon),
                      label: Text(s.label),
                    ),
                ],
              ),
            if (_useRail)
              const VerticalDivider(thickness: 1, width: 1),
            // Main content
            Expanded(
              child: _buildPage(),
            ),
          ],
        ),
      ),
      // Bottom nav para móvil
      bottomNavigationBar: _useRail
          ? null
          : NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (i) => setState(() => _selectedIndex = i),
              destinations: [
                for (final s in _sections)
                  NavigationDestination(icon: Icon(s.icon), label: s.label),
              ],
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            ),
    );
  }

  void _updateLayout(double width) {
    final shouldUseRail = width >= 720;
    if (shouldUseRail != _useRail) {
      // Use WidgetsBinding to avoid setState during build
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _useRail = shouldUseRail);
      });
    }
  }

  Widget _buildPage() {
    switch (_selectedIndex) {
      case 0: return const _OverviewPage();
      case 1: return const _AppBarPage();
      case 2: return const _CardPage();
      case 3: return const _NavBarPage();
      case 4: return const _BottomAppBarPage();
      case 5: return const _DialogPage();
      case 6: return const _CodePage();
      default: return const _OverviewPage();
    }
  }
}

class _Section {
  final String label;
  final IconData icon;
  final String subtitle;
  const _Section(this.label, this.icon, this.subtitle);
}

// ═══════════════════════════════════════════════════════════
// THEME TOGGLE
// ═══════════════════════════════════════════════════════════

class _ThemeToggle extends StatelessWidget {
  final VoidCallback onChanged;
  const _ThemeToggle({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return IconButton(
      icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
      tooltip: isDark ? 'Modo claro' : 'Modo oscuro',
      onPressed: () {
        final mode = isDark ? ThemeMode.light : ThemeMode.dark;
        _rebuildApp(context, mode);
        onChanged();
      },
    );
  }

  void _rebuildApp(BuildContext context, ThemeMode mode) {
    final app = MaterialApp(
      title: 'ApliArte Glass Theme',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.interTextTheme(),
        scaffoldBackgroundColor: const Color(0xFFF8F9FC),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        scaffoldBackgroundColor: const Color(0xFF0F0F1A),
      ),
      themeMode: mode,
      home: const ShowcaseHome(),
    );
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => app,
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// PAGE WRAPPER
// ═══════════════════════════════════════════════════════════

class _PageWrapper extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget child;
  const _PageWrapper({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: theme.colorScheme.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      )),
                  Text(subtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                      )),
                ],
              ),
            ],
          ),
          const SizedBox(height: 28),
          child,
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// CODE CARD
// ═══════════════════════════════════════════════════════════

class _CodeCard extends StatelessWidget {
  final List<String> lines;
  const _CodeCard({required this.lines});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? const Color(0xFF1A1A2E)
            : const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10, height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF5F57),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 10, height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFFFEBC2E),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 10, height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFF28C840),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Text('code.dart',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.4),
                    fontSize: 12,
                  )),
            ],
          ),
          const SizedBox(height: 16),
          for (final line in lines)
            Text(
              line,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 13,
                color: Color(0xFFA6E3A1),
                height: 1.6,
              ),
            ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// 0 — OVERVIEW / HERO
// ═══════════════════════════════════════════════════════════

class _OverviewPage extends StatelessWidget {
  const _OverviewPage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero gradient
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [const Color(0xFF001F3F), const Color(0xFF0F0F1A)]
                    : [AppColors.primary, AppColors.primaryDark, const Color(0xFF1A1A2E)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Icon(Icons.blur_on, size: 56, color: Colors.white.withValues(alpha: 0.9)),
                const SizedBox(height: 16),
                const Text(
                  'ApliArte Glass Theme',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Drop-in replacement de Material 3 con efecto glass morphism',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    _HeroBadge('v0.2.0', AppColors.success),
                    _HeroBadge('Drop-in', const Color(0xFF6366F1)),
                    _HeroBadge('Material 3', AppColors.warning),
                    _HeroBadge('Dark/Light', const Color(0xFF8B5CF6)),
                    _HeroBadge('MIT', const Color(0xFFEC4899)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Quick start
          Text('Cómo empezar',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text('Un solo cambio y toda tu app se vuelve vidrio.',
              style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.5))),
          const SizedBox(height: 16),

          // Two columns
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Before
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.errorContainer.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: theme.colorScheme.error.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.close, color: theme.colorScheme.error, size: 18),
                          const SizedBox(width: 6),
                          Text('Antes (Material)',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: theme.colorScheme.error,
                              )),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _CodeLine(r"import 'package:flutter/material.dart';"),
                      _CodeLine(''),
                      _CodeLine('AppBar(title: ...);'),
                      _CodeLine('Card(child: ...);'),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // After
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: theme.colorScheme.primary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check, color: theme.colorScheme.primary, size: 18),
                          const SizedBox(width: 6),
                          Text('Ahora (Glass)',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: theme.colorScheme.primary,
                              )),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _CodeLine(r"import 'package:apliarte_glass_theme/...';"),
                      _CodeLine(''),
                      _CodeLine('AppBar(title: ...); // glass ✨'),
                      _CodeLine('Card(child: ...);   // glass ✨'),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Component grid
          Text('Componentes disponibles',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.3,
            children: [
              _ComponentCard(Icons.vertical_align_top, 'AppBar', 'Toolbar de vidrio'),
              _ComponentCard(Icons.credit_card, 'Card', 'Frosted glass'),
              _ComponentCard(Icons.explore, 'NavigationBar', 'Nav inferior'),
              _ComponentCard(Icons.keyboard_arrow_up, 'BottomAppBar', 'Barra inferior'),
              _ComponentCard(Icons.chat, 'AlertDialog', 'Diálogo modal'),
              _ComponentCard(Icons.more_horiz, '+ más', 'Pronto'),
            ],
          ),

          const SizedBox(height: 32),

          // Migrate section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.primary),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Para desinstalar: borrá glas_config.dart, sacá el paquete del pubspec, '
                      'volvé al import de material.dart. Cero cambios en tu código.',
                    ),
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

class _HeroBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _HeroBadge(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
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
}

class _CodeLine extends StatelessWidget {
  final String text;
  const _CodeLine(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: Color(0xFFA6E3A1),
          height: 1.6,
        ));
  }
}

class _ComponentCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const _ComponentCard(this.icon, this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.primary, size: 28),
          const SizedBox(height: 8),
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
          const SizedBox(height: 2),
          Text(subtitle,
              style: TextStyle(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                fontSize: 11,
              )),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// 1 — APPBAR
// ═══════════════════════════════════════════════════════════

class _AppBarPage extends StatelessWidget {
  const _AppBarPage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _PageWrapper(
      title: 'AppBar',
      subtitle: 'Toolbar con efecto glass. Misma API que Material 3.',
      icon: Icons.vertical_align_top,
      child: Column(
        children: [
          // Demo
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.dividerColor),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 160,
                child: Column(
                  children: [
                    const AppBar(
                      title: Text('Título glass'),
                      actions: [
                        IconButton(icon: Icon(Icons.search), onPressed: null),
                        IconButton(icon: Icon(Icons.more_vert), onPressed: null),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        color: theme.scaffoldBackgroundColor,
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
          const SizedBox(height: 16),
          // Code
          const _CodeCard(lines: [
            "AppBar(",
            "  title: const Text('Título'),",
            "  actions: [",
            "    IconButton(icon: Icon(Icons.search), ...),",
            "  ],",
            ")",
            "",
            "// Con TabBar:",
            "AppBar(",
            "  title: const Text('Tabs'),",
            "  bottom: TabBar(tabs: [...]),",
            ")",
          ]),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// 2 — CARD
// ═══════════════════════════════════════════════════════════

class _CardPage extends StatelessWidget {
  const _CardPage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _PageWrapper(
      title: 'Card',
      subtitle: 'Cards con frosted glass. Se adaptan a cualquier contenido.',
      icon: Icons.credit_card,
      child: Column(
        children: [
          // Simple
          const Card(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Card simple',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Este card usa efecto glass morphism. '
                      'El fondo se ve a través del vidrio.'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Row
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
          const SizedBox(height: 12),
          // With header
          Card(
            child: Column(
              children: [
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary.withValues(alpha: 0.1),
                        theme.colorScheme.primary.withValues(alpha: 0.02),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Icon(Icons.image, size: 32, color: theme.colorScheme.primary),
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
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// 3 — NAVIGATIONBAR
// ═══════════════════════════════════════════════════════════

class _NavBarPage extends StatelessWidget {
  const _NavBarPage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _PageWrapper(
      title: 'NavigationBar',
      subtitle: 'Bottom nav con vidrio + indicador deslizante + drag lateral.',
      icon: Icons.explore,
      child: Column(
        children: [
          // Live preview
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.dividerColor),
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
                  selectedIndex: 1,
                  onDestinationSelected: (_) {},
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Features
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(Icons.gesture, color: AppColors.primary),
                        const SizedBox(height: 8),
                        const Text('Drag lateral',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(Icons.animation, color: AppColors.primary),
                        const SizedBox(height: 8),
                        const Text('Indicador animado',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(Icons.palette, color: AppColors.primary),
                        const SizedBox(height: 8),
                        const Text('Color del tema',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Code
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
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// 4 — BOTTOMAPPBAR
// ═══════════════════════════════════════════════════════════

class _BottomAppBarPage extends StatelessWidget {
  const _BottomAppBarPage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _PageWrapper(
      title: 'BottomAppBar',
      subtitle: 'Barra inferior de vidrio. Ideal con FAB.',
      icon: Icons.keyboard_arrow_up,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.dividerColor),
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
            "",
            "// Combiná con FAB:",
            "Scaffold(",
            "  floatingActionButton: FloatingActionButton(",
            "    child: Icon(Icons.add),",
            "  ),",
            "  bottomNavigationBar: BottomAppBar(...),",
            ")",
          ]),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// 5 — ALERTDIALOG
// ═══════════════════════════════════════════════════════════

class _DialogPage extends StatelessWidget {
  const _DialogPage();

  @override
  Widget build(BuildContext context) {
    return _PageWrapper(
      title: 'AlertDialog',
      subtitle: 'Diálogos modales de vidrio. Misma API que Material.',
      icon: Icons.chat,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
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
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const _CodeCard(lines: [
            "showDialog(",
            "  context: context,",
            "  builder: (_) => AlertDialog(",
            "    title: const Text('Título'),",
            "    content: const Text('Mensaje'),",
            "    actions: [",
            "      TextButton(child: Text('Cerrar'), ...),",
            "    ],",
            "  ),",
            ");",
          ]),
        ],
      ),
    );
  }

  void _showSimple(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Diálogo Glass'),
        content: const Text(
          'Misma API que Material 3.\nSe adapta a dark/light automáticamente.',
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

  void _showWithIcon(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.celebration, size: 40, color: Colors.amber),
        title: const Text('¡Celebración!'),
        content: const Text('Diálogo glass con icono decorativo arriba.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// 6 — CÓDIGO COMPLETO
// ═══════════════════════════════════════════════════════════

class _CodePage extends StatelessWidget {
  const _CodePage();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _PageWrapper(
      title: 'Código completo',
      subtitle: 'Ejemplo funcional de todos los componentes glass.',
      icon: Icons.code,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.brightness == Brightness.dark
                  ? const Color(0xFF1A1A2E)
                  : const Color(0xFF1E1E2E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(width: 10, height: 10,
                        decoration: const BoxDecoration(color: Color(0xFFFF5F57), shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Container(width: 10, height: 10,
                        decoration: const BoxDecoration(color: Color(0xFFFEBC2E), shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    Container(width: 10, height: 10,
                        decoration: const BoxDecoration(color: Color(0xFF28C840), shape: BoxShape.circle)),
                    const SizedBox(width: 12),
                    Text('main.dart',
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 16),
                _CodeLine(r"import 'package:flutter/material.dart' hide AppBar, Card, NavigationBar, BottomAppBar, AlertDialog;"),
                _CodeLine(r"import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';"),
                _CodeLine(''),
                _CodeLine('void main() => runApp(const MyApp());'),
                _CodeLine(''),
                _CodeLine('class MyApp extends StatelessWidget {'),
                _CodeLine('  @override'),
                _CodeLine('  Widget build(BuildContext context) {'),
                _CodeLine('    return MaterialApp('),
                _CodeLine("      title: 'Mi App Glass',"),
                _CodeLine('      home: Scaffold('),
                _CodeLine('        // 🪟 AppBar de vidrio'),
                _CodeLine("        appBar: AppBar("),
                _CodeLine("          title: const Text('Inicio'),"),
                _CodeLine('        ),'),
                _CodeLine('        // 🪟 Card de vidrio'),
                _CodeLine('        body: Card('),
                _CodeLine('          child: Padding('),
                _CodeLine("            padding: EdgeInsets.all(24),"),
                _CodeLine("            child: Text('Hola mundo glass!'),"),
                _CodeLine('          ),'),
                _CodeLine('        ),'),
                _CodeLine('        // 🪟 NavBar de vidrio'),
                _CodeLine('        bottomNavigationBar: NavigationBar('),
                _CodeLine('          destinations: const ['),
                _CodeLine("            NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),"),
                _CodeLine("            NavigationDestination(icon: Icon(Icons.person), label: 'Perfil'),"),
                _CodeLine('          ],'),
                _CodeLine('          selectedIndex: 0,'),
                _CodeLine('          onDestinationSelected: (_) {},'),
                _CodeLine('        ),'),
                _CodeLine('      ),'),
                _CodeLine('    );'),
                _CodeLine('  }'),
                _CodeLine('}'),
                _CodeLine(''),
                _CodeLine('// Para diálogos:'),
                _CodeLine("showDialog("),
                _CodeLine('  context: context,'),
                _CodeLine('  builder: (_) => AlertDialog('),
                _CodeLine("    title: const Text('Título'),"),
                _CodeLine("    content: const Text('Mensaje'),"),
                _CodeLine('    actions: [TextButton(child: Text("OK"), ...)],'),
                _CodeLine('  ),'),
                _CodeLine(');'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // CTA
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              icon: const Icon(Icons.open_in_new),
              label: const Text('Ver en GitHub'),
              onPressed: () => launchUrl(
                Uri.parse('https://github.com/erbolamm/apliarte-glass-theme'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
