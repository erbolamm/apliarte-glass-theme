import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../glas_config.dart';
import '../helpers/glass_layer.dart';

/// Glass-themed [material.FloatingActionButton].
///
/// Drop-in replacement: same constructor API as Material's FAB.
/// Supports all variants: regular (default), small, large, and extended.
///
/// El efecto glass se aplica sobre el botón completo. El FAB interno
/// se renderiza transparente y el glass layer maneja la apariencia.
class FloatingActionButton extends StatelessWidget {
  final Widget? child;
  final Widget? icon;
  final Widget? label;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final String? tooltip;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final double? elevation;
  final double? focusElevation;
  final double? hoverElevation;
  final double? highlightElevation;
  final double? disabledElevation;
  final material.EdgeInsetsGeometry? padding;
  final material.ShapeBorder? shape;
  final Clip clipBehavior;
  final material.FocusNode? focusNode;
  final bool? autofocus;
  final bool enableFeedback;

  const FloatingActionButton({
    super.key,
    this.child,
    this.icon,
    this.label,
    this.onPressed,
    this.onLongPress,
    this.tooltip,
    this.foregroundColor,
    this.backgroundColor,
    this.elevation,
    this.focusElevation,
    this.hoverElevation,
    this.highlightElevation,
    this.disabledElevation,
    this.padding,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus,
    this.enableFeedback = true,
  }) : _variant = _FabVariant.regular;

  /// Small FAB (40×40).
  const FloatingActionButton.small({
    super.key,
    this.child,
    this.icon,
    this.label,
    this.onPressed,
    this.onLongPress,
    this.tooltip,
    this.foregroundColor,
    this.backgroundColor,
    this.elevation,
    this.focusElevation,
    this.hoverElevation,
    this.highlightElevation,
    this.disabledElevation,
    this.padding,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus,
    this.enableFeedback = true,
  }) : _variant = _FabVariant.small;

  /// Large FAB (96×96).
  const FloatingActionButton.large({
    super.key,
    this.child,
    this.icon,
    this.label,
    this.onPressed,
    this.onLongPress,
    this.tooltip,
    this.foregroundColor,
    this.backgroundColor,
    this.elevation,
    this.focusElevation,
    this.hoverElevation,
    this.highlightElevation,
    this.disabledElevation,
    this.padding,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus,
    this.enableFeedback = true,
  }) : _variant = _FabVariant.large;

  /// Extended FAB with label (and optional icon).
  const FloatingActionButton.extended({
    super.key,
    this.icon,
    this.label,
    this.child,
    this.onPressed,
    this.onLongPress,
    this.tooltip,
    this.foregroundColor,
    this.backgroundColor,
    this.elevation,
    this.focusElevation,
    this.hoverElevation,
    this.highlightElevation,
    this.disabledElevation,
    this.padding,
    this.shape,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus,
    this.enableFeedback = true,
  }) : _variant = _FabVariant.extended;

  final _FabVariant _variant;

  double get _size {
    switch (_variant) {
      case _FabVariant.small:
        return 40.0;
      case _FabVariant.large:
        return 96.0;
      case _FabVariant.regular:
      case _FabVariant.extended:
        return 56.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = material.Theme.of(context);
    final effectiveForeground =
        foregroundColor ?? theme.colorScheme.onPrimaryContainer;
    final size = _size;
    final effectiveElevation = elevation ?? 6.0;

    Widget fabBody;

    if (_variant == _FabVariant.extended) {
      fabBody = material.Container(
        padding: padding ??
            const material.EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: material.Row(
          mainAxisSize: material.MainAxisSize.min,
          children: [
            if (icon != null)
              material.IconTheme(
                data: material.IconThemeData(
                    color: effectiveForeground, size: 18),
                child: icon!,
              ),
            if (icon != null && label != null)
              const material.SizedBox(width: 8),
            if (label != null)
              material.DefaultTextStyle(
                style: theme.textTheme.labelLarge?.copyWith(
                      color: effectiveForeground,
                    ) ??
                    const TextStyle(),
                child: label!,
              ),
            if (child != null) child!,
          ],
        ),
      );
    } else {
      fabBody = material.SizedBox(
        width: size,
        height: size,
        child: material.Center(
          child: icon ?? child ?? const material.SizedBox.shrink(),
        ),
      );
    }

    final radius = _variant == _FabVariant.extended ? 28.0 : size / 2;

    final glassChild = GlassLayer(
      borderRadius: radius,
      showBorder: true,
      customShadows: [
        material.BoxShadow(
          color: GlasConfig.shadowColor(context),
          blurRadius: effectiveElevation * 4,
          offset: material.Offset(0, effectiveElevation * 0.5),
          spreadRadius: -2,
        ),
      ],
      child: fabBody,
    );

    final wrapped = material.Material(
      color: material.Colors.transparent,
      borderRadius: material.BorderRadius.circular(radius),
      clipBehavior: material.Clip.antiAlias,
      child: material.InkWell(
        onTap: onPressed,
        onLongPress: onLongPress,
        focusNode: focusNode,
        autofocus: autofocus ?? false,
        enableFeedback: enableFeedback,
        child: glassChild,
      ),
    );

    if (tooltip != null) {
      return material.Tooltip(message: tooltip!, child: wrapped);
    }

    return wrapped;
  }
}

enum _FabVariant { regular, small, large, extended }
