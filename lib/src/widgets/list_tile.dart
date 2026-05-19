import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../glas_config.dart';
import '../helpers/glass_layer.dart';

/// Glass-themed [material.ListTile].
///
/// Drop-in replacement: same constructor API as Material's ListTile.
/// Wraps content in [GlassLayer] for a frosted glass background.
///
/// The internal [material.ListTile] uses transparent colors so the glass
/// effect shows through. Selected state uses a subtle primary tint.
class ListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool enabled;
  final bool selected;
  final material.ValueChanged<bool>? onFocusChange;
  final material.FocusNode? focusNode;
  final bool autofocus;
  final Color? tileColor;
  final Color? selectedTileColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? splashColor;
  final material.ShapeBorder? shape;
  final material.VisualDensity? visualDensity;
  final material.EdgeInsetsGeometry? contentPadding;
  final double? horizontalTitleGap;
  final double? minVerticalPadding;
  final double? minLeadingWidth;
  final bool enableFeedback;
  final material.MouseCursor? mouseCursor;
  final Color? textColor;
  final Color? iconColor;
  final bool isThreeLine;
  final bool dense;
  final material.ListTileStyle? style;

  const ListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.enabled = true,
    this.selected = false,
    this.onFocusChange,
    this.focusNode,
    this.autofocus = false,
    this.tileColor,
    this.selectedTileColor,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.shape,
    this.visualDensity,
    this.contentPadding,
    this.horizontalTitleGap,
    this.minVerticalPadding,
    this.minLeadingWidth,
    this.enableFeedback = true,
    this.mouseCursor,
    this.textColor,
    this.iconColor,
    this.isThreeLine = false,
    this.dense = false,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final radius = GlasConfig.mediumRadiusValue();
    final effectiveSelectedColor = selectedTileColor ??
        GlasConfig.primary.withValues(alpha: 0.12);

    return GlassLayer(
      borderRadius: radius,
      child: material.ListTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        onTap: onTap,
        onLongPress: onLongPress,
        enabled: enabled,
        selected: selected,
        onFocusChange: onFocusChange,
        focusNode: focusNode,
        autofocus: autofocus,
        tileColor: selected ? effectiveSelectedColor : material.Colors.transparent,
        selectedTileColor: effectiveSelectedColor,
        focusColor: focusColor ?? material.Colors.transparent,
        hoverColor: hoverColor ?? material.Colors.transparent,
        splashColor: splashColor ?? material.Colors.transparent,
        shape: shape ??
            material.RoundedRectangleBorder(
              borderRadius: material.BorderRadius.circular(radius),
            ),
        visualDensity: visualDensity,
        contentPadding: contentPadding,
        horizontalTitleGap: horizontalTitleGap,
        minVerticalPadding: minVerticalPadding,
        minLeadingWidth: minLeadingWidth,
        enableFeedback: enableFeedback,
        mouseCursor: mouseCursor,
        textColor: textColor,
        iconColor: iconColor,
        isThreeLine: isThreeLine,
        dense: dense,
        style: style,
      ),
    );
  }
}
