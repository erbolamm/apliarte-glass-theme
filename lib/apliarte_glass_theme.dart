library;

/// Safe public entrypoint.
///
/// This file intentionally re-exports Flutter Material without hiding or
/// replacing core widgets. Apps can import this file instead of
/// `package:flutter/material.dart` and keep Material API compatibility while
/// gaining [GlasConfig], [GlassTheme], and helpers.
///
/// Real glass widgets live in `glass_widgets.dart` and should be imported
/// explicitly when blur/BackdropFilter behavior is desired:
///
/// ```dart
/// import 'package:apliarte_glass_theme/glass_widgets.dart' as glass;
/// ```
export 'package:flutter/material.dart';

export 'glas_config.dart';
export 'glass_theme.dart';
export 'src/helpers/liquid_highlight.dart';
