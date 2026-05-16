import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../glas_config.dart';
import '../helpers/glass_layer.dart';

/// Glass-themed [material.Drawer].
///
/// Drop-in replacement: same constructor API as Material's Drawer.
/// Applies a frosted glass effect to the entire drawer surface.
class Drawer extends StatelessWidget {
  final Widget? child;
  final Color? backgroundColor;
  final double? elevation;
  final material.ShapeBorder? shape;
  final Clip clipBehavior;
  final String? semanticLabel;
  final double? width;
  final Color? shadowColor;
  final Color? surfaceTintColor;

  const Drawer({
    super.key,
    this.child,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.clipBehavior = Clip.antiAlias,
    this.semanticLabel,
    this.width,
    this.shadowColor,
    this.surfaceTintColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveWidth = width ?? 304.0;
    final radius = GlasConfig.mediumRadiusValue();
    final effectiveElevation = elevation ?? 16.0;

    final drawerContent = GlassLayer(
      borderRadius: 0, // Drawer covers full height, no internal rounding
      showBorder: false,
      child: material.SizedBox(
        width: effectiveWidth,
        child: material.Column(
          crossAxisAlignment: material.CrossAxisAlignment.stretch,
          children: [
            // Header area with glass branding
            _DrawerHeader(context),
            // Divider
            material.Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: material.Theme.of(context)
                  .colorScheme
                  .outlineVariant
                  .withValues(alpha: 0.3),
            ),
            // Scrollable content
            material.Expanded(
              child: child ?? const material.SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );

    // Wrap with elevation shadow and rounded right edge
    return material.Material(
      color: material.Colors.transparent,
      elevation: effectiveElevation,
      shadowColor: shadowColor ?? GlasConfig.shadowColor(context),
      borderRadius: material.BorderRadius.horizontal(
        right: material.Radius.circular(radius),
      ),
      clipBehavior: clipBehavior,
      surfaceTintColor: surfaceTintColor,
      child: material.ClipRRect(
        borderRadius: material.BorderRadius.horizontal(
          right: material.Radius.circular(radius),
        ),
        child: drawerContent,
      ),
    );
  }
}

/// Internal header for the glass drawer.
Widget _DrawerHeader(BuildContext context) {
  final theme = material.Theme.of(context);
  return material.Container(
    padding: const material.EdgeInsets.fromLTRB(16, 48, 16, 24),
    child: material.Column(
      crossAxisAlignment: material.CrossAxisAlignment.start,
      children: [
        // Icon
        material.Container(
          width: 48,
          height: 48,
          decoration: material.BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.15),
            borderRadius: material.BorderRadius.circular(14),
          ),
          child: material.Center(
            child: material.Icon(
              material.Icons.blur_on_rounded,
              color: theme.colorScheme.primary,
              size: 28,
            ),
          ),
        ),
        const material.SizedBox(height: 16),
        // Title
        material.Text(
          'ApliArte Glass',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: material.FontWeight.w700,
          ),
        ),
        const material.SizedBox(height: 2),
        material.Text(
          'Material 3 Glass Theme',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
      ],
    ),
  );
}
