import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../glas_config.dart';
import '../helpers/glass_layer.dart';

/// Glass-themed [material.SnackBar].
///
/// Drop-in replacement: same constructor API as Material's SnackBar.
/// Extends [material.SnackBar] so it can be passed directly to
/// [material.ScaffoldMessengerState.showSnackBar].
///
/// The [content] is wrapped in a [GlassLayer] for a frosted glass effect.
/// The internal SnackBar background is transparent so the glass shows through.
///
/// ```dart
/// ScaffoldMessenger.of(context).showSnackBar(
///   SnackBar(content: Text('Hello, Glass!')),
/// );
/// ```
class SnackBar extends material.SnackBar {
  /// Creates a glass-themed snack bar.
  ///
  /// All parameters match [material.SnackBar]. Only [content] is required.
  SnackBar({
    super.key,
    required Widget content,
    // ignore: avoid_unused_constructor_parameters
    Color? backgroundColor, // ignored — glass effect provides background
    super.elevation,
    super.margin,
    super.padding,
    super.width,
    super.shape,
    super.behavior,
    super.action,
    super.duration,
    super.animation,
    super.onVisible,
    super.dismissDirection,
    super.clipBehavior,
    super.closeIconColor,
    super.showCloseIcon,
  }) : super(
          backgroundColor: material.Colors.transparent,
          content: GlassLayer(
            borderRadius: GlasConfig.mediumRadiusValue(),
            child: content,
          ),
        );
}
