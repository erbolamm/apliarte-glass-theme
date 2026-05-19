// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../glas_config.dart';
import '../helpers/glass_layer.dart';

/// Glass-themed [material.OutlinedButton].
///
/// Drop-in replacement: same constructor API as Material's OutlinedButton.
/// Wraps the original in [GlassLayer] with a visible glass border.
///
/// The internal Material button uses a transparent background. The glass
/// border replaces the standard Material outline.
class OutlinedButton extends StatelessWidget {
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

  const OutlinedButton({
    super.key,
    this.onPressed,
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

  /// Create an outlined button from a pair of widgets that serve as the
  /// button's [icon] and [label].
  ///
  /// If [icon] is null, creates a regular [OutlinedButton] with [label]
  /// as the child.
  factory OutlinedButton.icon({
    Key? key,
    VoidCallback? onPressed,
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
      return OutlinedButton(
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

    return OutlinedButton(
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

  /// A static convenience method that constructs an outlined button
  /// [material.ButtonStyle] given simple values.
  ///
  /// Delegates to [material.OutlinedButton.styleFrom].
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
    return material.OutlinedButton.styleFrom(
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

    final baseStyle = material.OutlinedButton.styleFrom(
      backgroundColor:
          GlasConfig.glassColor(context).withValues(alpha: 0.3),
      foregroundColor:
          material.Theme.of(context).colorScheme.onSurface,
      shadowColor: material.Colors.transparent,
      surfaceTintColor: material.Colors.transparent,
      elevation: 0,
      side: material.BorderSide(
        color: GlasConfig.borderColor(context),
        width: 1.5,
      ),
    );

    final merged = style != null ? baseStyle.merge(style) : baseStyle;

    return GlassLayer(
      borderRadius: radius,
      showBorder: true,
      child: material.OutlinedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        onHover: onHover,
        onFocusChange: onFocusChange,
        style: merged,
        focusNode: focusNode,
        autofocus: autofocus,
        clipBehavior: clipBehavior,
        statesController: statesController,
        child: child,
      ),
    );
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
