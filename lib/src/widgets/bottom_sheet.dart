import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../glas_config.dart';
import '../helpers/glass_layer.dart';

/// Glass-themed [material.BottomSheet].
///
/// Drop-in replacement: same constructor API as Material's BottomSheet.
/// Use with [showGlassModalBottomSheet] for modal bottom sheets,
/// or directly within a [Scaffold] for persistent bottom sheets.
class BottomSheet extends StatelessWidget {
  final Widget? child;
  final Color? backgroundColor;
  final double? elevation;
  final material.ShapeBorder? shape;
  final Clip clipBehavior;
  final material.AnimationController? animationController;
  final bool? enableDrag;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final material.EdgeInsetsGeometry? padding;
  final bool showDragHandle;

  const BottomSheet({
    super.key,
    this.child,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.clipBehavior = Clip.none,
    this.animationController,
    this.enableDrag,
    this.shadowColor,
    this.surfaceTintColor,
    this.padding,
    this.showDragHandle = true,
  });

  @override
  Widget build(BuildContext context) {
    final radius = GlasConfig.largeRadiusValue();
    final effectiveElevation = elevation ?? 4.0;

    return GlassLayer(
      borderRadius: radius,
      showBorder: radius > 0,
      customShadows: [
        material.BoxShadow(
          color: GlasConfig.shadowColor(context),
          blurRadius: effectiveElevation * 6,
          offset: const material.Offset(0, -4),
          spreadRadius: -4,
        ),
      ],
      child: material.Container(
        padding: padding ?? const material.EdgeInsets.all(16),
        child: material.Column(
          mainAxisSize: material.MainAxisSize.min,
          children: [
            // Drag handle
            if (showDragHandle)
              material.Container(
                margin: const material.EdgeInsets.only(bottom: 12),
                width: 32,
                height: 4,
                decoration: material.BoxDecoration(
                  color: material.Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.2),
                  borderRadius: material.BorderRadius.circular(2),
                ),
              ),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}

/// Shows a modal bottom sheet with glass theme.
///
/// Drop-in replacement for [material.showModalBottomSheet].
/// Returns a [material.Future] that resolves when the sheet is dismissed.
Future<T?> showGlassModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Color? backgroundColor,
  double? elevation,
  material.ShapeBorder? shape,
  Clip clipBehavior = Clip.none,
  material.BoxConstraints? constraints,
  Color? barrierColor,
  bool isScrollControlled = false,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  bool showDragHandle = true,
  material.RouteSettings? routeSettings,
  material.AnimationController? transitionAnimationController,
}) {
  return material.showModalBottomSheet<T>(
    context: context,
    builder: (ctx) => BottomSheet(
      elevation: elevation,
      showDragHandle: showDragHandle,
      child: builder(ctx),
    ),
    backgroundColor: material.Colors.transparent,
    barrierColor: barrierColor,
    isScrollControlled: isScrollControlled,
    useRootNavigator: useRootNavigator,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    routeSettings: routeSettings,
    transitionAnimationController: transitionAnimationController,
    shape: shape ??
        material.RoundedRectangleBorder(
          borderRadius: material.BorderRadius.vertical(
            top: material.Radius.circular(
                GlasConfig.largeRadiusValue()),
          ),
        ),
  );
}
