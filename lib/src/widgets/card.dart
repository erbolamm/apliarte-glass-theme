import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../glas_config.dart';
import '../helpers/glass_layer.dart';

/// Glass-themed [material.Card].
///
/// Drop-in replacement: same constructor API as Material's Card.
/// The glass effect adapts to dark/light theme automatically.
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
    final radius = GlasConfig.cardBorderRadius ?? 16.0;
    final effectiveElevation = elevation ?? (GlasConfig.cardElevation ?? 4.0);

    return material.Container(
      margin: margin ?? const material.EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: material.PhysicalModel(
        color: material.Colors.transparent,
        elevation: effectiveElevation,
        shadowColor: GlasConfig.shadowColor(context),
        borderRadius: material.BorderRadius.circular(radius),
        clipBehavior: clipBehavior,
        child: GlassLayer(
          borderRadius: radius,
          customBlur: GlasConfig.cardBlur ?? GlasConfig.blur,
          customShadows: [
            material.BoxShadow(
              color: GlasConfig.shadowColor(context),
              blurRadius: effectiveElevation * 4,
              offset: material.Offset(0, effectiveElevation * 0.5),
            ),
          ],
          child: material.Container(
            padding: insetPadding ?? const material.EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}
