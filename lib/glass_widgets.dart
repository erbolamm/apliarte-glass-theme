library;

/// Opt-in glass widget wrappers.
///
/// Import this library with a prefix to avoid shadowing Flutter Material:
///
/// ```dart
/// import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';
/// import 'package:apliarte_glass_theme/glass_widgets.dart' as glass;
///
/// glass.Card(child: const Text('Glass'));
/// ```
///
/// The default `apliarte_glass_theme.dart` entrypoint stays Material-safe and
/// does not replace core widgets. Use this prefixed entrypoint for explicit
/// glass widgets with real blur/BackdropFilter behavior.
export 'src/widgets/appbar.dart';
export 'src/widgets/bottom_app_bar.dart';
export 'src/widgets/bottom_sheet.dart';
export 'src/widgets/card.dart';
export 'src/widgets/dialog.dart';
export 'src/widgets/drawer.dart';
export 'src/widgets/fab.dart';
export 'src/widgets/nav_bar.dart';
export 'src/widgets/elevated_button.dart';
export 'src/widgets/text_button.dart';
export 'src/widgets/outlined_button.dart';
export 'src/widgets/snack_bar.dart';
export 'src/widgets/icon_button.dart';
export 'src/widgets/circular_progress_indicator.dart';
export 'src/widgets/linear_progress_indicator.dart';
export 'src/widgets/slider.dart';
export 'src/widgets/list_tile.dart';
export 'src/widgets/divider.dart';
export 'src/widgets/tab_bar.dart';
export 'src/widgets/text_field.dart';
export 'src/widgets/switch.dart';
export 'src/widgets/popup_menu_button.dart';
export 'src/widgets/badge.dart';
export 'src/widgets/expansion_tile.dart';
