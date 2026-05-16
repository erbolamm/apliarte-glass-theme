import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

import '../../glas_config.dart';

/// Internal widget that applies the liquid glass effect to any child.
///
/// Detects dark/light theme automatically from context and reads defaults
/// from [GlasConfig].
class GlassLayer extends StatelessWidget {
  final Widget child;
  final double? borderRadius;
  final double? customBlur;
  final LiquidGlassSettings? customSettings;
  final bool showBorder;
  final List<BoxShadow>? customShadows;

  const GlassLayer({
    super.key,
    required this.child,
    this.borderRadius,
    this.customBlur,
    this.customSettings,
    this.showBorder = true,
    this.customShadows,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? 0;
    final blur = customBlur ?? GlasConfig.blur;
    final settings = customSettings ??
        LiquidGlassSettings(
          thickness: GlasConfig.thickness,
          blur: blur,
          glassColor: GlasConfig.glassColor(context),
          lightIntensity: GlasConfig.lightIntensity,
          refractiveIndex: GlasConfig.refractiveIndex,
        );

    return Stack(
      children: [
        // Shadow layer
        if (customShadows != null || radius > 0)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                boxShadow: customShadows ??
                    [
                      BoxShadow(
                        color: GlasConfig.shadowColor(context),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                        spreadRadius: -4,
                      ),
                    ],
              ),
            ),
          ),
        // Glass layer
        LiquidGlass.withOwnLayer(
          shape: LiquidRoundedRectangle(borderRadius: radius),
          settings: settings,
          child: child,
        ),
        // Border overlay
        if (showBorder && radius > 0)
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
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
    );
  }
}
