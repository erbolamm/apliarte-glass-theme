import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../glas_config.dart';
import '../helpers/glass_layer.dart';

/// Glass-themed [material.AlertDialog].
///
/// Drop-in replacement: same constructor API as Material's AlertDialog.
class AlertDialog extends StatelessWidget {
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
  final material.EdgeInsetsGeometry? buttonPadding;
  final Color? backgroundColor;
  final double? elevation;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final Widget? icon;
  final material.EdgeInsetsGeometry? iconPadding;
  final Color? iconColor;
  final material.ShapeBorder? shape;
  final Clip clipBehavior;
  final bool scrollable;
  final String? semanticLabel;

  const AlertDialog({
    super.key,
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
    this.buttonPadding,
    this.backgroundColor,
    this.elevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.icon,
    this.iconPadding,
    this.iconColor,
    this.shape,
    this.clipBehavior = Clip.none,
    this.scrollable = false,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final radius = GlasConfig.largeRadiusValue();
    final effectiveElevation = elevation ?? 8.0;
    final theme = material.Theme.of(context);
    final effectiveTitleStyle =
        titleTextStyle ?? theme.textTheme.headlineSmall;
    final effectiveContentStyle =
        contentTextStyle ?? theme.textTheme.bodyMedium;
    final effectiveShadowColor =
        shadowColor ?? GlasConfig.shadowColor(context);

    return Stack(
      children: [
        // Shadow layer
        if (effectiveElevation > 0)
          Positioned.fill(
            child: material.Material(
              color: material.Colors.transparent,
              elevation: effectiveElevation,
              shadowColor: effectiveShadowColor,
              borderRadius: material.BorderRadius.circular(radius),
              child: const material.SizedBox.expand(),
            ),
          ),
        // Glass layer
        GlassLayer(
          borderRadius: radius,
          child: ClipRRect(
            borderRadius: material.BorderRadius.circular(radius),
            child: material.AlertDialog(
              backgroundColor: material.Colors.transparent,
              elevation: 0,
              shadowColor: material.Colors.transparent,
              surfaceTintColor: material.Colors.transparent,
              shape: material.RoundedRectangleBorder(
                borderRadius: material.BorderRadius.circular(radius),
              ),
              clipBehavior: Clip.hardEdge,
              titlePadding: titlePadding,
              titleTextStyle: effectiveTitleStyle,
              contentPadding: contentPadding,
              contentTextStyle: effectiveContentStyle,
              actionsPadding: actionsPadding,
              actionsAlignment: actionsAlignment,
              actionsOverflowAlignment: actionsOverflowAlignment,
              actionsOverflowDirection: actionsOverflowDirection,
              buttonPadding: buttonPadding,
              scrollable: scrollable,
              semanticLabel: semanticLabel,
              icon: icon,
              iconPadding: iconPadding,
              iconColor: iconColor,
              title: icon != null
                  ? material.Column(
                      mainAxisSize: material.MainAxisSize.min,
                      children: [
                        if (icon != null) icon!,
                        if (title != null) ...[
                          const material.SizedBox(height: 16),
                          title!,
                        ],
                      ],
                    )
                  : title,
              content: content,
              actions: actions,
            ),
          ),
        ),
      ],
    );
  }
}
