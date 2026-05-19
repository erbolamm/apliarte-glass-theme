// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../glas_config.dart';

/// Glass-themed [material.Slider].
///
/// Drop-in replacement: same constructor API as Material's Slider.
/// Uses [GlasConfig.primary] as the default [activeColor] and
/// [thumbColor] so the slider blends with the glass theme.
///
/// Not wrapped in [GlassLayer] — the slider is inline. Color
/// harmonization via active/inactive/thumb colors is enough.
class Slider extends StatelessWidget {
  final double value;
  final double? secondaryTrackValue;
  final ValueChanged<double>? onChanged;
  final ValueChanged<double>? onChangeStart;
  final ValueChanged<double>? onChangeEnd;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? secondaryActiveColor;
  final Color? thumbColor;
  final material.SliderInteraction? allowedInteraction;
  final material.MouseCursor? mouseCursor;
  final material.SemanticFormatterCallback? semanticFormatterCallback;
  final material.FocusNode? focusNode;
  final bool autofocus;

  const Slider({
    super.key,
    required this.value,
    this.secondaryTrackValue,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.activeColor,
    this.inactiveColor,
    this.secondaryActiveColor,
    this.thumbColor,
    this.allowedInteraction,
    this.mouseCursor,
    this.semanticFormatterCallback,
    this.focusNode,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return material.Slider(
      value: value,
      secondaryTrackValue: secondaryTrackValue,
      onChanged: onChanged,
      onChangeStart: onChangeStart,
      onChangeEnd: onChangeEnd,
      min: min,
      max: max,
      divisions: divisions,
      label: label,
      activeColor: activeColor ?? GlasConfig.primary,
      inactiveColor: inactiveColor,
      secondaryActiveColor: secondaryActiveColor,
      thumbColor: thumbColor ?? GlasConfig.primary,
      allowedInteraction: allowedInteraction ?? material.SliderInteraction.slideOnly,
      mouseCursor: mouseCursor,
      semanticFormatterCallback: semanticFormatterCallback,
      focusNode: focusNode,
      autofocus: autofocus,
    );
  }
}
