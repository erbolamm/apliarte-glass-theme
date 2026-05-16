## 0.3.9

* 🪟 **AppBar rediseñado**: ahora usa `BackdropFilter` + `ImageFilter.blur`
  real para el frosted glass, en vez de `LiquidGlass` con shaders. El efecto
  es más fiel al glass nativo de Flutter y funciona en todas las plataformas.
* ✨ Nuevos parámetros en `AppBar`: `blurSigma`, `bottomRadius`, `glassTint`.
* ⚙️ `GlasConfig.appBarBlurSigma`, `.appBarBottomRadius`, `.appBarGlassTint`.

## 0.3.8

* 📝 **Posicionamiento honesto**: ya no se describe como "drop-in replacement de
  Material" sino como "misma API, identidad visual propia". La compatibilidad es
  a nivel API, no a nivel apariencia visual.
* ✨ **Sistema de acento líquido**: `LiquidHighlightDecoration` + `LiquidIntensity`
  extraídos del NavigationBar como abstracción reutilizable para todos los
  componentes con distinta intensidad según jerarquía visual.
* ✨ **GlasConfig**: `liquidHighlightEnabled`, `liquidHighlightIntensity`,
  `liquidHighlightPreset` (subtle / balanced / expressive).
* 🎨 **NavigationBar**: refactorizado para usar `LiquidHighlightDecoration`.
* 🎨 **AppBar**: acento líquido sutil en borde inferior.
* 📝 pubspec: descripción actualizada.
* 📝 README: tabla con 8 componentes, badge Demo Web.

## 0.3.7

* ✨ **FloatingActionButton**: componente glass con soporte extended.
* ✨ **BottomSheet**: fondo glass con blur y borde superior.
* ✨ **Drawer**: panel lateral con efecto glass.
* 🐛 **AppBar**: respeta notch / status bar (MediaQuery.viewPadding.top).
* 🧪 Tests para GlasConfig (valores default, warm preset, overrides).
* 🧪 Tests de integración (flujo completo con todos los componentes).
* 🐛 **GlassLayer**: ghost shadow eliminado al scrollear.

## 0.3.5

* 🚀 Primer release publicado vía CI/CD con OIDC automático.
* CI/CD: dart-lang/setup-dart para OIDC + flutter-actions.

## 0.3.5

* 🚀 Primer release publicado vía CI/CD con OIDC automático.
* CI/CD: dart-lang/setup-dart para OIDC + flutter-actions.

## 0.3.3

* 🐛 **Card**: eliminada sombra duplicada (PhysicalModel + customShadows) que
  causaba rectángulos fantasma al hacer scroll. Ahora sombra única vía
  BoxDecoration.boxShadow + ClipRRect + GlassLayer.
* 🐛 **GlassLayer**: encapsulado en ClipRRect para evitar artefactos de
  LiquidGlass.withOwnLayer fuera del radio visual.
* 🐛 **AppBar**: `automaticallyImplyLeading` ahora funciona correctamente:
  DrawerButton si hay drawer, BackButton si se puede hacer pop, y
  leading explícito cuando se pasa.

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
