import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../glas_config.dart';
import '../helpers/glass_layer.dart';
import '../helpers/press_feedback.dart';

/// Glass-themed [material.FloatingActionButton].
///
/// Drop-in replacement: same constructor API as Material's FAB.
/// Supports all variants: regular (default), small, large, and extended.
///
/// El efecto glass se aplica sobre el botón completo. El FAB interno
/// se renderiza transparente y el glass layer maneja la apariencia.
class FloatingActionButton extends StatefulWidget {
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
  final Object? heroTag;

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
    this.heroTag,
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
    this.heroTag,
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
    this.heroTag,
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
    this.heroTag,
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
  State<FloatingActionButton> createState() => _FloatingActionButtonState();
}

class _FloatingActionButtonState extends State<FloatingActionButton> {
  late final WidgetStatesController _statesController;

  @override
  void initState() {
    super.initState();
    _statesController = WidgetStatesController();
  }

  @override
  void dispose() {
    _statesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = material.Theme.of(context);
    final effectiveForeground =
        widget.foregroundColor ?? theme.colorScheme.onPrimaryContainer;
    final size = widget._size;
    final effectiveElevation = widget.elevation ?? 6.0;
    final isEnabled = widget.onPressed != null || widget.onLongPress != null;

    Widget fabBody;

    if (widget._variant == _FabVariant.extended) {
      fabBody = material.Container(
        padding:
            widget.padding ??
            const material.EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: material.Row(
          mainAxisSize: material.MainAxisSize.min,
          children: [
            if (widget.icon != null)
              material.IconTheme(
                data: material.IconThemeData(
                  color: effectiveForeground,
                  size: 18,
                ),
                child: widget.icon!,
              ),
            if (widget.icon != null && widget.label != null)
              const material.SizedBox(width: 8),
            if (widget.label != null)
              material.DefaultTextStyle(
                style:
                    theme.textTheme.labelLarge?.copyWith(
                      color: effectiveForeground,
                    ) ??
                    const TextStyle(),
                child: widget.label!,
              ),
            if (widget.child != null) widget.child!,
          ],
        ),
      );
    } else {
      fabBody = material.SizedBox(
        width: size,
        height: size,
        child: material.Center(
          child:
              widget.icon ?? widget.child ?? const material.SizedBox.shrink(),
        ),
      );
    }

    final radius = widget._variant == _FabVariant.extended ? 28.0 : size / 2;

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

    final pressFeedbackChild = GlasConfig.buttonPressFeedbackEnabled
        ? buildPressFeedback(
            statesController: _statesController,
            enabled: isEnabled,
            pressedScale: GlasConfig.buttonPressScaleValue(),
            child: glassChild,
          )
        : glassChild;

    final wrapped = material.Material(
      color: material.Colors.transparent,
      borderRadius: material.BorderRadius.circular(radius),
      clipBehavior: material.Clip.antiAlias,
      child: material.InkWell(
        statesController: _statesController,
        onTap: widget.onPressed,
        onLongPress: widget.onLongPress,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus ?? false,
        enableFeedback: widget.enableFeedback,
        child: pressFeedbackChild,
      ),
    );

    Widget result = wrapped;
    if (widget.heroTag != null) {
      result = material.Hero(tag: widget.heroTag!, child: result);
    }
    if (widget.tooltip != null) {
      result = material.Tooltip(message: widget.tooltip!, child: result);
    }
    return result;
  }
}

enum _FabVariant { regular, small, large, extended }
