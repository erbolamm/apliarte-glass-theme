import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../glas_config.dart';

/// Glass-themed [material.Divider].
///
/// Drop-in replacement: same constructor API as Material's Divider.
/// Uses [GlasConfig.outlineVariant] for the divider color by default
/// with a subtle alpha for the frosted glass look.
class Divider extends StatelessWidget {
  final double? height;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final Color? color;

  const Divider({
    super.key,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        color ?? GlasConfig.outlineVariant.withValues(alpha: 0.3);

    return material.Divider(
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      color: effectiveColor,
    );
  }
}
