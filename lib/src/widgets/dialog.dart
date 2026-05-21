import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../glas_config.dart';

/// Opt-in glass-themed [material.AlertDialog].
///
/// This wrapper deliberately delegates to Material's dialog instead of nesting a
/// `Dialog` around an `AlertDialog`. Nested dialogs and full-size stacks change
/// constraints and can make mobile dialogs appear fullscreen.
class AlertDialog extends StatelessWidget {
  final Widget? icon;
  final material.EdgeInsetsGeometry? iconPadding;
  final Color? iconColor;
  final Widget? title;
  final material.EdgeInsetsGeometry? titlePadding;
  final TextStyle? titleTextStyle;
  final Widget? content;
  final material.EdgeInsetsGeometry? contentPadding;
  final TextStyle? contentTextStyle;
  final List<Widget>? actions;
  final material.EdgeInsetsGeometry? actionsPadding;
  final material.MainAxisAlignment? actionsAlignment;
  final material.OverflowBarAlignment? actionsOverflowAlignment;
  final material.VerticalDirection? actionsOverflowDirection;
  final double? actionsOverflowButtonSpacing;
  final material.EdgeInsetsGeometry? buttonPadding;
  final Color? backgroundColor;
  final double? elevation;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final String? semanticLabel;
  final material.EdgeInsets? insetPadding;
  final Clip clipBehavior;
  final material.ShapeBorder? shape;
  final AlignmentGeometry? alignment;
  final BoxConstraints? constraints;
  final bool scrollable;

  const AlertDialog({
    super.key,
    this.icon,
    this.iconPadding,
    this.iconColor,
    this.title,
    this.titlePadding,
    this.titleTextStyle,
    this.content,
    this.contentPadding,
    this.contentTextStyle,
    this.actions,
    this.actionsPadding,
    this.actionsAlignment,
    this.actionsOverflowAlignment,
    this.actionsOverflowDirection,
    this.actionsOverflowButtonSpacing,
    this.buttonPadding,
    this.backgroundColor,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.semanticLabel,
    this.insetPadding,
    this.clipBehavior = Clip.none,
    this.shape,
    this.alignment,
    this.constraints,
    this.scrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    final radius = GlasConfig.largeRadiusValue();
    final effectiveShape = shape ??
        material.RoundedRectangleBorder(
          borderRadius: material.BorderRadius.circular(radius),
        );

    return material.AlertDialog(
      icon: icon,
      iconPadding: iconPadding,
      iconColor: iconColor,
      title: title,
      titlePadding: titlePadding,
      titleTextStyle: titleTextStyle,
      content: content,
      contentPadding: contentPadding,
      contentTextStyle: contentTextStyle,
      actions: actions,
      actionsPadding: actionsPadding,
      actionsAlignment: actionsAlignment,
      actionsOverflowAlignment: actionsOverflowAlignment,
      actionsOverflowDirection: actionsOverflowDirection,
      actionsOverflowButtonSpacing: actionsOverflowButtonSpacing,
      buttonPadding: buttonPadding,
      backgroundColor: backgroundColor ?? GlasConfig.glassColor(context),
      elevation: elevation,
      shadowColor: shadowColor ?? GlasConfig.shadowColor(context),
      surfaceTintColor: surfaceTintColor ?? material.Colors.transparent,
      semanticLabel: semanticLabel,
      insetPadding: insetPadding,
      clipBehavior: clipBehavior,
      shape: effectiveShape,
      alignment: alignment,
      constraints: constraints,
      scrollable: scrollable,
    );
  }
}
