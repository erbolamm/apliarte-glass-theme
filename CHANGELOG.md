## 0.3.2

* README: nueva sección "Apoya" con PayPal, Ko-fi, Twitch Tip.
* README: nueva sección "Comparte" con Twitter, LinkedIn, Reddit, WhatsApp.

## 0.3.1

* NavigationBar indicator más visible.
* pubspec.yaml: license: MIT explícito.
* Defaults mejorados para contraste.

## 0.3.0

* **Arquitectura autosuficiente**: el paquete funciona sin configuración externa.
  Solo instalá e importá — sin copiar setup de ningún lado.
* **Colores derivados del theme**: glass, bordes y sombras se resuelven desde
  `Theme.of(context).colorScheme`. Sin paleta paralela que mantener.
* **Preset warm**: `GlasConfig.useWarmPreset = true` para un glass cálido y rosado.
* **Personalización opcional**: `GlasConfig.glassTintColor`, `largeRadius`,
  `mediumRadius`, `glassBlur`, `borderOpacity`, `highlightIntensity`, etc.
* **NavigationBar**: indicador deslizante con colores del theme.
* **Dark/light automático**: sin configuración, sin ejemplos externos.

## 0.2.1

* Glass color más visible: tinte azul sutil (`0xCCE0ECFF`) en vez de blanco puro.
* Blur aumentado a 20px para efecto más notorio.

## 0.2.0

* **Drop-in replacement** de Material 3: mismas clases, mismas APIs.
* `AppBar`, `Card`, `NavigationBar`, `BottomAppBar`, `AlertDialog`.
* `glas_config.dart`: configuración central.
* Dark/light automático.

## 0.1.0

* Initial release.
* Forked from liquid_glass_bar.
* Glass morphism bottom navigation bar.
