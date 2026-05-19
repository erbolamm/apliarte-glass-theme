import 'package:flutter/material.dart' as material;
import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';

void main() => runApp(const GlassToggleDemo());

// ── App ──────────────────────────────────────────────

class GlassToggleDemo extends StatelessWidget {
  const GlassToggleDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return material.MaterialApp(
      title: 'ApliArte Glass — Toggle Demo',
      debugShowCheckedModeBanner: false,
      theme: material.ThemeData(
        useMaterial3: true,
        colorScheme: material.ColorScheme.fromSeed(
          seedColor: const material.Color(0xFF005FA9),
        ),
      ),
      home: const ToggleHome(),
    );
  }
}

// ── Home — Adaptive showroom ─────────────────────────

class ToggleHome extends StatefulWidget {
  const ToggleHome({super.key});

  @override
  State<ToggleHome> createState() => _ToggleHomeState();
}

class _ToggleHomeState extends State<ToggleHome> {
  bool _isGlass = false;

  // ── Widget switchers ──────────────────────────

  material.PreferredSizeWidget _appBar() {
    final title = _isGlass ? '🧊 Glass Mode' : '📄 Material Mode';
    return _isGlass
        ? AppBar(
            title: Text(title),
            actions: [
              IconButton(icon: const material.Icon(material.Icons.info_outline), onPressed: _showDialog),
            ],
          )
        : material.AppBar(
            title: material.Text(title),
            actions: [
              material.IconButton(icon: const material.Icon(material.Icons.info_outline), onPressed: _showDialog),
            ],
          );
  }

  Widget _actionButtons() {
    return material.Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _isGlass
            ? ElevatedButton.icon(
                onPressed: _showSnackBar,
                icon: const material.Icon(material.Icons.notifications),
                label: const Text('SnackBar'),
              )
            : material.ElevatedButton.icon(
                onPressed: _showSnackBar,
                icon: const material.Icon(material.Icons.notifications),
                label: const material.Text('SnackBar'),
              ),
        _isGlass
            ? TextButton(
                onPressed: _showDialog,
                child: const Text('Dialog'),
              )
            : material.TextButton(
                onPressed: _showDialog,
                child: const material.Text('Dialog'),
              ),
        _isGlass
            ? OutlinedButton.icon(
                onPressed: null,
                icon: const material.Icon(material.Icons.block),
                label: const Text('Disabled'),
              )
            : material.OutlinedButton.icon(
                onPressed: null,
                icon: const material.Icon(material.Icons.block),
                label: const material.Text('Disabled'),
              ),
      ],
    );
  }

  Widget _card() {
    return _isGlass
        ? Card(
            child: Padding(
              padding: const material.EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: material.CrossAxisAlignment.start,
                mainAxisSize: material.MainAxisSize.min,
                children: [
                  Text('Card', style: material.Theme.of(context).textTheme.titleMedium),
                  const material.SizedBox(height: 8),
                  const Text('This Card uses GlassLayer for a frosted effect.'),
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
                  material.Text('Card', style: material.Theme.of(context).textTheme.titleMedium),
                  const material.SizedBox(height: 8),
                  const material.Text('Standard Material Card.'),
                ],
              ),
            ),
          );
  }

  Widget _listTile() {
    return _isGlass
        ? ListTile(
            leading: const material.Icon(material.Icons.star),
            title: const Text('ListTile'),
            subtitle: const Text('With frosted glass background'),
            trailing: Switch(value: _isGlass, onChanged: (_) {}),
          )
        : material.ListTile(
            leading: const material.Icon(material.Icons.star),
            title: const material.Text('ListTile'),
            subtitle: const material.Text('Standard Material'),
            trailing: material.Switch(value: _isGlass, onChanged: (_) {}),
          );
  }

  Widget _slider() {
    return _isGlass
        ? Slider(value: 50, onChanged: (_) {})
        : material.Slider(value: 50, onChanged: (_) {});
  }

  Widget _codeBlock() {
    final code = 'import \'package:apliarte_glass_theme/apliarte_glass_theme.dart\';';
    final codeMaterial = 'import \'package:flutter/material.dart\';';
    return material.Container(
      width: double.infinity,
      padding: const material.EdgeInsets.all(10),
      decoration: material.BoxDecoration(
        color: material.Colors.black.withValues(alpha: 0.2),
        borderRadius: material.BorderRadius.circular(8),
      ),
      child: material.Column(
        crossAxisAlignment: material.CrossAxisAlignment.start,
        children: [
          material.Text(
            _isGlass ? code : codeMaterial,
            style: material.TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: _isGlass ? material.Colors.greenAccent : material.Colors.white70,
            ),
          ),
          const material.SizedBox(height: 2),
          material.Text(
            _isGlass ? '// Glass is ACTIVE' : '// Glass is OFF',
            style: material.TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: material.Colors.white.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  // ── Callbacks ──────────────────────────────────

  void _showSnackBar() {
    final msg = _isGlass ? '🧊 Glass SnackBar' : '📄 Material SnackBar';
    material.ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), behavior: material.SnackBarBehavior.floating),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(_isGlass ? '🧊 Glass AlertDialog' : '📄 Material AlertDialog'),
        content: Text(_isGlass
            ? 'This dialog has a frosted glass effect.'
            : 'Standard Material dialog.'),
        actions: [
          TextButton(
            onPressed: () => material.Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // ── Hero toggle ───────────────────────────────

  Widget _buildHeroToggle(material.ThemeData theme) {
    return material.Container(
      width: double.infinity,
      padding: const material.EdgeInsets.all(20),
      decoration: material.BoxDecoration(
        gradient: material.LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withValues(alpha: 0.7),
          ],
        ),
        borderRadius: material.BorderRadius.circular(16),
      ),
      child: material.Column(
        children: [
          material.Text(
            'ApliArte Glass Theme',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: material.Colors.white,
              fontWeight: material.FontWeight.bold,
            ),
          ),
          const material.SizedBox(height: 4),
          material.Text(
            'Same API. One import. All glass.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: material.Colors.white.withValues(alpha: 0.85),
            ),
          ),
          const material.SizedBox(height: 20),
          // Toggle row
          material.Row(
            mainAxisAlignment: material.MainAxisAlignment.center,
            children: [
              material.Text(
                'MATERIAL',
                style: material.TextStyle(
                  color: _isGlass
                      ? material.Colors.white.withValues(alpha: 0.5)
                      : material.Colors.white,
                  fontWeight: _isGlass
                      ? material.FontWeight.normal
                      : material.FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const material.SizedBox(width: 12),
              material.GestureDetector(
                onTap: () => setState(() => _isGlass = !_isGlass),
                child: material.AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 64,
                  height: 32,
                  decoration: material.BoxDecoration(
                    borderRadius: material.BorderRadius.circular(16),
                    color: _isGlass
                        ? material.Colors.white
                        : material.Colors.white.withValues(alpha: 0.3),
                    border: material.Border.all(
                      color: material.Colors.white.withValues(alpha: 0.5),
                      width: 2,
                    ),
                  ),
                  alignment: _isGlass
                      ? material.Alignment.centerRight
                      : material.Alignment.centerLeft,
                  padding: const material.EdgeInsets.symmetric(horizontal: 4),
                  child: material.Container(
                    width: 22,
                    height: 22,
                    decoration: const material.BoxDecoration(
                      shape: material.BoxShape.circle,
                      color: material.Color(0xFF005FA9),
                    ),
                  ),
                ),
              ),
              const material.SizedBox(width: 12),
              material.Text(
                'GLASS',
                style: material.TextStyle(
                  color: _isGlass
                      ? material.Colors.white
                      : material.Colors.white.withValues(alpha: 0.5),
                  fontWeight: _isGlass
                      ? material.FontWeight.bold
                      : material.FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const material.SizedBox(height: 16),
          _codeBlock(),
        ],
      ),
    );
  }

  // ── Build ──────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final theme = material.Theme.of(context);
    final isDark = theme.brightness == material.Brightness.dark;

    return material.Scaffold(
      backgroundColor: isDark ? const material.Color(0xFF0F0F1A) : const material.Color(0xFFF5F5F7),
      appBar: _appBar(),
      body: material.SingleChildScrollView(
        padding: const material.EdgeInsets.all(16),
        child: material.Column(
          crossAxisAlignment: material.CrossAxisAlignment.start,
          children: [
            // ── Hero toggle section ──
            _buildHeroToggle(theme),
            const material.SizedBox(height: 24),

            // Action buttons
            _actionButtons(),
            const material.SizedBox(height: 24),

            // Card
            _card(),
            const material.SizedBox(height: 16),

            // ListTile
            _listTile(),
            const material.SizedBox(height: 16),

            // Slider
            material.Text('Slider', style: theme.textTheme.titleSmall),
            _slider(),
            const material.SizedBox(height: 80),
          ],
        ),
      ),

      // Toggle FAB (quick-access)
      floatingActionButton: FloatingActionButton(
        heroTag: 'toggle',
        onPressed: () => setState(() => _isGlass = !_isGlass),
        child: material.Icon(
          _isGlass ? material.Icons.auto_awesome : material.Icons.auto_awesome_outlined,
        ),
      ),

      // Bottom nav
      bottomNavigationBar: _isGlass
          ? NavigationBar(
              selectedIndex: 0,
              onDestinationSelected: (_) {},
              destinations: const [
                material.NavigationDestination(icon: material.Icon(material.Icons.home), label: 'Home'),
                material.NavigationDestination(icon: material.Icon(material.Icons.search), label: 'Search'),
                material.NavigationDestination(icon: material.Icon(material.Icons.settings), label: 'Settings'),
              ],
            )
          : material.NavigationBar(
              selectedIndex: 0,
              onDestinationSelected: (_) {},
              destinations: const [
                material.NavigationDestination(icon: material.Icon(material.Icons.home), label: 'Home'),
                material.NavigationDestination(icon: material.Icon(material.Icons.search), label: 'Search'),
                material.NavigationDestination(icon: material.Icon(material.Icons.settings), label: 'Settings'),
              ],
            ),
    );
  }
}
