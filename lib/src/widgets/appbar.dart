import 'dart:ui' as ui;

import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../glas_config.dart';
import '../helpers/liquid_highlight.dart';

/// AppBar con frosted glass real via [BackdropFilter] + [ImageFilter.blur].
///
/// Misma API que Material [AppBar], pero con efecto glass nativo de Flutter.
/// No usa [LiquidGlass] ni shaders — el blur lo provee [BackdropFilter],
/// que funciona consistentemente en todas las plataformas.
///
/// El tint/color del vidrio se deriva de [GlasConfig] y el theme.
///
/// ## Uso
/// ```dart
/// AppBar(
///   title: const Text('Título'),
///   actions: [IconButton(...)],
/// )
/// ```
class AppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final PreferredSizeWidget? bottom;
  final double elevation;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final double? toolbarHeight;
  final double? leadingWidth;
  final bool centerTitle;
  final Widget? flexibleSpace;
  final double? titleSpacing;
  final TextStyle? toolbarTextStyle;
  final TextStyle? titleTextStyle;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final Clip clipBehavior;
  final ShapeBorder? shape;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final double? scrolledUnderElevation;
  final bool excludeHeaderSemantics;
  final bool forceMaterialTransparency;

  /// Intensidad del blur del frosted glass (sigmaX/sigmaY).
  /// null → usa [GlasConfig.blur].
  final double? blurSigma;

  /// Radio de las esquinas inferiores. null → usa [GlasConfig.mediumRadiusValue].
  final double? bottomRadius;

  /// Tinte del vidrio. null → usa [GlasConfig.glassColor].
  final Color? glassTint;

  const AppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.bottom,
    this.elevation = 0,
    this.foregroundColor,
    this.backgroundColor,
    this.toolbarHeight,
    this.leadingWidth,
    this.centerTitle = false,
    this.flexibleSpace,
    this.titleSpacing,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.iconTheme,
    this.actionsIconTheme,
    this.clipBehavior = Clip.none,
    this.shape,
    this.shadowColor,
    this.surfaceTintColor,
    this.scrolledUnderElevation,
    this.excludeHeaderSemantics = false,
    this.forceMaterialTransparency = false,
    this.blurSigma,
    this.bottomRadius,
    this.glassTint,
  });

  @override
  Size get preferredSize => Size.fromHeight(
    (toolbarHeight ?? material.kToolbarHeight) +
        (bottom?.preferredSize.height ?? 0.0),
  );

  Widget? _resolveLeading(BuildContext context) {
    if (leading != null) return leading;
    if (!automaticallyImplyLeading) return null;

    final scaffold = material.Scaffold.maybeOf(context);
    if (scaffold != null && scaffold.hasDrawer) {
      return const material.DrawerButton();
    }
    if (material.Navigator.of(context, rootNavigator: true).canPop()) {
      return const material.BackButton();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = material.Theme.of(context);
    final appBarTheme = theme.appBarTheme;
    final effectiveForeground =
        foregroundColor ??
        appBarTheme.foregroundColor ??
        theme.colorScheme.onSurface;
    final tHeight = toolbarHeight ?? material.kToolbarHeight;
    final bHeight = bottom?.preferredSize.height ?? 0.0;
    final rBottom =
        bottomRadius ??
        GlasConfig.appBarBottomRadius ??
        GlasConfig.mediumRadiusValue();
    final topInset = material.MediaQuery.of(context).viewPadding.top;
    final resolvedLeading = _resolveLeading(context);
    final sigma = blurSigma ?? GlasConfig.appBarBlurSigma ?? GlasConfig.blur();
    final tint =
        glassTint ?? backgroundColor ?? GlasConfig.appBarColor(context);
    final effectiveIconTheme =
        (iconTheme ?? appBarTheme.iconTheme ?? const material.IconThemeData())
            .copyWith(
              color:
                  iconTheme?.color ??
                  appBarTheme.iconTheme?.color ??
                  effectiveForeground,
            );
    final effectiveActionsIconTheme =
        (actionsIconTheme ?? appBarTheme.actionsIconTheme ?? effectiveIconTheme)
            .copyWith(
              color:
                  actionsIconTheme?.color ??
                  appBarTheme.actionsIconTheme?.color ??
                  effectiveIconTheme.color ??
                  effectiveForeground,
            );
    final effectiveToolbarTextStyle =
        toolbarTextStyle ??
        appBarTheme.toolbarTextStyle ??
        theme.textTheme.bodyMedium;
    final effectiveLeadingWidth =
        leadingWidth ?? appBarTheme.leadingWidth ?? material.kToolbarHeight;
    final effectiveTitleSpacing =
        titleSpacing ??
        appBarTheme.titleSpacing ??
        material.NavigationToolbar.kMiddleSpacing;
    final effectiveTitleTextStyle =
        titleTextStyle ??
        appBarTheme.titleTextStyle ??
        theme.textTheme.titleLarge?.copyWith(color: effectiveForeground) ??
        const TextStyle();

    final totalHeight = topInset + tHeight + bHeight;

    return material.SizedBox(
      height: totalHeight,
      child: Stack(
        children: [
          // ── Frosted glass background (cubre todo el AppBar + status bar) ──
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: ClipRRect(
              clipBehavior: clipBehavior,
              borderRadius: material.BorderRadius.vertical(
                bottom: material.Radius.circular(rBottom),
              ),
              child: material.BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
                child: Container(
                  decoration: BoxDecoration(
                    color: tint,
                    border: Border(
                      bottom: BorderSide(
                        color: GlasConfig.borderColor(context),
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          if (flexibleSpace != null) Positioned.fill(child: flexibleSpace!),

          // ── Content ──
          material.Padding(
            padding: material.EdgeInsets.only(top: topInset),
            child: material.Column(
              mainAxisSize: material.MainAxisSize.min,
              children: [
                material.SizedBox(
                  height: tHeight,
                  child: material.DefaultTextStyle.merge(
                    style: effectiveToolbarTextStyle,
                    child: material.NavigationToolbar(
                      leading: resolvedLeading != null
                          ? material.SizedBox(
                              width: effectiveLeadingWidth,
                              child: material.IconTheme(
                                data: effectiveIconTheme,
                                child: resolvedLeading,
                              ),
                            )
                          : null,
                      middle: material.DefaultTextStyle(
                        style: effectiveTitleTextStyle,
                        child: title ?? const material.SizedBox.shrink(),
                      ),
                      trailing: actions != null
                          ? material.Row(
                              mainAxisSize: material.MainAxisSize.min,
                              children: actions!.map((action) {
                                return material.IconTheme(
                                  data: effectiveActionsIconTheme,
                                  child: action,
                                );
                              }).toList(),
                            )
                          : null,
                      centerMiddle: centerTitle,
                      middleSpacing: effectiveTitleSpacing,
                    ),
                  ),
                ),
                if (bottom != null) bottom!,
              ],
            ),
          ),

          // ── Acento líquido sutil ──
          if (GlasConfig.liquidHighlightEnabled && bottom == null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: IgnorePointer(
                child: Container(
                  height: 1.5,
                  decoration: LiquidHighlightDecoration.subtle(
                    theme.colorScheme.primary,
                  ).build(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
