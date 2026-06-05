# ApliArte Glass Theme

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.32-blue.svg)](https://flutter.dev)
[![pub package](https://img.shields.io/pub/v/apliarte_glass_theme)](https://pub.dev/packages/apliarte_glass_theme)
[![Demo Web](https://img.shields.io/badge/Demo-Ver%20en%20vivo-purple?style=for-the-badge&logo=dart)](https://erbolamm.github.io/apliarte-glass-theme/)

Glass theme utilities and opt-in glass widgets for Flutter.

## Safe by default

The main entrypoint preserves Flutter Material compatibility:

```dart
import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';

MaterialApp(
  theme: GlassTheme.light(Colors.indigo),
  darkTheme: GlassTheme.dark(Colors.indigo),
  home: const MyHomePage(),
);
```

`apliarte_glass_theme.dart` reexports Material without replacing `Card`,
`AlertDialog`, buttons, `BottomSheet`, etc. Existing Material layouts keep their
normal constraints and APIs.

## Opt-in glass widgets

Use the glass wrappers explicitly with a prefix:

```dart
import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';
import 'package:apliarte_glass_theme/glass_widgets.dart' as glass;

glass.Card(
  child: const Padding(
    padding: EdgeInsets.all(16),
    child: Text('Glass content'),
  ),
);

glass.AlertDialog(
  title: const Text('Glass dialog'),
  content: const Text('Uses Material dialog constraints.'),
);
```

This avoids hidden layout changes in production apps.

## Components available as opt-in wrappers

- `glass.AppBar`
- `glass.Card`
- `glass.NavigationBar`
- `glass.BottomAppBar`
- `glass.AlertDialog`
- `glass.FloatingActionButton`
- `glass.BottomSheet`
- `glass.Drawer`
- Buttons, list tiles, dividers, sliders, progress indicators, tabs, text fields,
  switches, popup menus, badges and expansion tiles.

## Installation

```yaml
dependencies:
  apliarte_glass_theme: ^0.7.0
```

```bash
flutter pub get
```

## Dark/light theme

```dart
MaterialApp(
  theme: GlassTheme.light(Colors.blue),
  darkTheme: GlassTheme.dark(Colors.blue),
);
```

## Optional configuration

```dart
GlasConfig.useWarmPreset = true;
GlasConfig.glassTintColor = const Color(0xFFFFF0F5);
GlasConfig.largeRadius = 32.0;
GlasConfig.mediumRadius = 24.0;
GlasConfig.glassBlur = 24.0;
```

## Why the API changed in 0.7

Earlier versions replaced Material widgets globally from one import. That was
convenient, but unsafe: wrappers can accidentally add padding, margins, stacks,
or constraints that Material does not add. Version 0.7 keeps Material stable by
default and makes glass widgets explicit.

## Links

- [pub.dev](https://pub.dev/packages/apliarte_glass_theme)
- [GitHub](https://github.com/erbolamm/apliarte-glass-theme)
- [Web demo](https://erbolamm.github.io/apliarte-glass-theme/)
- [Documentation](https://pub.dev/documentation/apliarte_glass_theme/latest/)
- [Discord](https://discord.gg/b9PD37KWS5)

## Author

Javier Mateo (ApliArte) — [github.com/erbolamm](https://github.com/erbolamm)

## Support

If this package saves you time, a coffee helps keep development going.

| Platform | Link |
|----------|------|
| PayPal | [paypal.me/erbolamm](https://paypal.me/erbolamm) |
| Ko-fi | [ko-fi.com/C0C11TWR1K](https://ko-fi.com/C0C11TWR1K) |
| Twitch Tip | [streamelements.com/apliarte/tip](https://streamelements.com/apliarte/tip) |

## License

MIT — © 2026 ApliArte
