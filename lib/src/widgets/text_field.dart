import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

/// Glass-themed [material.TextField].
///
/// Drop-in replacement: wraps Material's TextField.
class TextField extends StatelessWidget {
  final material.TextEditingController? controller;
  final material.InputDecoration? decoration;
  final bool obscureText;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final material.TextInputType? keyboardType;
  final material.FocusNode? focusNode;
  final bool autofocus;
  final bool readOnly;
  final bool enabled;

  const TextField({
    super.key,
    this.controller,
    this.decoration,
    this.obscureText = false,
    this.maxLines = 1,
    this.onChanged,
    this.keyboardType,
    this.focusNode,
    this.autofocus = false,
    this.readOnly = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return material.TextField(
      controller: controller,
      decoration: decoration,
      obscureText: obscureText,
      maxLines: maxLines,
      onChanged: onChanged,
      keyboardType: keyboardType,
      focusNode: focusNode,
      autofocus: autofocus,
      readOnly: readOnly,
      enabled: enabled != null ? enabled : null,
    );
  }
}
