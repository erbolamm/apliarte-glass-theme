// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;

import 'package:flutter/material.dart' as material;
import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';
import 'package:apliarte_glass_theme/glass_widgets.dart' as glass;

void main() => runApp(const GlassLanding());

// ── App ──────────────────────────────────────────────

class GlassLanding extends StatelessWidget {
  const GlassLanding({super.key});

  @override
  Widget build(BuildContext context) {
    return material.MaterialApp(
      title: 'ApliArte Glass Theme',
      debugShowCheckedModeBanner: false,
      theme: GlassTheme.light(material.Colors.blue),
      darkTheme: GlassTheme.dark(material.Colors.blue),
      home: const LandingPage(),
    );
  }
}

// ── Constants ────────────────────────────────────────

const _primary = material.Color(0xFF005FA9);
const _githubUrl = 'https://github.com/erbolamm/apliarte-glass-theme';
const _pubUrl = 'https://pub.dev/packages/apliarte_glass_theme';
const _paypalUrl = 'https://www.paypal.com/paypalme/erbolamm';

// ── Landing Page ─────────────────────────────────────

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _glass = false;
  int _selectedSection = 0;
  final _scrollController = material.ScrollController();
  final _sectionKeys = List.generate(4, (_) => material.GlobalKey());

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(int index) {
    setState(() => _selectedSection = index);
    final context = _sectionKeys[index].currentContext;
    if (context == null) return;
    material.Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOutCubic,
    );
  }

  // ── Hero ───────────────────────────────────────

  Widget _hero() {
    return material.Container(
      width: double.infinity,
      padding: const material.EdgeInsets.fromLTRB(24, 48, 24, 32),
      decoration: const material.BoxDecoration(
        gradient: material.LinearGradient(
          begin: material.Alignment.topLeft,
          end: material.Alignment.bottomRight,
          colors: [_primary, material.Color(0xFF003D6B)],
        ),
      ),
      child: material.Column(
        children: [
          // Logo / title
          material.Text(
            'ApliArte\nGlass Theme',
            textAlign: material.TextAlign.center,
            style: material.TextStyle(
              fontSize: 36,
              fontWeight: material.FontWeight.w800,
              color: material.Colors.white,
              height: 1.1,
            ),
          ),
          const material.SizedBox(height: 12),
          material.Text(
            'Material-safe theme. Real glass widgets when you opt in.',
            textAlign: material.TextAlign.center,
            style: material.TextStyle(
              fontSize: 16,
              color: material.Colors.white.withValues(alpha: 0.85),
            ),
          ),
          const material.SizedBox(height: 24),

          // Toggle
          _buildToggle(),
          const material.SizedBox(height: 16),

          // Code
          _codeSnippet(),
        ],
      ),
    );
  }

  Widget _buildToggle() {
    return material.Row(
      mainAxisAlignment: material.MainAxisAlignment.center,
      children: [
        material.Text(
          'MATERIAL',
          style: material.TextStyle(
            fontSize: 13,
            fontWeight: material.FontWeight.w700,
            letterSpacing: 1.2,
            color: _glass
                ? material.Colors.white.withValues(alpha: 0.4)
                : material.Colors.white,
          ),
        ),
        const material.SizedBox(width: 14),
        material.GestureDetector(
          onTap: () => setState(() => _glass = !_glass),
          child: material.AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            width: 60,
            height: 30,
            decoration: material.BoxDecoration(
              borderRadius: material.BorderRadius.circular(15),
              color: _glass
                  ? material.Colors.white
                  : material.Colors.white.withValues(alpha: 0.25),
              border: material.Border.all(
                color: material.Colors.white.withValues(alpha: 0.5),
                width: 2,
              ),
            ),
            alignment: _glass
                ? material.Alignment.centerRight
                : material.Alignment.centerLeft,
            padding: const material.EdgeInsets.symmetric(horizontal: 3),
            child: material.Container(
              width: 22,
              height: 22,
              decoration: const material.BoxDecoration(
                shape: material.BoxShape.circle,
                color: _primary,
              ),
            ),
          ),
        ),
        const material.SizedBox(width: 14),
        material.Text(
          'GLASS',
          style: material.TextStyle(
            fontSize: 13,
            fontWeight: material.FontWeight.w700,
            letterSpacing: 1.2,
            color: _glass
                ? material.Colors.white
                : material.Colors.white.withValues(alpha: 0.4),
          ),
        ),
      ],
    );
  }

  Widget _codeSnippet() {
    final code = _glass
        ? "import 'package:apliarte_glass_theme/glass_widgets.dart' as glass;"
        : "theme: GlassTheme.light(Colors.blue)";
    return material.Container(
      padding: const material.EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: material.BoxDecoration(
        color: material.Colors.black.withValues(alpha: 0.3),
        borderRadius: material.BorderRadius.circular(10),
      ),
      child: material.Text(
        code,
        style: material.TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: _glass ? material.Colors.greenAccent : material.Colors.white70,
        ),
      ),
    );
  }

  // ── Widget Showcase ────────────────────────────

  Widget _showcase() {
    return material.Padding(
      padding: const material.EdgeInsets.symmetric(horizontal: 16),
      child: material.Column(
        crossAxisAlignment: material.CrossAxisAlignment.start,
        children: [
          const material.SizedBox(height: 32),
          _sectionTitle('Widget Showcase'),
          const material.SizedBox(height: 16),

          // Row 1: Elevated + Outlined + Text
          _widgetCard('ElevatedButton', _elevatedDemo()),
          _widgetCard('OutlinedButton', _outlinedDemo()),
          _widgetCard('TextButton', _textDemo()),

          // Row 2: IconButtons
          _widgetCard('IconButton', _iconButtons()),
          _widgetCard('Card', _cardDemo()),
          _widgetCard('Slider', _sliderDemo()),

          // Row 3: ListTile + Switch
          _widgetCard('ListTile', _listTileDemo()),
          _widgetCard('TextField', _textFieldDemo()),
          _widgetCard('Progress', _progressDemo()),

          // Row 4: Buttons row
          _widgetCard('AlertDialog', _dialogTrigger()),
          _widgetCard('SnackBar', _snackTrigger()),
          _widgetCard('TabBar', _tabBarDemo()),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return material.Text(
      text,
      style: material.TextStyle(
        fontSize: 22,
        fontWeight: material.FontWeight.w700,
        color: material.Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _widgetCard(String label, Widget child) {
    return material.Padding(
      padding: const material.EdgeInsets.only(bottom: 12),
      child: material.Column(
        crossAxisAlignment: material.CrossAxisAlignment.start,
        children: [
          material.Padding(
            padding: const material.EdgeInsets.only(left: 4, bottom: 4),
            child: material.Text(
              label,
              style: material.TextStyle(
                fontSize: 12,
                fontWeight: material.FontWeight.w600,
                color: material.Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }

  // ── Widget demos ───────────────────────────────

  Widget _elevatedDemo() {
    return _glass
        ? glass.ElevatedButton.icon(
            onPressed: () {},
            icon: const material.Icon(material.Icons.star),
            label: const Text('Elevated'),
          )
        : material.ElevatedButton.icon(
            onPressed: () {},
            icon: const material.Icon(material.Icons.star),
            label: const material.Text('Elevated'),
          );
  }

  Widget _outlinedDemo() {
    return _glass
        ? glass.OutlinedButton.icon(
            onPressed: () {},
            icon: const material.Icon(material.Icons.favorite_border),
            label: const Text('Outlined'),
          )
        : material.OutlinedButton.icon(
            onPressed: () {},
            icon: const material.Icon(material.Icons.favorite_border),
            label: const material.Text('Outlined'),
          );
  }

  Widget _textDemo() {
    return _glass
        ? glass.TextButton(onPressed: () {}, child: const Text('Text Button'))
        : material.TextButton(
            onPressed: () {},
            child: const material.Text('Text Button'),
          );
  }

  Widget _iconButtons() {
    return material.Row(
      mainAxisAlignment: material.MainAxisAlignment.spaceEvenly,
      children: [
        _glass
            ? glass.IconButton(
                icon: const material.Icon(material.Icons.thumb_up),
                onPressed: () {},
              )
            : material.IconButton(
                icon: const material.Icon(material.Icons.thumb_up),
                onPressed: () {},
              ),
        _glass
            ? glass.IconButton.filled(
                icon: const material.Icon(material.Icons.favorite),
                onPressed: () {},
              )
            : material.IconButton(
                icon: const material.Icon(material.Icons.favorite),
                onPressed: () {},
              ),
        _glass
            ? glass.IconButton.outlined(
                icon: const material.Icon(material.Icons.share),
                onPressed: () {},
              )
            : material.IconButton(
                icon: const material.Icon(material.Icons.share),
                onPressed: () {},
              ),
      ],
    );
  }

  Widget _cardDemo() {
    return _glass
        ? glass.Card(
            child: material.Padding(
              padding: const material.EdgeInsets.all(16),
              child: material.Column(
                crossAxisAlignment: material.CrossAxisAlignment.start,
                mainAxisSize: material.MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const material.Icon(
                        material.Icons.auto_awesome,
                        size: 20,
                      ),
                      const material.SizedBox(width: 8),
                      const Text('Glass Card'),
                    ],
                  ),
                  const material.SizedBox(height: 8),
                  const Text('Frosted glass effect with blur.'),
                ],
              ),
            ),
          )
        : material.Card(
            child: material.Padding(
              padding: const material.EdgeInsets.all(16),
              child: material.Column(
                crossAxisAlignment: material.CrossAxisAlignment.start,
                mainAxisSize: material.MainAxisSize.min,
                children: [
                  material.Row(
                    children: [
                      const material.Icon(
                        material.Icons.auto_awesome,
                        size: 20,
                      ),
                      const material.SizedBox(width: 8),
                      const material.Text('Material Card'),
                    ],
                  ),
                  const material.SizedBox(height: 8),
                  const material.Text('Standard Material card.'),
                ],
              ),
            ),
          );
  }

  Widget _sliderDemo() {
    return _glass
        ? glass.Slider(value: 60, onChanged: (_) {})
        : material.Slider(value: 60, onChanged: (_) {});
  }

  Widget _listTileDemo() {
    return _glass
        ? glass.ListTile(
            leading: const material.Icon(material.Icons.star),
            title: const Text('ListTile'),
            subtitle: const Text('Glass background'),
            trailing: material.Switch(
              value: _glass,
              activeThumbColor: _primary,
              onChanged: (_) => setState(() => _glass = !_glass),
            ),
          )
        : material.ListTile(
            leading: const material.Icon(material.Icons.star),
            title: const material.Text('ListTile'),
            subtitle: const material.Text('Material background'),
            trailing: material.Switch(
              value: _glass,
              activeThumbColor: _primary,
              onChanged: (_) => setState(() => _glass = !_glass),
            ),
          );
  }

  Widget _textFieldDemo() {
    return _glass
        ? glass.TextField(
            decoration: const material.InputDecoration(
              hintText: 'Glass TextField',
              border: material.OutlineInputBorder(),
            ),
          )
        : material.TextField(
            decoration: const material.InputDecoration(
              hintText: 'Material TextField',
              border: material.OutlineInputBorder(),
            ),
          );
  }

  Widget _progressDemo() {
    return _glass
        ? const glass.CircularProgressIndicator()
        : const material.CircularProgressIndicator();
  }

  Widget _dialogTrigger() {
    return _glass
        ? glass.ElevatedButton.icon(
            onPressed: () => _showDialog(context),
            icon: const material.Icon(material.Icons.chat),
            label: const Text('Open Dialog'),
          )
        : material.ElevatedButton.icon(
            onPressed: () => _showDialog(context),
            icon: const material.Icon(material.Icons.chat),
            label: const material.Text('Open Dialog'),
          );
  }

  void _showDialog(material.BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (_) => _glass
          ? glass.AlertDialog(
              title: const Text('Glass Dialog'),
              content: const Text(
                'This AlertDialog has a frosted glass effect.',
              ),
              actions: [
                glass.TextButton(
                  onPressed: () => material.Navigator.of(ctx).pop(),
                  child: const Text('OK'),
                ),
              ],
            )
          : material.AlertDialog(
              title: const material.Text('Material Dialog'),
              content: const material.Text('Standard Material dialog.'),
              actions: [
                material.TextButton(
                  onPressed: () => material.Navigator.of(ctx).pop(),
                  child: const material.Text('OK'),
                ),
              ],
            ),
    );
  }

  Widget _snackTrigger() {
    return _glass
        ? glass.ElevatedButton.icon(
            onPressed: () {
              material.ScaffoldMessenger.of(context).showSnackBar(
                glass.SnackBar(
                  content: const Text('🧊 Glass SnackBar!'),
                  behavior: material.SnackBarBehavior.floating,
                ),
              );
            },
            icon: const material.Icon(material.Icons.notifications),
            label: const Text('Show SnackBar'),
          )
        : material.ElevatedButton.icon(
            onPressed: () {
              material.ScaffoldMessenger.of(context).showSnackBar(
                const material.SnackBar(
                  content: material.Text('📄 Material SnackBar'),
                  behavior: material.SnackBarBehavior.floating,
                ),
              );
            },
            icon: const material.Icon(material.Icons.notifications),
            label: const material.Text('Show SnackBar'),
          );
  }

  Widget _tabBarDemo() {
    return _glass
        ? SizedBox(
            height: 48,
            child: glass.TabBar(
              tabs: const [
                glass.Tab(text: 'Tab 1'),
                glass.Tab(text: 'Tab 2'),
                glass.Tab(text: 'Tab 3'),
              ],
            ),
          )
        : SizedBox(
            height: 48,
            child: material.TabBar(
              tabs: const [
                material.Tab(text: 'Tab 1'),
                material.Tab(text: 'Tab 2'),
                material.Tab(text: 'Tab 3'),
              ],
            ),
          );
  }

  // ── How to use ──────────────────────────────────

  Widget _howToUse() {
    final theme = material.Theme.of(context);
    return material.Container(
      width: double.infinity,
      padding: const material.EdgeInsets.all(24),
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
      child: material.Column(
        crossAxisAlignment: material.CrossAxisAlignment.start,
        children: [
          _sectionTitle('How to use'),
          const material.SizedBox(height: 16),
          material.Text(
            '1. Add the dependency:',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: material.FontWeight.w600,
            ),
          ),
          const material.SizedBox(height: 8),
          _codeBox('dependencies:\n  apliarte_glass_theme: ^0.7.0'),
          const material.SizedBox(height: 16),
          material.Text(
            '2. Add the safe theme:',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: material.FontWeight.w600,
            ),
          ),
          const material.SizedBox(height: 8),
          _codeBox(
            "import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';\n\nMaterialApp(\n  theme: GlassTheme.light(Colors.blue),\n  darkTheme: GlassTheme.dark(Colors.blue),\n)",
          ),
          const material.SizedBox(height: 16),
          material.Text(
            '3. Opt in to real glass widgets where you want blur:',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: material.FontWeight.w600,
            ),
          ),
          const material.SizedBox(height: 8),
          material.Text(
            'The default entrypoint keeps Material stable. For real blur, import glass_widgets.dart with a prefix and use glass.AppBar, glass.Card, glass.NavigationBar, and friends.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _codeBox(String code) {
    final theme = material.Theme.of(context);
    return material.Container(
      width: double.infinity,
      padding: const material.EdgeInsets.all(16),
      decoration: material.BoxDecoration(
        color: const material.Color(0xFF1A1A2E),
        borderRadius: material.BorderRadius.circular(12),
      ),
      child: material.Text(
        code,
        style: material.TextStyle(
          fontFamily: 'monospace',
          fontSize: 13,
          color: theme.colorScheme.primary.withValues(alpha: 0.9),
          height: 1.5,
        ),
      ),
    );
  }

  // ── Links ───────────────────────────────────────

  Widget _linksSection() {
    return material.Padding(
      padding: const material.EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 32,
      ),
      child: material.Column(
        children: [
          _sectionTitle('Links'),
          const material.SizedBox(height: 16),
          material.Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: material.WrapAlignment.center,
            children: [
              _linkButton(
                icon: material.Icons.code,
                label: 'GitHub',
                url: _githubUrl,
              ),
              _linkButton(
                icon: material.Icons.public,
                label: 'pub.dev',
                url: _pubUrl,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _linkButton({
    required material.IconData icon,
    required String label,
    required String url,
  }) {
    return material.GestureDetector(
      onTap: () => html.window.open(url, '_blank'),
      child: material.Container(
        padding: const material.EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 14,
        ),
        decoration: material.BoxDecoration(
          color: _primary,
          borderRadius: material.BorderRadius.circular(12),
        ),
        child: material.Row(
          mainAxisSize: material.MainAxisSize.min,
          children: [
            material.Icon(icon, color: material.Colors.white, size: 20),
            const material.SizedBox(width: 8),
            material.Text(
              label,
              style: const material.TextStyle(
                color: material.Colors.white,
                fontWeight: material.FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Support ─────────────────────────────────────

  Widget _supportSection() {
    final theme = material.Theme.of(context);
    return material.Container(
      width: double.infinity,
      padding: const material.EdgeInsets.all(32),
      decoration: material.BoxDecoration(
        gradient: material.LinearGradient(
          colors: [
            theme.colorScheme.primaryContainer,
            theme.colorScheme.primaryContainer.withValues(alpha: 0.5),
          ],
        ),
      ),
      child: material.Column(
        children: [
          const material.Icon(
            material.Icons.favorite,
            color: material.Colors.redAccent,
            size: 32,
          ),
          const material.SizedBox(height: 12),
          material.Text(
            'Support this project',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: material.FontWeight.w700,
            ),
          ),
          const material.SizedBox(height: 8),
          material.Text(
            'If ApliArte Glass Theme helps you build beautiful apps,\nconsider supporting its development.',
            textAlign: material.TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const material.SizedBox(height: 20),
          material.GestureDetector(
            onTap: () => html.window.open(_paypalUrl, '_blank'),
            child: material.Container(
              padding: const material.EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 14,
              ),
              decoration: material.BoxDecoration(
                color: const material.Color(0xFF0070BA),
                borderRadius: material.BorderRadius.circular(12),
              ),
              child: material.Row(
                mainAxisSize: material.MainAxisSize.min,
                children: [
                  material.Text(
                    'PayPal',
                    style: material.TextStyle(
                      color: material.Colors.white,
                      fontWeight: material.FontWeight.w700,
                    ),
                  ),
                  const material.SizedBox(width: 6),
                  material.Text(
                    'Donate',
                    style: material.TextStyle(
                      color: material.Colors.lightBlueAccent,
                      fontWeight: material.FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Build ──────────────────────────────────────

  List<material.NavigationRailDestination> get _railDestinations => const [
    material.NavigationRailDestination(
      icon: material.Icon(material.Icons.home_outlined),
      selectedIcon: material.Icon(material.Icons.home),
      label: material.Text('Home'),
    ),
    material.NavigationRailDestination(
      icon: material.Icon(material.Icons.widgets_outlined),
      selectedIcon: material.Icon(material.Icons.widgets),
      label: material.Text('Widgets'),
    ),
    material.NavigationRailDestination(
      icon: material.Icon(material.Icons.integration_instructions_outlined),
      selectedIcon: material.Icon(material.Icons.integration_instructions),
      label: material.Text('Usage'),
    ),
    material.NavigationRailDestination(
      icon: material.Icon(material.Icons.favorite_border),
      selectedIcon: material.Icon(material.Icons.favorite),
      label: material.Text('Support'),
    ),
  ];

  List<material.NavigationDestination> get _barDestinations => const [
    material.NavigationDestination(
      icon: material.Icon(material.Icons.home_outlined),
      selectedIcon: material.Icon(material.Icons.home),
      label: 'Home',
    ),
    material.NavigationDestination(
      icon: material.Icon(material.Icons.widgets_outlined),
      selectedIcon: material.Icon(material.Icons.widgets),
      label: 'Widgets',
    ),
    material.NavigationDestination(
      icon: material.Icon(material.Icons.integration_instructions_outlined),
      selectedIcon: material.Icon(material.Icons.integration_instructions),
      label: 'Usage',
    ),
    material.NavigationDestination(
      icon: material.Icon(material.Icons.favorite_border),
      selectedIcon: material.Icon(material.Icons.favorite),
      label: 'Support',
    ),
  ];

  Widget _pageContent() {
    final theme = material.Theme.of(context);
    return material.SingleChildScrollView(
      controller: _scrollController,
      child: material.Column(
        children: [
          material.KeyedSubtree(key: _sectionKeys[0], child: _hero()),
          material.KeyedSubtree(key: _sectionKeys[1], child: _showcase()),
          const material.SizedBox(height: 24),
          material.KeyedSubtree(key: _sectionKeys[2], child: _howToUse()),
          _linksSection(),
          material.KeyedSubtree(key: _sectionKeys[3], child: _supportSection()),
          const material.SizedBox(height: 24),
          material.Padding(
            padding: const material.EdgeInsets.only(bottom: 32),
            child: material.Text(
              'Made with ❤️ by erbolamm',
              style: material.TextStyle(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _desktopRail() {
    final rail = material.NavigationRail(
      selectedIndex: _selectedSection,
      onDestinationSelected: _scrollToSection,
      labelType: material.NavigationRailLabelType.all,
      leading: material.Padding(
        padding: const material.EdgeInsets.only(top: 16, bottom: 8),
        child: material.IconButton(
          tooltip: _glass ? 'Switch to Material' : 'Switch to Glass',
          onPressed: () => setState(() => _glass = !_glass),
          icon: material.Icon(
            _glass
                ? material.Icons.auto_awesome
                : material.Icons.auto_awesome_outlined,
          ),
        ),
      ),
      destinations: _railDestinations,
    );

    if (!_glass) return rail;

    return material.Padding(
      padding: const material.EdgeInsets.all(12),
      child: glass.Card(child: material.SizedBox(width: 104, child: rail)),
    );
  }

  Widget _bottomBar() {
    if (_glass) {
      return glass.NavigationBar(
        selectedIndex: _selectedSection,
        onDestinationSelected: _scrollToSection,
        destinations: _barDestinations,
      );
    }

    return material.NavigationBar(
      selectedIndex: _selectedSection,
      onDestinationSelected: _scrollToSection,
      destinations: _barDestinations,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = material.Theme.of(context);
    final isDark = theme.brightness == material.Brightness.dark;

    return material.LayoutBuilder(
      builder: (context, constraints) {
        final useRail = constraints.maxWidth >= 900;

        return material.Scaffold(
          backgroundColor: isDark
              ? const material.Color(0xFF0A0A14)
              : const material.Color(0xFFF5F5F7),
          body: useRail
              ? material.Row(
                  children: [
                    _desktopRail(),
                    const material.VerticalDivider(width: 1),
                    material.Expanded(child: _pageContent()),
                  ],
                )
              : _pageContent(),
          floatingActionButton: useRail
              ? null
              : FloatingActionButton(
                  heroTag: 'toggle',
                  onPressed: () => setState(() => _glass = !_glass),
                  child: material.Icon(
                    _glass
                        ? material.Icons.auto_awesome
                        : material.Icons.auto_awesome_outlined,
                  ),
                ),
          bottomNavigationBar: useRail ? null : _bottomBar(),
        );
      },
    );
  }
}
