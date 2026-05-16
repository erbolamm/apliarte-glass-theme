import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

/// A glass morphism card with liquid glass effect.
///
/// Wraps the standard Material [Card] API while applying a frosted glass
/// background using [LiquidGlass.withOwnLayer].
///
/// {@tool snippet}
/// ```dart
/// ApliGlasCard(
///   child: Column(
///     children: [
///       Text('Card Title'),
///       SizedBox(height: 8),
///       Text('Card content goes here.'),
///     ],
///   ),
/// )
/// ```
/// {@end-tool}
class ApliGlasCard extends StatelessWidget {
  /// The widget below this card in the tree.
  final Widget child;

  /// The border radius of the card.
  ///
  /// Defaults to `16.0`.
  final double borderRadius;

  /// The elevation (shadow) of the card.
  ///
  /// Defaults to `4.0`.
  final double elevation;

  /// The margin around the card.
  ///
  /// Defaults to `EdgeInsets.symmetric(horizontal: 16, vertical: 8)`.
  final EdgeInsetsGeometry? margin;

  /// The padding inside the card.
  ///
  /// Defaults to `EdgeInsets.all(16)`.
  final EdgeInsetsGeometry? padding;

  /// Settings passed through to [LiquidGlass.withOwnLayer].
  ///
  /// Controls glass thickness, blur, color, light intensity, and refractive index.
  final LiquidGlassSettings? liquidGlassSettings;

  /// Whether to show the glass border overlay.
  ///
  /// Defaults to `true`.
  final bool showBorder;

  /// Whether to clip the card content to the border radius.
  ///
  /// Defaults to `true`.
  final bool clipContent;

  /// Creates a glass-themed card.
  const ApliGlasCard({
    super.key,
    required this.child,
    this.borderRadius = 16.0,
    this.elevation = 4.0,
    this.margin,
    this.padding,
    this.liquidGlassSettings,
    this.showBorder = true,
    this.clipContent = true,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveMargin =
        margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
    final effectivePadding =
        padding ?? const EdgeInsets.all(16);

    return Container(
      margin: effectiveMargin,
      child: PhysicalModel(
        color: Colors.transparent,
        elevation: elevation,
        shadowColor: const Color(0x1A000000),
        borderRadius: BorderRadius.circular(borderRadius),
        clipBehavior: clipContent ? Clip.antiAlias : Clip.none,
        child: Stack(
          children: [
            // Glass layer
            LiquidGlass.withOwnLayer(
              shape: LiquidRoundedRectangle(
                borderRadius: borderRadius,
              ),
              settings: liquidGlassSettings ??
                  LiquidGlassSettings(
                    thickness: 20.0,
                    blur: 16.0,
                    glassColor: const Color(0xCCFFFFFF),
                    lightIntensity: 0.6,
                    refractiveIndex: 1.5,
                  ),
              child: Container(
                padding: effectivePadding,
                child: child,
              ),
            ),
            // Border overlay
            if (showBorder)
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius),
                      border: Border.all(
                        color: const Color(0x99FFFFFF),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
