import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

/// Glass-themed [material.Badge].
///
/// Drop-in replacement: same constructor API as Material's Badge.
class Badge extends StatelessWidget {
  final Widget? child;
  final Widget? label;
  final bool isLabelVisible;

  const Badge({
    super.key,
    this.child,
    this.label,
    this.isLabelVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return material.Badge(
      child: child,
      label: label,
      isLabelVisible: isLabelVisible,
    );
  }
}
