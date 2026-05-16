# ApliArte Glass Theme

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.32-blue.svg)](https://flutter.dev)
[![pub package](https://img.shields.io/pub/v/apliarte_glass_theme)](https://pub.dev/packages/apliarte_glass_theme)

**Drop-in replacement for Material 3 widgets.** Mismas clases, mismas APIs — pero con efecto vidrio (glass morphism).

```dart
// Antes (Material puro):
import 'package:flutter/material.dart';

// Ahora (con vidrio):
import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';
```

Sin cambiar el nombre de las clases. Sin cambiar los parámetros. Sin cambiar nada del código de tu app.

## Componentes

| Componente | Clase (igual que Material) | Efecto |
|-----------|----------------------------|--------|
| App Bar | `AppBar` | Vidrio en toolbar |
| Card | `Card` | Vidrio con borde |
| Bottom Navigation | `NavigationBar` | Vidrio + indicador deslizante con drag |
| Bottom App Bar | `BottomAppBar` | Vidrio en barra inferior |
| Alert Dialog | `AlertDialog` | Vidrio en diálogo modal |
| *Más pronto* | | ListTile, FAB, BottomSheet... |

## Instalación

```yaml
dependencies:
  apliarte_glass_theme: ^0.1.0
```

```bash
flutter pub get
```

## Cómo usarlo

```dart
import 'package:apliarte_glass_theme/apliarte_glass_theme.dart';

// ✅ Todo funciona igual que con Material:
AppBar(title: const Text('Título'));
Card(child: const Text('Contenido'));
NavigationBar(
  destinations: [...],
  selectedIndex: 0,
  onDestinationSelected: (i) {},
);
```

## Cómo desinstalarlo (sin tocar código)

1. Borrar `glas_config.dart`
2. Sacar `apliarte_glass_theme` de `pubspec.yaml`
3. Volver a `import 'package:flutter/material.dart'`

No tocas ni una línea de código de tu app.

## Configuración

Editar `glas_config.dart` para ajustar colores, blur, grosor del vidrio y más.
Los valores se adaptan automáticamente a tema claro y oscuro.

```dart
// Ejemplo: personalizar desde tu app
void main() {
  GlasConfig.blur = 24;
  GlasConfig.lightGlassColor = Color(0xCCF0F0FF);
  GlasConfig.darkGlassColor = Color(0xCC1A1A2E);
  runApp(const MyApp());
}
```

## Dark/Light

Todos los componentes se adaptan automáticamente al `ThemeMode` de tu app:
- **Modo claro**: vidrio blanco semitransparente
- **Modo oscuro**: vidrio oscuro semitransparente

## Requisitos

- Flutter 3.32+
- Dart 3.10+

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

Drop-in replacement for Material 3 Flutter widgets with liquid glass morphism effects. AppBar, Card, NavigationBar, BottomAppBar, and AlertDialog with automatic dark/light adaptation.
