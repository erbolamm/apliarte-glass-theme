// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../glas_config.dart';
import '../helpers/glass_layer.dart';
import '../helpers/press_feedback.dart';

/// Glass-themed [material.IconButton].
///
/// Drop-in replacement: same constructor API as Material's IconButton.
/// Wraps the original in [GlassLayer] for a frosted glass effect.
///
/// All 4 variants are supported:
/// - [IconButton] (standard)
/// - [IconButton.filled]
/// - [IconButton.filledTonal]
/// - [IconButton.outlined]
class IconButton extends StatelessWidget {
  final double? iconSize;
  final material.VisualDensity? visualDensity;
  final material.EdgeInsetsGeometry? padding;
  final material.AlignmentGeometry? alignment;
  final double? splashRadius;
  final Color? color;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? highlightColor;
  final Color? splashColor;
  final Color? disabledColor;
  final VoidCallback? onPressed;
  final ValueChanged<bool>? onHover;
  final VoidCallback? onLongPress;
  final material.MouseCursor? mouseCursor;
  final material.FocusNode? focusNode;
  final bool autofocus;
  final String? tooltip;
  final bool? enableFeedback;
  final material.BoxConstraints? constraints;
  final material.ButtonStyle? style;
  final bool? isSelected;
  final Widget? selectedIcon;
  final material.MaterialStatesController? statesController;
  final Widget icon;

  final _IconButtonVariant _variant;

  /// Creates a standard icon button (Material 3 default).
  const IconButton({
    super.key,
    this.iconSize,
    this.visualDensity,
    this.padding,
    this.alignment,
    this.splashRadius,
    this.color,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.disabledColor,
    required this.onPressed,
    this.onHover,
    this.onLongPress,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.enableFeedback,
    this.constraints,
    this.style,
    this.isSelected,
    this.selectedIcon,
    this.statesController,
    required this.icon,
  }) : _variant = _IconButtonVariant.standard;

  /// Creates a filled icon button (high visual impact).
  const IconButton.filled({
    super.key,
    this.iconSize,
    this.visualDensity,
    this.padding,
    this.alignment,
    this.splashRadius,
    this.color,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.disabledColor,
    required this.onPressed,
    this.onHover,
    this.onLongPress,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.enableFeedback,
    this.constraints,
    this.style,
    this.isSelected,
    this.selectedIcon,
    this.statesController,
    required this.icon,
  }) : _variant = _IconButtonVariant.filled;

  /// Creates a filled tonal icon button (medium emphasis).
  const IconButton.filledTonal({
    super.key,
    this.iconSize,
    this.visualDensity,
    this.padding,
    this.alignment,
    this.splashRadius,
    this.color,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.disabledColor,
    required this.onPressed,
    this.onHover,
    this.onLongPress,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.enableFeedback,
    this.constraints,
    this.style,
    this.isSelected,
    this.selectedIcon,
    this.statesController,
    required this.icon,
  }) : _variant = _IconButtonVariant.filledTonal;

  /// Creates an outlined icon button (medium emphasis with border).
  const IconButton.outlined({
    super.key,
    this.iconSize,
    this.visualDensity,
    this.padding,
    this.alignment,
    this.splashRadius,
    this.color,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.disabledColor,
    required this.onPressed,
    this.onHover,
    this.onLongPress,
    this.mouseCursor,
    this.focusNode,
    this.autofocus = false,
    this.tooltip,
    this.enableFeedback,
    this.constraints,
    this.style,
    this.isSelected,
    this.selectedIcon,
    this.statesController,
    required this.icon,
  }) : _variant = _IconButtonVariant.outlined;

  /// A static convenience method that constructs an icon button
  /// [material.ButtonStyle] given simple values.
  ///
  /// Delegates to [material.IconButton.styleFrom].
  static material.ButtonStyle styleFrom({
    Color? foregroundColor,
    Color? backgroundColor,
    Color? disabledForegroundColor,
    Color? disabledBackgroundColor,
    Color? focusColor,
    Color? hoverColor,
    Color? highlightColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    Color? overlayColor,
    double? elevation,
    material.Size? minimumSize,
    material.Size? fixedSize,
    material.Size? maximumSize,
    double? iconSize,
    material.BorderSide? side,
    material.OutlinedBorder? shape,
    material.EdgeInsetsGeometry? padding,
    material.MouseCursor? enabledMouseCursor,
    material.MouseCursor? disabledMouseCursor,
    material.VisualDensity? visualDensity,
    material.MaterialTapTargetSize? tapTargetSize,
    Duration? animationDuration,
    bool? enableFeedback,
    material.AlignmentGeometry? alignment,
    material.InteractiveInkFeatureFactory? splashFactory,
  }) {
    return material.IconButton.styleFrom(
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      disabledForegroundColor: disabledForegroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      overlayColor: overlayColor,
      elevation: elevation,
      minimumSize: minimumSize,
      fixedSize: fixedSize,
      maximumSize: maximumSize,
      iconSize: iconSize,
      side: side,
      shape: shape,
      padding: padding,
      enabledMouseCursor: enabledMouseCursor,
      disabledMouseCursor: disabledMouseCursor,
      visualDensity: visualDensity,
      tapTargetSize: tapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
      alignment: alignment,
      splashFactory: splashFactory,
    );
  }

  @override
  Widget build(BuildContext context) {
    final radius = GlasConfig.mediumRadiusValue();
    final isEnabled = onPressed != null || onLongPress != null;
    final button = GlassLayer(
      borderRadius: radius,
      showBorder: _variant == _IconButtonVariant.outlined,
      child: _buildMaterialButton(context, statesController),
    );

    if (!GlasConfig.buttonPressFeedbackEnabled) {
      return button;
    }

    return buildButtonPressFeedback(
      statesController: statesController,
      enabled: isEnabled,
      pressedScale: GlasConfig.buttonPressScaleValue(),
      builder: (effectiveStatesController) {
        return GlassLayer(
          borderRadius: radius,
          showBorder: _variant == _IconButtonVariant.outlined,
          child: Listener(
            onPointerDown: isEnabled
                ? (_) => effectiveStatesController.update(
                    material.WidgetState.pressed,
                    true,
                  )
                : null,
            onPointerUp: isEnabled
                ? (_) => effectiveStatesController.update(
                    material.WidgetState.pressed,
                    false,
                  )
                : null,
            onPointerCancel: isEnabled
                ? (_) => effectiveStatesController.update(
                    material.WidgetState.pressed,
                    false,
                  )
                : null,
            child: _buildMaterialButton(context, effectiveStatesController),
          ),
        );
      },
    );
  }

  Widget _buildMaterialButton(
    BuildContext context,
    material.MaterialStatesController? effectiveStatesController,
  ) {
    final glassBg = GlasConfig.glassColor(context);
    final effectiveStyle = _effectiveStyle(context, glassBg);

    // Create the base Material IconButton params structure
    final baseParams = _BaseParams(
      iconSize: iconSize,
      visualDensity: visualDensity,
      padding: padding,
      alignment: alignment,
      splashRadius: splashRadius,
      color: color,
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
      disabledColor: disabledColor,
      onPressed: onPressed,
      onHover: onHover,
      onLongPress: onLongPress,
      mouseCursor: mouseCursor,
      focusNode: focusNode,
      autofocus: autofocus,
      tooltip: tooltip,
      enableFeedback: enableFeedback,
      constraints: constraints,
      style: effectiveStyle,
      isSelected: isSelected,
      selectedIcon: selectedIcon,
      statesController: effectiveStatesController,
      icon: icon,
    );

    switch (_variant) {
      case _IconButtonVariant.standard:
        return material.IconButton(
          key: key,
          iconSize: baseParams.iconSize,
          visualDensity: baseParams.visualDensity,
          padding: baseParams.padding,
          alignment: baseParams.alignment,
          splashRadius: baseParams.splashRadius,
          color: baseParams.color,
          focusColor: baseParams.focusColor,
          hoverColor: baseParams.hoverColor,
          highlightColor: baseParams.highlightColor,
          splashColor: baseParams.splashColor,
          disabledColor: baseParams.disabledColor,
          onPressed: baseParams.onPressed,
          onHover: baseParams.onHover,
          onLongPress: baseParams.onLongPress,
          mouseCursor: baseParams.mouseCursor,
          focusNode: baseParams.focusNode,
          autofocus: baseParams.autofocus,
          tooltip: baseParams.tooltip,
          enableFeedback: baseParams.enableFeedback,
          constraints: baseParams.constraints,
          style: baseParams.style,
          isSelected: baseParams.isSelected,
          selectedIcon: baseParams.selectedIcon,
          statesController: baseParams.statesController,
          icon: baseParams.icon,
        );

      case _IconButtonVariant.filled:
        return material.IconButton.filled(
          key: key,
          iconSize: baseParams.iconSize,
          visualDensity: baseParams.visualDensity,
          padding: baseParams.padding,
          alignment: baseParams.alignment,
          splashRadius: baseParams.splashRadius,
          color: baseParams.color,
          focusColor: baseParams.focusColor,
          hoverColor: baseParams.hoverColor,
          highlightColor: baseParams.highlightColor,
          splashColor: baseParams.splashColor,
          disabledColor: baseParams.disabledColor,
          onPressed: baseParams.onPressed,
          onHover: baseParams.onHover,
          onLongPress: baseParams.onLongPress,
          mouseCursor: baseParams.mouseCursor,
          focusNode: baseParams.focusNode,
          autofocus: baseParams.autofocus,
          tooltip: baseParams.tooltip,
          enableFeedback: baseParams.enableFeedback,
          constraints: baseParams.constraints,
          style: baseParams.style,
          isSelected: baseParams.isSelected,
          selectedIcon: baseParams.selectedIcon,
          statesController: baseParams.statesController,
          icon: baseParams.icon,
        );

      case _IconButtonVariant.filledTonal:
        return material.IconButton.filledTonal(
          key: key,
          iconSize: baseParams.iconSize,
          visualDensity: baseParams.visualDensity,
          padding: baseParams.padding,
          alignment: baseParams.alignment,
          splashRadius: baseParams.splashRadius,
          color: baseParams.color,
          focusColor: baseParams.focusColor,
          hoverColor: baseParams.hoverColor,
          highlightColor: baseParams.highlightColor,
          splashColor: baseParams.splashColor,
          disabledColor: baseParams.disabledColor,
          onPressed: baseParams.onPressed,
          onHover: baseParams.onHover,
          onLongPress: baseParams.onLongPress,
          mouseCursor: baseParams.mouseCursor,
          focusNode: baseParams.focusNode,
          autofocus: baseParams.autofocus,
          tooltip: baseParams.tooltip,
          enableFeedback: baseParams.enableFeedback,
          constraints: baseParams.constraints,
          style: baseParams.style,
          isSelected: baseParams.isSelected,
          selectedIcon: baseParams.selectedIcon,
          statesController: baseParams.statesController,
          icon: baseParams.icon,
        );

      case _IconButtonVariant.outlined:
        return material.IconButton.outlined(
          key: key,
          iconSize: baseParams.iconSize,
          visualDensity: baseParams.visualDensity,
          padding: baseParams.padding,
          alignment: baseParams.alignment,
          splashRadius: baseParams.splashRadius,
          color: baseParams.color,
          focusColor: baseParams.focusColor,
          hoverColor: baseParams.hoverColor,
          highlightColor: baseParams.highlightColor,
          splashColor: baseParams.splashColor,
          disabledColor: baseParams.disabledColor,
          onPressed: baseParams.onPressed,
          onHover: baseParams.onHover,
          onLongPress: baseParams.onLongPress,
          mouseCursor: baseParams.mouseCursor,
          focusNode: baseParams.focusNode,
          autofocus: baseParams.autofocus,
          tooltip: baseParams.tooltip,
          enableFeedback: baseParams.enableFeedback,
          constraints: baseParams.constraints,
          style: baseParams.style,
          isSelected: baseParams.isSelected,
          selectedIcon: baseParams.selectedIcon,
          statesController: baseParams.statesController,
          icon: baseParams.icon,
        );
    }
  }

  material.ButtonStyle _effectiveStyle(BuildContext context, Color glassBg) {
    final baseStyle = switch (_variant) {
      _IconButtonVariant.standard ||
      _IconButtonVariant.outlined => material.ButtonStyle(
        backgroundColor: material.WidgetStatePropertyAll(glassBg),
        shadowColor: const material.WidgetStatePropertyAll(
          material.Colors.transparent,
        ),
        surfaceTintColor: const material.WidgetStatePropertyAll(
          material.Colors.transparent,
        ),
        elevation: const material.WidgetStatePropertyAll(0),
      ),
      _IconButtonVariant.filled ||
      _IconButtonVariant.filledTonal => material.ButtonStyle(
        shadowColor: const material.WidgetStatePropertyAll(
          material.Colors.transparent,
        ),
        surfaceTintColor: const material.WidgetStatePropertyAll(
          material.Colors.transparent,
        ),
        elevation: const material.WidgetStatePropertyAll(0),
      ),
    };

    if (style != null) {
      return baseStyle.merge(style);
    }
    return baseStyle;
  }
}

// ── Private helpers ────────────────────────────────────────

enum _IconButtonVariant { standard, filled, filledTonal, outlined }

/// Holds all constructor parameters so we can pass them to the
/// correct Material IconButton constructor without repetition.
class _BaseParams {
  const _BaseParams({
    required this.iconSize,
    required this.visualDensity,
    required this.padding,
    required this.alignment,
    required this.splashRadius,
    required this.color,
    required this.focusColor,
    required this.hoverColor,
    required this.highlightColor,
    required this.splashColor,
    required this.disabledColor,
    required this.onPressed,
    required this.onHover,
    required this.onLongPress,
    required this.mouseCursor,
    required this.focusNode,
    required this.autofocus,
    required this.tooltip,
    required this.enableFeedback,
    required this.constraints,
    required this.style,
    required this.isSelected,
    required this.selectedIcon,
    required this.statesController,
    required this.icon,
  });

  final double? iconSize;
  final material.VisualDensity? visualDensity;
  final material.EdgeInsetsGeometry? padding;
  final material.AlignmentGeometry? alignment;
  final double? splashRadius;
  final Color? color;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? highlightColor;
  final Color? splashColor;
  final Color? disabledColor;
  final VoidCallback? onPressed;
  final ValueChanged<bool>? onHover;
  final VoidCallback? onLongPress;
  final material.MouseCursor? mouseCursor;
  final material.FocusNode? focusNode;
  final bool autofocus;
  final String? tooltip;
  final bool? enableFeedback;
  final material.BoxConstraints? constraints;
  final material.ButtonStyle? style;
  final bool? isSelected;
  final Widget? selectedIcon;
  final material.MaterialStatesController? statesController;
  final Widget icon;
}
