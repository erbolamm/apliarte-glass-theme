/// ApliArte Glass Theme — drop-in replacement for Material 3 widgets.
///
/// Import this instead of `package:flutter/material.dart`:
/// ```dart
/// import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';
/// ```
///
/// Same API, same widget names — but every component has a frosted glass effect.
/// To revert to standard Material, delete `glas_config.dart`, remove this
/// package from `pubspec.yaml`, and switch back to `package:flutter/material.dart`.
library;

export 'package:flutter/material.dart'
    hide
        AppBar,
        BottomAppBar,
        Card,
        AlertDialog,
        NavigationBar;

// Re-export LiquidGlassSettings so users don't need a separate import.
export 'package:liquid_glass_renderer/liquid_glass_renderer.dart'
    show LiquidGlassSettings;

export 'glas_config.dart';

export 'src/widgets/appbar.dart';
export 'src/widgets/bottom_app_bar.dart';
export 'src/widgets/card.dart';
export 'src/widgets/dialog.dart';
export 'src/widgets/nav_bar.dart';
