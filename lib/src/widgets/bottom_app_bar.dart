import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../glas_config.dart';
import '../helpers/glass_layer.dart';

/// Glass-themed [material.BottomAppBar].
///
/// Drop-in replacement: same constructor API as Material's BottomAppBar.
class BottomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? child;
  final Color? color;
  final double? elevation;
  final material.NotchedShape? shape;
  final Clip clipBehavior;
  final double notchMargin;
  final material.EdgeInsetsGeometry? padding;
  final double? height;
  final Color? shadowColor;
  final Color? surfaceTintColor;

  const BottomAppBar({
    super.key,
    this.child,
    this.color,
    this.elevation,
    this.shape,
    this.clipBehavior = Clip.none,
    this.notchMargin = 4.0,
    this.padding,
    this.height,
    this.shadowColor,
    this.surfaceTintColor,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(height ?? material.kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final h = height ?? material.kToolbarHeight;
    final radius = GlasConfig.bottomAppBarBorderRadius ?? 0;
    final effectiveElevation = elevation ?? 4.0;

    return material.PhysicalModel(
      color: material.Colors.transparent,
      elevation: effectiveElevation,
      shadowColor: GlasConfig.shadowColor(context),
      borderRadius: material.BorderRadius.circular(radius),
      clipBehavior: clipBehavior,
      child: GlassLayer(
        borderRadius: radius,
        customBlur: GlasConfig.bottomAppBarBlur ?? GlasConfig.blur,
        showBorder: radius > 0,
        child: material.Container(
          padding: padding ??
              const material.EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          height: h,
          child: child ?? const material.SizedBox.shrink(),
        ),
      ),
    );
  }
}
