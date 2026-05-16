# ApliArte Glass Theme

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.32-blue.svg)](https://flutter.dev)
[![pub package](https://img.shields.io/pub/v/apliarte_glass_theme)](https://pub.dev/packages/apliarte_glass_theme)

**Drop-in replacement de Material 3.** Mismas clases `AppBar`, `Card`, `NavigationBar`… mismas APIs. Pero con **efecto glass morphism** que se adapta al tema de tu app.

```dart
// Un solo cambio en todo el proyecto:
import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';
```

Sin configurar nada más. Sin copiar setup de ningún lado. Sin refactorizar widgets.

## ✨ Componentes

| Componente | Clase (igual que Material 3) | Efecto |
|-----------|-----------------------------|--------|
| App Bar | `AppBar` | Toolbar de vidrio |
| Card | `Card` | Frosted glass |
| Bottom Navigation | `NavigationBar` | Vidrio + indicador deslizante con drag |
| Bottom App Bar | `BottomAppBar` | Barra inferior glass |
| Alert Dialog | `AlertDialog` | Diálogo modal glass |

## 📦 Instalación

```yaml
dependencies:
  apliarte_glass_theme: ^0.2.1
```

```bash
flutter pub get
```

## 🚀 Uso

```dart
import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';

// Todo funciona igual que con Material 3:
AppBar(title: const Text('Inicio'));
Card(child: const Text('Contenido'));
NavigationBar(
  destinations: const [
    NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),
  ],
  selectedIndex: 0,
  onDestinationSelected: (i) {},
);
```

Sin refactorizar. Sin config externa. Sin depender de ejemplos.

## 🌗 Dark/Light automático

Los colores del vidrio se derivan de `Theme.of(context).colorScheme`:
- **Modo claro**: vidrio sobre `colorScheme.surface`
- **Modo oscuro**: vidrio sobre `colorScheme.surface` con tinte cálido

Sin mantener una paleta paralela. Sin configuración extra.

## 🔥 Preset warm

Para un glass más cálido, rosado y elegante:

```dart
void main() {
  GlasConfig.useWarmPreset = true;
  runApp(const MyApp());
}
```

## ⚙️ Personalización opcional

Todo tiene valores por defecto que funcionan solos. Pero podés overridear:

```dart
GlasConfig.glassTintColor = const Color(0xFFFFF0F5);
GlasConfig.largeRadius = 32.0;  // cards, dialogs
GlasConfig.mediumRadius = 24.0; // nav bar, app bar
GlasConfig.glassBlur = 24.0;
```

Sin obligación. Solo si querés.

## 🔄 Cómo desinstalar

1. Sacar `apliarte_glass_theme` de `pubspec.yaml`
2. Volver a `import 'package:flutter/material.dart'`

**No tocás ni una línea de código de tu app.**

## 🔗 Enlaces

- 📦 [pub.dev](https://pub.dev/packages/apliarte_glass_theme)
- 🐙 [GitHub](https://github.com/erbolamm/apliarte-glass-theme)
- 🌐 [Web demo](https://erbolamm.github.io/apliarte-glass-theme/)
- 📖 [Documentación](https://pub.dev/documentation/apliarte_glass_theme/latest/)

## Autor

Javier Mateo (ApliArte) — [github.com/erbolamm](https://github.com/erbolamm)

## 💬 Una nota personal del autor

<details>
<summary>🇪🇸 Español</summary>

ApliArte Glass Theme nació de una idea simple: ¿por qué los componentes de Flutter tienen que ser siempre opacos? Quería crear una biblioteca drop-in que le diera a cualquier app ese toque elegante sin tener que cambiar nada del código. Si te sirve, úsalo, modificalo, compártelo. ¡Gracias por llegar hasta aquí!
</details>

<details>
<summary>🇬🇧 English</summary>

ApliArte Glass Theme was born from a simple idea: why do Flutter components always have to be opaque? I wanted to create a drop-in library that gives any app an elegant touch without changing a single line of code. If it's useful to you, use it, modify it, share it. Thank you for making it this far!
</details>

<details>
<summary>🇧🇷 Português</summary>

O ApliArte Glass Theme nasceu de uma ideia simples: por que os componentes do Flutter precisam ser sempre opacos? Queria criar uma biblioteca drop-in que desse a qualquer aplicativo um toque elegante sem precisar mudar nada no código. Se for útil, use, modifique, compartilhe. Obrigado por chegar até aqui!
</details>

<details>
<summary>🇫🇷 Français</summary>

ApliArte Glass Theme est né d'une idée simple : pourquoi les composants Flutter doivent-ils toujours être opaques ? Je voulais créer une bibliothèque drop-in qui donne à toute application une touche élégante sans rien changer au code. Si cela vous est utile, utilisez-le, modifiez-le, partagez-le. Merci d'être arrivé jusqu'ici !
</details>

<details>
<summary>🇩🇪 Deutsch</summary>

ApliArte Glass Theme entstand aus einer einfachen Idee: Warum müssen Flutter-Komponenten immer undurchsichtig sein? Ich wollte eine Drop-in-Bibliothek erstellen, die jeder App eine elegante Note verleiht, ohne eine Zeile Code zu ändern. Wenn es dir nützt, verwende es, verändere es, teile es. Danke, dass du bis hierher gekommen bist!
</details>

<details>
<summary>🇮🇹 Italiano</summary>

ApliArte Glass Theme è nato da un'idea semplice: perché i componenti Flutter devono essere sempre opachi? Volevo creare una libreria drop-in che dia a qualsiasi app un tocco elegante senza dover cambiare nulla nel codice. Se ti è utile, usalo, modificalo, condividilo. Grazie per essere arrivato fino a qui!
</details>

## 💖 Apoya el proyecto

Si te ahorra tiempo, un café ayuda a mantener el desarrollo.

| Plataforma | Enlace |
|-----------|--------|
| 💳 PayPal | [paypal.me/erbolamm](https://paypal.me/erbolamm) |
| ☕ Ko-fi | [ko-fi.com/C0C11TWR1K](https://ko-fi.com/C0C11TWR1K) |
| 📺 Twitch Tip | [streamelements.com/apliarte/tip](https://streamelements.com/apliarte/tip) |

## Licencia

MIT — © 2026 ApliArte

## About

ApliArte Glass Theme — drop-in replacement de Material 3 con efecto glass morphism para Flutter. v0.3.6. Publicado en pub.dev y GitHub. MIT.
