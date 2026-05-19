// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../glas_config.dart';

/// Glass-themed [material.CircularProgressIndicator].
///
/// Drop-in replacement: same constructor API as Material's
/// CircularProgressIndicator. Uses [GlasConfig.primary] as the default
/// color so the indicator blends with the glass theme automatically.
///
/// Not wrapped in [GlassLayer] — the indicator is too small for a
/// meaningful glass effect. Color harmonization is enough.
class CircularProgressIndicator extends StatelessWidget {
  final double? value;
  final Color? backgroundColor;
  final Color? color;
  final Animation<Color?>? valueColor;
  final double? strokeWidth;
  final double strokeAlign;
  final String? semanticsLabel;
  final String? semanticsValue;
  final material.StrokeCap? strokeCap;
  final BoxConstraints? constraints;

  const CircularProgressIndicator({
    super.key,
    this.value,
    this.backgroundColor,
    this.color,
    this.valueColor,
    this.strokeWidth,
    this.strokeAlign = CircularProgressIndicator.strokeAlignInside,
    this.semanticsLabel,
    this.semanticsValue,
    this.strokeCap,
    this.constraints,
  });

  /// The default value of [strokeAlign].
  static const double strokeAlignCenter = material.CircularProgressIndicator.strokeAlignCenter;

  /// The default value of [strokeAlign].
  static const double strokeAlignInside = material.CircularProgressIndicator.strokeAlignInside;

  @override
  Widget build(BuildContext context) {
    return material.CircularProgressIndicator(
      value: value,
      backgroundColor: backgroundColor,
      color: color ?? GlasConfig.primary,
      valueColor: valueColor,
      strokeWidth: strokeWidth,
      strokeAlign: strokeAlign,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
      strokeCap: strokeCap,
      constraints: constraints,
    );
  }
}
