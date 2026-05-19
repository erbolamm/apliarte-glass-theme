// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../glas_config.dart';

/// Glass-themed [material.LinearProgressIndicator].
///
/// Drop-in replacement: same constructor API as Material's
/// LinearProgressIndicator. Uses [GlasConfig.primary] as the default
/// color so the indicator blends with the glass theme automatically.
///
/// Not wrapped in [GlassLayer] — the bar is too thin for a meaningful
/// glass effect. Color harmonization is enough.
class LinearProgressIndicator extends StatelessWidget {
  final double? value;
  final Color? backgroundColor;
  final Color? color;
  final Animation<Color?>? valueColor;
  final double? minHeight;
  final String? semanticsLabel;
  final String? semanticsValue;
  final BorderRadius? borderRadius;

  const LinearProgressIndicator({
    super.key,
    this.value,
    this.backgroundColor,
    this.color,
    this.valueColor,
    this.minHeight,
    this.semanticsLabel,
    this.semanticsValue,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return material.LinearProgressIndicator(
      value: value,
      backgroundColor: backgroundColor,
      color: color ?? GlasConfig.primary,
      valueColor: valueColor,
      minHeight: minHeight,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
      borderRadius: borderRadius,
    );
  }
}
