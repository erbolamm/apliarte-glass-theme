import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../glas_config.dart';

/// Internal widget that applies a frosted-glass layer to any child.
///
/// Uses Flutter's built-in [BackdropFilter] instead of shader packages so the
/// package can be published as a stable production release.
class GlassLayer extends StatelessWidget {
  final Widget child;
  final double? borderRadius;
  final double? customBlur;
  final bool showBorder;
  final List<BoxShadow>? customShadows;

  const GlassLayer({
    super.key,
    required this.child,
    this.borderRadius,
    this.customBlur,
    this.showBorder = true,
    this.customShadows,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? 0;
    final blur = customBlur ?? GlasConfig.blur();

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Stack(
        children: [
          if (customShadows != null)
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    boxShadow: customShadows,
                  ),
                ),
              ),
            ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: GlasConfig.glassColor(context),
                  borderRadius: BorderRadius.circular(radius),
                ),
              ),
            ),
          ),
          child,
          if (showBorder && radius > 0)
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    border: Border.all(
                      color: GlasConfig.borderColor(context),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
