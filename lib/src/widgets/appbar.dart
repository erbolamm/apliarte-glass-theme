import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../glas_config.dart';
import '../helpers/glass_layer.dart';

/// Glass-themed [material.AppBar].
///
/// Drop-in replacement: same constructor API as Material's AppBar.
/// El leading se resuelve automáticamente:
///   - [leading] explícito si se pasa
///   - [DrawerButton] si el [Scaffold] tiene un drawer
///   - [BackButton] si [Navigator.canPop]
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
  });

  @override
  Size get preferredSize => Size.fromHeight(
        (toolbarHeight ?? material.kToolbarHeight) +
            (bottom?.preferredSize.height ?? 0.0),
      );

  /// Resuelve el leading según la convención de Material.
  Widget? _resolveLeading(BuildContext context) {
    if (leading != null) return leading;
    if (!automaticallyImplyLeading) return null;

    // DrawerButton si hay un Scaffold con drawer
    final scaffold = material.Scaffold.maybeOf(context);
    if (scaffold != null && scaffold.hasDrawer) {
      return const material.DrawerButton();
    }

    // BackButton si se puede hacer pop
    if (material.Navigator.of(context, rootNavigator: true).canPop()) {
      return const material.BackButton();
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = material.Theme.of(context);
    final effectiveForeground = foregroundColor ?? theme.colorScheme.onSurface;
    final tHeight = toolbarHeight ?? material.kToolbarHeight;
    final radius = GlasConfig.mediumRadiusValue();
    final resolvedLeading = _resolveLeading(context);

    return GlassLayer(
      borderRadius: radius,
      showBorder: false,
      child: material.Column(
        mainAxisSize: material.MainAxisSize.min,
        children: [
          material.SizedBox(
            height: tHeight,
            child: material.NavigationToolbar(
              leading: resolvedLeading != null
                  ? material.IconTheme(
                      data: material.IconThemeData(color: effectiveForeground),
                      child: resolvedLeading,
                    )
                  : null,
              middle: material.DefaultTextStyle(
                style: titleTextStyle ??
                    theme.textTheme.titleLarge?.copyWith(
                          color: effectiveForeground,
                        ) ??
                    const TextStyle(),
                child: title ?? const material.SizedBox.shrink(),
              ),
              trailing: actions != null
                  ? material.Row(
                      mainAxisSize: material.MainAxisSize.min,
                      children: actions!.map((action) {
                        return material.IconTheme(
                          data: material.IconThemeData(
                              color: effectiveForeground),
                          child: action,
                        );
                      }).toList(),
                    )
                  : null,
            ),
          ),
          if (bottom != null) bottom!,
        ],
      ),
    );
  }
}
