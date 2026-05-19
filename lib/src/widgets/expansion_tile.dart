import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../glas_config.dart';
import '../helpers/glass_layer.dart';

/// Glass-themed [material.ExpansionTile].
///
/// Drop-in replacement: same constructor API.
class ExpansionTile extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final List<Widget> children;
  final bool initiallyExpanded;
  final ValueChanged<bool>? onExpansionChanged;

  const ExpansionTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.children = const <Widget>[],
    this.initiallyExpanded = false,
    this.onExpansionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GlassLayer(
      borderRadius: GlasConfig.mediumRadiusValue(),
      child: material.ExpansionTile(
        leading: leading,
        title: title,
        subtitle: subtitle,
        children: children,
        initiallyExpanded: initiallyExpanded,
        onExpansionChanged: onExpansionChanged,
        backgroundColor: material.Colors.transparent,
        collapsedBackgroundColor: material.Colors.transparent,
      ),
    );
  }
}
