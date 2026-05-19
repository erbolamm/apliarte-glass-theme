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
    final code = _isGlass
        ? 'import \'package:apliarte_glass_theme/apliarte_glass_theme.dart\';'
        : 'import \'package:flutter/material.dart\';';
    return material.Container(
      width: double.infinity,
      padding: const material.EdgeInsets.all(12),
      decoration: material.BoxDecoration(
        color: material.Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: material.BorderRadius.circular(8),
      ),
      child: material.Text(code, style: const material.TextStyle(fontFamily: 'monospace', fontSize: 12)),
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
            // Header
            material.Text(
              _isGlass ? 'Glass Mode' : 'Material Mode',
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: material.FontWeight.bold),
            ),
            const material.SizedBox(height: 4),
            material.Text(
              'Same API, one toggle.',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
            ),
            const material.SizedBox(height: 8),
            _codeBlock(),
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

      // Toggle FAB
      floatingActionButton: _isGlass
          ? FloatingActionButton.extended(
              heroTag: 'toggle',
              onPressed: () => setState(() => _isGlass = false),
              icon: const material.Icon(material.Icons.swap_horiz),
              label: const Text('Material'),
            )
          : material.FloatingActionButton.extended(
              heroTag: 'toggle',
              onPressed: () => setState(() => _isGlass = true),
              icon: const material.Icon(material.Icons.swap_horiz),
              label: const material.Text('Glass'),
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
