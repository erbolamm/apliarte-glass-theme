// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../glas_config.dart';
import '../helpers/glass_layer.dart';

/// Glass-themed [material.ElevatedButton].
///
/// Drop-in replacement: same constructor API as Material's ElevatedButton.
/// Wraps the original in [GlassLayer] for a frosted glass effect.
///
/// The internal Material button uses a transparent background so the
/// glass effect shows through. Elevation and interaction states are
/// preserved.
class ElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final material.ButtonStyle? style;
  final material.FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final material.MaterialStatesController? statesController;
  final Widget child;

  const ElevatedButton({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.statesController,
    required this.child,
  });

  /// Create an elevated button from a pair of widgets that serve as the
  /// button's [icon] and [label].
  ///
  /// If [icon] is null, creates a regular [ElevatedButton] with [label]
  /// as the child.
  factory ElevatedButton.icon({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    material.ButtonStyle? style,
    material.FocusNode? focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
    material.MaterialStatesController? statesController,
    Widget? icon,
    required Widget label,
    material.IconAlignment? iconAlignment,
  }) {
    if (icon == null) {
      return ElevatedButton(
        key: key,
        onPressed: onPressed,
        onLongPress: onLongPress,
        onHover: onHover,
        onFocusChange: onFocusChange,
        style: style,
        focusNode: focusNode,
        autofocus: autofocus,
        clipBehavior: clipBehavior,
        statesController: statesController,
        child: label,
      );
    }

    final effectiveStyle = (style ?? const material.ButtonStyle()).copyWith(
      iconAlignment: iconAlignment,
    );

    return ElevatedButton(
      key: key,
      onPressed: onPressed,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      style: effectiveStyle,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      statesController: statesController,
      child: _IconLabel(icon: icon, label: label),
    );
  }

  /// A static convenience method that constructs an elevated button
  /// [material.ButtonStyle] given simple values.
  ///
  /// Delegates to [material.ElevatedButton.styleFrom].
  static material.ButtonStyle styleFrom({
    Color? foregroundColor,
    Color? backgroundColor,
    Color? disabledForegroundColor,
    Color? disabledBackgroundColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    Color? iconColor,
    double? iconSize,
    material.IconAlignment? iconAlignment,
    Color? disabledIconColor,
    Color? overlayColor,
    double? elevation,
    material.TextStyle? textStyle,
    material.EdgeInsetsGeometry? padding,
    material.Size? minimumSize,
    material.Size? fixedSize,
    material.Size? maximumSize,
    material.BorderSide? side,
    material.OutlinedBorder? shape,
    material.MouseCursor? enabledMouseCursor,
    material.MouseCursor? disabledMouseCursor,
    material.VisualDensity? visualDensity,
    material.MaterialTapTargetSize? tapTargetSize,
    Duration? animationDuration,
    bool? enableFeedback,
    material.AlignmentGeometry? alignment,
    material.InteractiveInkFeatureFactory? splashFactory,
    material.ButtonLayerBuilder? backgroundBuilder,
    material.ButtonLayerBuilder? foregroundBuilder,
  }) {
    return material.ElevatedButton.styleFrom(
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      disabledForegroundColor: disabledForegroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      iconColor: iconColor,
      iconSize: iconSize,
      iconAlignment: iconAlignment,
      disabledIconColor: disabledIconColor,
      overlayColor: overlayColor,
      elevation: elevation,
      textStyle: textStyle,
      padding: padding,
      minimumSize: minimumSize,
      fixedSize: fixedSize,
      maximumSize: maximumSize,
      side: side,
      shape: shape,
      enabledMouseCursor: enabledMouseCursor,
      disabledMouseCursor: disabledMouseCursor,
      visualDensity: visualDensity,
      tapTargetSize: tapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
      alignment: alignment,
      splashFactory: splashFactory,
      backgroundBuilder: backgroundBuilder,
      foregroundBuilder: foregroundBuilder,
    );
  }

  @override
  Widget build(BuildContext context) {
    final radius = GlasConfig.mediumRadiusValue();

    return GlassLayer(
      borderRadius: radius,
      showBorder: false,
      child: material.ElevatedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        onHover: onHover,
        onFocusChange: onFocusChange,
        style: _effectiveStyle(context),
        focusNode: focusNode,
        autofocus: autofocus,
        clipBehavior: clipBehavior,
        statesController: statesController,
        child: child,
      ),
    );
  }

  material.ButtonStyle _effectiveStyle(BuildContext context) {
    final glassBg = GlasConfig.glassColor(context);
    final baseStyle = material.ElevatedButton.styleFrom(
      backgroundColor: material.Colors.transparent,
      foregroundColor:
          material.Theme.of(context).colorScheme.onPrimaryContainer,
      shadowColor: material.Colors.transparent,
      surfaceTintColor: material.Colors.transparent,
      elevation: 0,
    ).copyWith(
      // Override the internal Material color so glass shows through
      backgroundColor: material.WidgetStatePropertyAll(glassBg),
    );

    if (style != null) {
      return baseStyle.merge(style);
    }
    return baseStyle;
  }
}

/// Internal helper that mirrors Material's icon+label button layout.
class _IconLabel extends StatelessWidget {
  const _IconLabel({required this.icon, required this.label});
  final Widget icon;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        const SizedBox(width: 8),
        Flexible(child: label),
      ],
    );
  }
}
