import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../glas_config.dart';
import '../helpers/glass_layer.dart';
import '../helpers/liquid_highlight.dart';

/// Glass-themed [material.NavigationBar] (Material 3).
///
/// Drop-in replacement: same constructor API as Material's NavigationBar.
/// Includes a glass sliding indicator with smooth drag interaction.
/// Colors are derived from the current theme — no external setup needed.
class NavigationBar extends StatefulWidget {
  final List<material.NavigationDestination> destinations;
  final int selectedIndex;
  final material.ValueChanged<int> onDestinationSelected;
  final Color? backgroundColor;
  final double? elevation;
  final Color? indicatorColor;
  final material.ShapeBorder? indicatorShape;
  final material.NavigationDestinationLabelBehavior? labelBehavior;
  final double? height;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final Duration? animationDuration;
  final material.EdgeInsetsGeometry? padding;
  final material.EdgeInsetsGeometry? labelPadding;
  final material.WidgetStateProperty<Color?>? overlayColor;

  const NavigationBar({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.backgroundColor,
    this.elevation,
    this.indicatorColor,
    this.indicatorShape,
    this.labelBehavior,
    this.height,
    this.shadowColor,
    this.surfaceTintColor,
    this.animationDuration,
    this.padding,
    this.labelPadding,
    this.overlayColor,
  }) : assert(destinations.length >= 2);

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  double? _dragAlignment;
  bool _isDragging = false;
  int? _highlightedIndex;

  double get _navHeight => widget.height ?? 64;
  double get _radius => GlasConfig.mediumRadiusValue();
  int get _lastIndex => widget.destinations.length - 1;

  double _getAlignment(int index) {
    if (_lastIndex == 0) return 0.0;
    return -1.0 + (index * 2 / _lastIndex);
  }

  void _updateHighlightedIndex() {
    if (!_isDragging || _dragAlignment == null) {
      _highlightedIndex = null;
      return;
    }
    final normalized = (_dragAlignment! + 1) / 2;
    final index = (normalized * _lastIndex).round();
    _highlightedIndex = index.clamp(0, _lastIndex);
  }

  @override
  Widget build(BuildContext context) {
    final theme = material.Theme.of(context);
    final indicatorColor =
        widget.indicatorColor ??
        GlasConfig.navigationIndicatorColor ??
        theme.colorScheme.primary;
    final itemCount = widget.destinations.length;

    return material.Padding(
      padding: const material.EdgeInsets.fromLTRB(20, 12, 20, 32),
      child: GlassLayer(
        borderRadius: _radius,
        child: material.LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth / itemCount;
            final totalDragWidth = constraints.maxWidth - itemWidth;

            return material.GestureDetector(
              onHorizontalDragStart: (_) {
                setState(() {
                  _isDragging = true;
                  _dragAlignment = _getAlignment(widget.selectedIndex);
                  _updateHighlightedIndex();
                });
              },
              onHorizontalDragUpdate: (details) {
                if (!_isDragging) return;
                setState(() {
                  final delta =
                      (details.primaryDelta! / totalDragWidth) * 2.0;
                  _dragAlignment =
                      (_dragAlignment! + delta).clamp(-1.0, 1.0);
                  _updateHighlightedIndex();
                });
              },
              onHorizontalDragEnd: (_) {
                setState(() {
                  _isDragging = false;
                  _highlightedIndex = null;
                  final normalized = (_dragAlignment! + 1) / 2;
                  final nearestIndex = (normalized * _lastIndex).round();
                  widget.onDestinationSelected(nearestIndex);
                });
              },
              onHorizontalDragCancel: () {
                setState(() {
                  _isDragging = false;
                  _highlightedIndex = null;
                });
              },
              child: material.SizedBox(
                height: _navHeight,
                child: material.Stack(
                  alignment: material.Alignment.center,
                  children: [
                    // Sliding indicator
                    material.AnimatedAlign(
                      duration: _isDragging
                          ? Duration.zero
                          : (widget.animationDuration ??
                              const Duration(milliseconds: 250)),
                      curve: material.Curves.easeOutQuad,
                      alignment: material.Alignment(
                        _isDragging
                            ? _dragAlignment!
                            : _getAlignment(widget.selectedIndex),
                        0,
                      ),
                      child: material.Container(
                        width: itemWidth,
                        height: _navHeight - 14,
                        decoration: LiquidHighlightDecoration(
                          color: indicatorColor,
                          intensity: LiquidIntensity.strong,
                          borderRadius: material.BorderRadius.circular(30),
                          customOpacity:
                              GlasConfig.liquidHighlightOpacity ??
                              (GlasConfig.liquidHighlightEnabled
                                  ? GlasConfig.liquidHighlightIntensity
                                  : 0),
                        ).build(),
                      ),
                    ),
                    // Destinations
                    material.Row(
                      mainAxisAlignment:
                          material.MainAxisAlignment.spaceBetween,
                      children: [
                        for (int i = 0; i < itemCount; i++)
                          _NavDestinationWidget(
                            destination: widget.destinations[i],
                            isSelected: widget.selectedIndex == i,
                            isHighlighted: _highlightedIndex == i,
                            onTap: () =>
                                widget.onDestinationSelected(i),
                            indicatorColor: indicatorColor,
                            labelBehavior: widget.labelBehavior,
                            labelPadding: widget.labelPadding,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _NavDestinationWidget extends StatelessWidget {
  final material.NavigationDestination destination;
  final bool isSelected;
  final bool isHighlighted;
  final material.VoidCallback onTap;
  final Color indicatorColor;
  final material.NavigationDestinationLabelBehavior? labelBehavior;
  final material.EdgeInsetsGeometry? labelPadding;

  const _NavDestinationWidget({
    required this.destination,
    required this.isSelected,
    required this.isHighlighted,
    required this.onTap,
    required this.indicatorColor,
    this.labelBehavior,
    this.labelPadding,
  });

  bool _showLabel(material.NavigationDestinationLabelBehavior? behavior) {
    switch (behavior) {
      case material.NavigationDestinationLabelBehavior.onlyShowSelected:
        return isSelected;
      case material.NavigationDestinationLabelBehavior.alwaysShow:
        return true;
      case material.NavigationDestinationLabelBehavior.alwaysHide:
        return false;
      default:
        return isSelected;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isActive = isSelected || isHighlighted;
    final iconColor = isActive
        ? indicatorColor
        : material.Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5);

    return material.Expanded(
      child: material.GestureDetector(
        onTap: onTap,
        behavior: material.HitTestBehavior.opaque,
        child: material.Padding(
          padding: labelPadding ??
              const material.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: material.Column(
            mainAxisSize: material.MainAxisSize.min,
            children: [
              material.AnimatedScale(
                scale: isSelected ? 1.15 : 1.0,
                duration: const Duration(milliseconds: 500),
                curve: material.Curves.elasticOut,
                child: material.IconTheme(
                  data: material.IconThemeData(
                    color: iconColor,
                    size: 24,
                  ),
                  child: destination.icon,
                ),
              ),
              if (_showLabel(labelBehavior))
                material.Padding(
                  padding: const material.EdgeInsets.only(top: 2),
                  child: material.DefaultTextStyle(
                    style: material.TextStyle(
                      fontSize: 10,
                      fontWeight: material.FontWeight.w500,
                      color: iconColor,
                    ),
                    child: Text(destination.label,
                        textAlign: material.TextAlign.center),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
