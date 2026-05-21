import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../glas_config.dart';
import '../helpers/glass_layer.dart';

/// Opt-in glass-themed card.
///
/// This widget must stay layout-neutral: no hidden padding and no custom default
/// margin. The caller owns content spacing, just like with Material [material.Card].
class Card extends StatelessWidget {
  final Widget? child;
  final double? elevation;
  final material.ShapeBorder? shape;
  final bool borderOnForeground;
  final Clip clipBehavior;
  final Color? color;
  final material.EdgeInsetsGeometry? margin;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final bool semanticContainer;
  final material.EdgeInsetsGeometry? insetPadding;

  const Card({
    super.key,
    this.child,
    this.elevation,
    this.shape,
    this.borderOnForeground = true,
    this.clipBehavior = Clip.none,
    this.color,
    this.margin,
    this.shadowColor,
    this.surfaceTintColor,
    this.semanticContainer = true,
    this.insetPadding,
  });

  @override
  Widget build(BuildContext context) {
    final radius = GlasConfig.largeRadiusValue();
    final effectiveElevation = elevation ?? 4.0;
    final effectiveShape = shape ??
        material.RoundedRectangleBorder(
          borderRadius: material.BorderRadius.circular(radius),
        );

    return material.Card(
      elevation: 0,
      shape: effectiveShape,
      borderOnForeground: borderOnForeground,
      clipBehavior: clipBehavior,
      color: material.Colors.transparent,
      margin: margin,
      shadowColor: material.Colors.transparent,
      surfaceTintColor: material.Colors.transparent,
      semanticContainer: semanticContainer,
      child: material.DecoratedBox(
        decoration: material.BoxDecoration(
          borderRadius: material.BorderRadius.circular(radius),
          boxShadow: effectiveElevation > 0
              ? [
                  material.BoxShadow(
                    color: shadowColor ?? GlasConfig.shadowColor(context),
                    blurRadius: effectiveElevation * 4,
                    offset: material.Offset(0, effectiveElevation * 0.5),
                    spreadRadius: -2,
                  ),
                ]
              : const [],
        ),
        child: GlassLayer(
          borderRadius: radius,
          showBorder: true,
          child: material.Padding(
            padding: insetPadding ?? material.EdgeInsets.zero,
            child: child,
          ),
        ),
      ),
    );
  }
}
