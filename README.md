# ApliArte Glass Theme

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.32-blue.svg)](https://flutter.dev)

A beautiful glass morphism UI component library for Flutter with liquid glass effects, smooth animations, and a cohesive frosted-glass design language.

## Components

| Component | Class | Description |
|-----------|-------|-------------|
| Bottom Nav Bar | `ApliGlasBar` | Glass bottom navigation bar with drag interaction |
| App Bar | `ApliGlasAppBar` | Glass app bar with frosted background |
| Card | `ApliGlasCard` | Glass card with frosted background |
| *More coming soon* | | |

## Features

- **Liquid glass morphism** powered by `liquid_glass_renderer`
- **ApliGlasBar** — sliding indicator, horizontal drag, animated icon bounce, color transitions
- **ApliGlasAppBar** — frosted glass toolbar with leading, title, actions, and bottom (TabBar)
- **ApliGlasCard** — frosted glass card with elevation, border overlay, and padding
- Support for **SVG assets**, **IconData**, and **custom Widget** icons (Bar)
- Fully customizable styling via `ApliGlasBarStyle` and `LiquidGlassSettings`
- Dynamic item count (2+ items)

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  apliarte_glass_theme: ^0.1.0
```

Then run:

```bash
flutter pub get
```

## Quick Start

### ApliGlasBar (Bottom Navigation)

```dart
import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';

Scaffold(
  extendBody: true,
  body: pages[_currentIndex],
  bottomNavigationBar: ApliGlasBar(
    items: const [
      ApliGlasBarItem(iconData: Icons.home, label: 'Home'),
      ApliGlasBarItem(iconData: Icons.search, label: 'Search'),
      ApliGlasBarItem(iconData: Icons.person, label: 'Profile'),
    ],
    currentIndex: _currentIndex,
    onTap: (index) => setState(() => _currentIndex = index),
  ),
);
```

### ApliGlasAppBar (Glass App Bar)

```dart
Scaffold(
  appBar: ApliGlasAppBar(
    title: const Text('Home'),
    actions: [
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {},
      ),
    ],
  ),
  body: ...
)
```

### ApliGlasCard (Glass Card)

```dart
ApliGlasCard(
  child: Column(
    children: [
      Text('Card Title'),
      SizedBox(height: 8),
      Text('Card content goes here.'),
    ],
  ),
)
```

## API Reference

### ApliGlasBar

The main bottom navigation widget. Place it as the `bottomNavigationBar` of a `Scaffold`.

| Parameter      | Type                     | Required | Description                                |
| -------------- | ------------------------ | -------- | ------------------------------------------ |
| `items`        | `List<ApliGlasBarItem>`  | Yes      | Navigation items (minimum 2)               |
| `currentIndex` | `int`                    | Yes      | Currently selected item index              |
| `onTap`        | `ValueChanged<int>`      | Yes      | Callback when an item is tapped or dragged |
| `style`        | `ApliGlasBarStyle?`      | No       | Style customization                        |

### ApliGlasBarItem

Data model for each navigation item. At least one icon source must be provided.

| Parameter      | Type        | Description             |
| -------------- | ----------- | ----------------------- |
| `svgAssetPath` | `String?`   | Path to an SVG asset    |
| `iconData`     | `IconData?` | Material/Cupertino icon |
| `iconWidget`   | `Widget?`   | Custom widget icon      |
| `label`        | `String`    | Text label for the item |

### ApliGlasBarStyle

Full style customization for the bottom navigation bar.

| Property              | Type                   | Default                               |
| --------------------- | ---------------------- | ------------------------------------- |
| `liquidGlassSettings` | `LiquidGlassSettings?` | Built-in defaults                     |
| `activeColor`         | `Color`                | `Color(0xFF10B981)` (emerald)         |
| `inactiveColor`       | `Color`                | `Color(0xFFA1A1AA)` (neutral gray)    |
| `borderRadius`        | `double`               | `32`                                  |
| `height`              | `double`               | `57`                                  |
| `padding`             | `EdgeInsets`           | `EdgeInsets.fromLTRB(20, 12, 20, 32)` |
| `animationDuration`   | `Duration`             | `250ms`                               |
| `animationCurve`      | `Curve`                | `Curves.easeOutQuad`                  |
| `iconSize`            | `double`               | `24`                                  |
| `selectedIconScale`   | `double`               | `1.2`                                 |
| `labelStyle`          | `TextStyle?`           | `null` (uses built-in style)          |

### ApliGlasAppBar

A glass morphism app bar. Wraps the standard Material AppBar API.

| Parameter               | Type                   | Default               | Description                             |
| ----------------------- | ---------------------- | --------------------- | --------------------------------------- |
| `title`                 | `Widget?`              | `null`                | Primary title widget                    |
| `leading`               | `Widget?`              | `null`                | Widget before the title                 |
| `actions`               | `List<Widget>?`        | `null`                | Widgets after the title                 |
| `automaticallyImplyLeading` | `bool`             | `true`                | Auto back button when route can pop     |
| `bottom`                | `PreferredSizeWidget?` | `null`                | Bottom widget (e.g. TabBar)             |
| `elevation`             | `double`               | `0`                   | Shadow elevation                        |
| `shadow`                | `bool`                 | `true`                | Show shadow beneath the bar             |
| `liquidGlassSettings`   | `LiquidGlassSettings?` | Built-in defaults     | Glass effect configuration              |
| `bottomRadius`          | `double`               | `0`                   | Bottom corner radius                    |
| `foregroundColor`       | `Color?`               | Theme's onSurface     | Color for icons and text                |

### ApliGlasCard

A glass morphism card.

| Parameter             | Type                   | Default                                | Description                    |
| --------------------- | ---------------------- | -------------------------------------- | ------------------------------ |
| `child`               | `Widget`               | Required                               | Content widget                 |
| `borderRadius`        | `double`               | `16.0`                                 | Corner radius                  |
| `elevation`           | `double`               | `4.0`                                  | Shadow elevation               |
| `margin`              | `EdgeInsetsGeometry?`  | `EdgeInsets.symmetric(h:16, v:8)`      | Outer margin                   |
| `padding`             | `EdgeInsetsGeometry?`  | `EdgeInsets.all(16)`                   | Inner padding                  |
| `liquidGlassSettings` | `LiquidGlassSettings?` | Built-in defaults                      | Glass effect configuration     |
| `showBorder`          | `bool`                 | `true`                                 | Show glass border overlay      |
| `clipContent`         | `bool`                 | `true`                                 | Clip to border radius          |

### Glass Effect Settings

Control the liquid glass appearance via `LiquidGlassSettings`. No extra import needed — it's re-exported from this package.

```dart
ApliGlasBar(
  items: items,
  currentIndex: _currentIndex,
  onTap: (index) => setState(() => _currentIndex = index),
  style: ApliGlasBarStyle(
    activeColor: Colors.blue,
    liquidGlassSettings: LiquidGlassSettings(
      thickness: 20.0,          // Glass layer thickness
      blur: 16.0,               // Background blur amount
      glassColor: Colors.white.withValues(alpha: 0.8), // Glass tint color
      lightIntensity: 0.6,      // Specular light brightness
      refractiveIndex: 1.5,     // Light refraction amount
    ),
  ),
);
```

| Property          | Type     | Default           | Description                             |
| ----------------- | -------- | ----------------- | --------------------------------------- |
| `thickness`       | `double` | `20.0`            | Thickness of the glass layer            |
| `blur`            | `double` | `16.0`            | Background blur intensity               |
| `glassColor`      | `Color`  | White 80% opacity | Tint color of the glass                 |
| `lightIntensity`  | `double` | `0.6`             | Brightness of the specular light effect |
| `refractiveIndex` | `double` | `1.5`             | How much light bends through the glass  |

## Requirements

- Flutter 3.32+
- Dart 3.10+

## Contributing

Contributions are welcome! Please open an issue or submit a pull request on [GitHub](https://github.com/erbolamm/apliarte-glass-theme).

## Autor

Javier Mateo (ApliArte) — [github.com/erbolamm](https://github.com/erbolamm)

## 💬 Una nota personal del autor / A personal note from the author

ℹ️ Nota: El texto siguiente es un mensaje personal del autor, escrito en varios idiomas para que pueda leerlo gente de todo el mundo. Esto no implica que el proyecto tenga soporte funcional completo en esos idiomas.

ℹ️ Note: The text below is a personal message from the author, written in several languages so people around the world can read it. This does not imply full multilingual feature support in those languages.

<details>
<summary>🇪🇸 Español</summary>

ApliArte Glass Theme nació de una idea simple: ¿por qué los componentes de Flutter tienen que ser siempre opacos y cuadrados? Quería crear una biblioteca de componentes con efecto cristal que fuera bonita, funcional y fácil de usar. Este proyecto es el resultado de meses de aprendizaje, prueba y error, y mucho cariño por el diseño. Lo comparto para que cualquier persona pueda darle a su app ese toque elegante sin tener que empezar desde cero. Si te sirve, úsalo, modifícalo, y si te gusta, comparte el proyecto. ¡Gracias por llegar hasta aquí!
</details>

<details>
<summary>🇬🇧 English</summary>

ApliArte Glass Theme was born from a simple idea: why do Flutter components always have to be opaque and square? I wanted to create a glass-effect component library that is beautiful, functional, and easy to use. This project is the result of months of learning, trial and error, and a deep love for design. I share it so anyone can give their app an elegant touch without starting from scratch. If it's useful to you, use it, modify it, and if you like it, share the project. Thank you for making it this far!
</details>

<details>
<summary>🇧🇷 Português</summary>

O ApliArte Glass Theme nasceu de uma ideia simples: por que os componentes do Flutter precisam ser sempre opacos e quadrados? Eu queria criar uma biblioteca de componentes com efeito de vidro que fosse bonita, funcional e fácil de usar. Este projeto é o resultado de meses de aprendizado, tentativa e erro, e muito amor pelo design. Compartilho para que qualquer pessoa possa dar ao seu aplicativo um toque elegante sem ter que começar do zero. Se for útil para você, use, modifique e, se gostar, compartilhe o projeto. Obrigado por chegar até aqui!
</details>

<details>
<summary>🇫🇷 Français</summary>

ApliArte Glass Theme est né d'une idée simple : pourquoi les composants Flutter doivent-ils toujours être opaques et carrés ? Je voulais créer une bibliothèque de composants avec un effet de verre qui soit belle, fonctionnelle et facile à utiliser. Ce projet est le résultat de mois d'apprentissage, d'essais et d'erreurs, et d'un profond amour du design. Je le partage pour que chacun puisse donner à son application une touche élégante sans avoir à repartir de zéro. Si cela vous est utile, utilisez-le, modifiez-le et, si vous l'aimez, partagez le projet. Merci d'être arrivé jusqu'ici !
</details>

<details>
<summary>🇩🇪 Deutsch</summary>

ApliArte Glass Theme entstand aus einer einfachen Idee: Warum müssen Flutter-Komponenten immer undurchsichtig und eckig sein? Ich wollte eine Bibliothek von Komponenten mit Glaseffekt erstellen, die schön, funktional und einfach zu bedienen ist. Dieses Projekt ist das Ergebnis monatelangen Lernens, Versuch und Irrtum und einer tiefen Liebe zum Design. Ich teile es, damit jeder seiner App eine elegante Note verleihen kann, ohne bei Null anfangen zu müssen. Wenn es dir nützt, verwende es, verändere es, und wenn es dir gefällt, teile das Projekt. Danke, dass du bis hierher gekommen bist!
</details>

<details>
<summary>🇮🇹 Italiano</summary>

ApliArte Glass Theme è nato da un'idea semplice: perché i componenti Flutter devono essere sempre opachi e squadrati? Volevo creare una libreria di componenti con effetto vetro che fosse bella, funzionale e facile da usare. Questo progetto è il risultato di mesi di apprendimento, tentativi ed errori, e di un grande amore per il design. Lo condivido affinché chiunque possa dare alla propria app un tocco elegante senza dover ricominciare da zero. Se ti è utile, usalo, modificalo e, se ti piace, condividi il progetto. Grazie per essere arrivato fino a qui!
</details>

## 💖 Apoya el proyecto

Herramienta gratuita y open source. Si te ahorra tiempo, un café ayuda a mantener el desarrollo.

| Plataforma | Enlace |
|-----------|--------|
| PayPal | [paypal.me/erbolamm](https://paypal.me/erbolamm) |
| Ko-fi | [ko-fi.com/C0C11TWR1K](https://ko-fi.com/C0C11TWR1K) |
| Twitch Tip | [streamelements.com/apliarte/tip](https://streamelements.com/apliarte/tip) |

🌐 [Sitio Oficial](https://apliarte.com) · 📦 [GitHub](https://github.com/erbolamm/apliarte-glass-theme)

## Licencia

MIT — © 2026 ApliArte

## About

A glass morphism UI component library for Flutter — bottom navigation bar, app bar, and cards with liquid glass effects.
