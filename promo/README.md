# Promo — ApliArte Glass Theme

Assets de marketing para el paquete `apliarte_glass_theme`.

## 📁 Estructura

```
promo/
├── README.md                    ← Este archivo
├── brand-spec.md                ← Colores, tipografía, timing del glass
├── narration.json               ← Guion para narración (6 idiomas)
├── translations.json            ← Traducciones del contenido
│
├── assets/                      ← Para logos, iconos (vacío)
│
├── screenshots/
│   ├── browser/                 ← Capturas de la web Flutter real
│   │   ├── desktop-full.png     → Escritorio 1440×900
│   │   ├── mobile-iphone.png    → Mobile 390×844
│   │   ├── tablet-ipad.png      → Tablet 1024×1366
│   │   └── ... (componentes individuales HTML)
│   ├── ios/                     ← (pendiente)
│   └── android/                 ← (pendiente)
│
├── videos/
│   ├── promo-vertical.mp4       → TikTok/Reels/Shorts (1080×1920, 22s, 650KB)
│   └── promo-horizontal.mp4     → YouTube (1920×1080, 30s, 813KB)
│
└── source/                      ← Archivos fuente para regenerar
    ├── vertical-promo.html      → Video vertical (animado con React)
    ├── horizontal-promo.html    → Video horizontal (animado con React)
    ├── screenshots.html         → HTML mockups de componentes
    ├── capture-screenshots.cjs  → Script Playwright para capturar
    └── capture-flutter-screenshots.cjs → Capturas desde la web Flutter real
```

## 🎬 Para qué red social usar cada video

| Video | Resolución | Duración | Red social |
|-------|-----------|----------|-----------|
| `promo-vertical.mp4` | 1080×1920 | 22s | TikTok, Instagram Reels, YouTube Shorts |
| `promo-horizontal.mp4` | 1920×1080 | 30s | YouTube, Facebook, X/Twitter |

## 🎵 Cómo agregar música (tus MP3 de Suno)

1. Creá una carpeta `promo/music/` y poné tus MP3 ahí:
   ```
   promo/music/
   ├── background-vertical.mp3
   └── background-horizontal.mp3
   ```

2. Usá `ffmpeg` para mezclar video + música:
   ```bash
   # Vertical con música
   ffmpeg -i promo/videos/promo-vertical.mp4 \
          -i promo/music/background-vertical.mp3 \
          -c:v copy -c:a aac -shortest \
          promo/videos/promo-vertical-con-musica.mp4

   # Horizontal con música
   ffmpeg -i promo/videos/promo-horizontal.mp4 \
          -i promo/music/background-horizontal.mp3 \
          -c:v copy -c:a aac -shortest \
          promo/videos/promo-horizontal-con-musica.mp4
   ```

3. Si querés agregar narración también:
   ```bash
   bash design-engine/scripts/generate-narration.sh \
     promo/narration.json \
     promo/narration/

   bash design-engine/scripts/mix-narration.sh \
     promo/videos/ \
     promo/narration/ \
     promo/final/
   ```

## 🔄 Cómo regenerar todo

### Screenshots desde la web Flutter real
```bash
# Primero buildear la web demo
cd example && flutter build web --no-tree-shake-icons

# Después capturar
NODE_PATH=$(npm root -g) node promo/source/capture-flutter-screenshots.cjs
```

### Videos
```bash
# Vertical (22s, 1080×1920)
NODE_PATH=$(npm root -g) node ../../design-engine/scripts/render-video.cjs \
  promo/source/vertical-promo.html \
  --duration=22 --width=1080 --height=1920

# Horizontal (30s, 1920×1080)
NODE_PATH=$(npm root -g) node ../../design-engine/scripts/render-video.cjs \
  promo/source/horizontal-promo.html \
  --duration=30 --width=1920 --height=1080
```

### Multi-idioma (6 idiomas)
```bash
NODE_PATH=$(npm root -g) node ../../design-engine/scripts/render-all-langs.cjs \
  --template=promo/source/vertical-promo.html \
  --translations=promo/translations.json \
  --outdir=promo/videos/ \
  --duration=22 --width=1080 --height=1920
```

## 📋 Estado

| Asset | Estado |
|-------|--------|
| Screenshots web real (Flutter) | ✅ 3 capturas (desktop, mobile, tablet) |
| Screenshots componentes HTML | ✅ 17 capturas individuales |
| Video vertical 22s | ✅ 650KB |
| Video horizontal 30s | ✅ 813KB |
| Brand spec | ✅ Colores, tipografía, timing |
| Traducciones 6 idiomas | ✅ narration.json + translations.json |
| Música de fondo | ⬜ Agregar tus MP3 de Suno en `promo/music/` |
| Narración TTS | ⬜ Ejecutar generate-narration.sh |
