import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

import '../../glas_config.dart';
import '../helpers/glass_layer.dart';

/// Glass-themed [material.Tab], [material.TabBar], and [material.TabBarView].
///
/// Drop-in replacements: same constructor API.

class Tab extends StatelessWidget {
  final Widget? child;
  final String? text;
  final Widget? icon;

  const Tab({super.key, this.child, this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return material.Tab(text: text, icon: icon, child: child);
  }
}

class TabBar extends StatelessWidget {
  final List<Widget> tabs;
  final material.TabController? controller;
  final bool isScrollable;

  const TabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.isScrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    return GlassLayer(
      borderRadius: GlasConfig.mediumRadiusValue(),
      child: material.TabBar(
        tabs: tabs,
        controller: controller,
        isScrollable: isScrollable,
        indicatorColor: GlasConfig.primary,
      ),
    );
  }
}

class TabBarView extends StatelessWidget {
  final List<Widget> children;
  final material.TabController? controller;

  const TabBarView({
    super.key,
    required this.children,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return material.TabBarView(controller: controller, children: children);
  }
}
