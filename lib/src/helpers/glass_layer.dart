import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

import '../../glas_config.dart';

/// Internal widget that applies the liquid glass effect to any child.
///
/// Reads defaults from [GlasConfig] and adapts to dark/light automatically.
/// El contenido se encapsula en [ClipRRect] con el [borderRadius] visual
/// para evitar artefactos de [LiquidGlass.withOwnLayer] al hacer scroll.
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
    final settings = LiquidGlassSettings(
      thickness: GlasConfig.highlight() * 30,
      blur: blur,
      glassColor: GlasConfig.glassColor(context),
      lightIntensity: GlasConfig.highlight(),
      refractiveIndex: 1.3,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Stack(
        children: [
          // ── Sombra única (solo si se pasa explícitamente) ──
          if (customShadows != null)
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    boxShadow: customShadows ??
                        [
                          BoxShadow(
                            color: GlasConfig.shadowColor(context),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                            spreadRadius: -4,
                          ),
                        ],
                  ),
                ),
              ),
            ),

          // ── Capa glass ──
          LiquidGlass.withOwnLayer(
            shape: LiquidRoundedRectangle(borderRadius: radius),
            settings: settings,
            child: child,
          ),

          // ── Borde glass ──
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
      ),
    );
  }
}
