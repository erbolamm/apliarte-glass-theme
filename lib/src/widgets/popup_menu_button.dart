import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

/// Glass-themed [material.PopupMenuButton].
///
/// Drop-in replacement: wraps Material's PopupMenuButton.
class PopupMenuButton<T> extends StatelessWidget {
  final List<material.PopupMenuEntry<T>> items;
  final material.PopupMenuItemSelected<T>? onSelected;
  final Widget? child;
  final Widget? icon;

  const PopupMenuButton({
    super.key,
    required this.items,
    this.onSelected,
    this.child,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return material.PopupMenuButton<T>(
      itemBuilder: (_) => items,
      onSelected: onSelected,
      child: child,
      icon: icon,
    );
  }
}
