import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../glas_config.dart';
import '../helpers/glass_layer.dart';

/// Glass-themed [material.Switch].
///
/// Drop-in replacement: same constructor API as Material's Switch.
class Switch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const Switch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return material.Switch(
      value: value,
      onChanged: onChanged,
      activeColor: GlasConfig.primary,
    );
  }
}
