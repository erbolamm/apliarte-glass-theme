import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

/// A glass morphism AppBar with liquid glass effect.
///
/// Wraps the standard Material [AppBar] API while applying a frosted glass
/// background using [LiquidGlass.withOwnLayer].
///
/// {@tool snippet}
/// ```dart
/// Scaffold(
///   appBar: ApliGlasAppBar(
///     title: const Text('Home'),
///     actions: [
///       IconButton(icon: Icon(Icons.settings), onPressed: () {}),
///     ],
///   ),
///   body: ...
/// )
/// ```
/// {@end-tool}
class ApliGlasAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The primary widget displayed in the app bar.
  final Widget? title;

  /// Widgets displayed before the title (typically a back button).
  final Widget? leading;

  /// Widgets displayed after the title.
  final List<Widget>? actions;

  /// Whether to automatically imply a back button when the route can pop.
  final bool automaticallyImplyLeading;

  /// Bottom widget (typically a [TabBar]).
  final PreferredSizeWidget? bottom;

  /// Elevation of the app bar.
  final double elevation;

  /// Whether to show a shadow under the app bar.
  final bool shadow;

  /// Settings passed through to [LiquidGlass.withOwnLayer].
  ///
  /// Controls glass thickness, blur, color, light intensity, and refractive index.
  final LiquidGlassSettings? liquidGlassSettings;

  /// Border radius of the bottom corners of the app bar.
  ///
  /// Defaults to `0` (no rounded bottom corners).
  final double bottomRadius;

  /// The style of the toolbar's text and icons.
  final Color? foregroundColor;

  /// Creates a glass-themed app bar.
  const ApliGlasAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.bottom,
    this.elevation = 0,
    this.shadow = true,
    this.liquidGlassSettings,
    this.bottomRadius = 0,
    this.foregroundColor,
  });

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0.0),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveForeground = foregroundColor ?? theme.colorScheme.onSurface;

    return PreferredSize(
      preferredSize: preferredSize,
      child: Stack(
        children: [
          // Shadow layer
          if (shadow)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(bottomRadius),
                    bottomRight: Radius.circular(bottomRadius),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x1A000000),
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
            shape: LiquidRoundedRectangle(
              borderRadius: bottomRadius > 0 ? bottomRadius : 0,
            ),
            settings: liquidGlassSettings ??
                LiquidGlassSettings(
                  thickness: 20.0,
                  blur: 16.0,
                  glassColor: const Color(0xCCFFFFFF),
                  lightIntensity: 0.6,
                  refractiveIndex: 1.5,
                ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Toolbar
                SizedBox(
                  height: kToolbarHeight,
                  child: NavigationToolbar(
                    leading: leading != null
                        ? IconTheme(
                            data: IconThemeData(color: effectiveForeground),
                            child: leading!,
                          )
                        : null,
                    middle: DefaultTextStyle(
                      style: theme.textTheme.titleLarge?.copyWith(
                            color: effectiveForeground,
                          ) ??
                          const TextStyle(),
                      child: title ?? const SizedBox.shrink(),
                   ),
                    trailing: actions != null
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: actions!.map((action) {
                              return IconTheme(
                                data: IconThemeData(color: effectiveForeground),
                                child: action,
                              );
                            }).toList(),
                          )
                        : null,
                  ),
                ),
                // Bottom widget (TabBar, etc.)
                if (bottom != null) bottom!,
              ],
            ),
          ),
          // Bottom border line
          if (bottomRadius == 0 && shadow)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: IgnorePointer(
                child: Container(
                  height: 1.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.transparent,
                        const Color(0x4DFFFFFF),
                        Colors.transparent,
                      ],
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
