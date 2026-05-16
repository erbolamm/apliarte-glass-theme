import 'package:flutter/material.dart';

/// Intensidad del acento líquido.
///
/// Cada componente usa el nivel que corresponde a su jerarquía visual:
/// - [LiquidIntensity.subtle]: AppBar, fondo general
/// - [LiquidIntensity.soft]: Card, Dialog
/// - [LiquidIntensity.strong]: NavigationBar seleccionado
/// - [LiquidIntensity.maximum]: CTA, botón activo
enum LiquidIntensity {
  subtle,
  soft,
  strong,
  maximum;

  double get opacity {
    switch (this) {
      case LiquidIntensity.subtle:
        return 0.08;
      case LiquidIntensity.soft:
        return 0.15;
      case LiquidIntensity.strong:
        return 0.25;
      case LiquidIntensity.maximum:
        return 0.35;
    }
  }

  double get blurRadius {
    switch (this) {
      case LiquidIntensity.subtle:
        return 6;
      case LiquidIntensity.soft:
        return 8;
      case LiquidIntensity.strong:
        return 12;
      case LiquidIntensity.maximum:
        return 16;
    }
  }

  double get spreadRadius {
    switch (this) {
      case LiquidIntensity.subtle:
        return 0;
      case LiquidIntensity.soft:
        return 1;
      case LiquidIntensity.strong:
        return 2;
      case LiquidIntensity.maximum:
        return 3;
    }
  }
}

/// Decoración reutilizable que aplica el acento líquido/glow.
///
/// Es la misma técnica visual que usa NavigationBar en su indicador
/// seleccionado, pero parametrizada por intensidad para que cada
/// componente hable el mismo idioma visual con distinta jerarquía.
///
 /// Uso:
/// ```dart
 /// Container(
 ///   decoration: LiquidHighlightDecoration(
 ///     color: theme.colorScheme.primary,
 ///     intensity: LiquidIntensity.strong,
 ///   ).build(),
 /// )
 /// ```
class LiquidHighlightDecoration {
  final Color color;
  final LiquidIntensity intensity;
  final double? customOpacity;
  final double? customBlur;
  final double? customSpread;
  final BorderRadius? borderRadius;
  final bool showBorder;

  const LiquidHighlightDecoration({
    required this.color,
    this.intensity = LiquidIntensity.strong,
    this.customOpacity,
    this.customBlur,
    this.customSpread,
    this.borderRadius,
    this.showBorder = true,
  });

  /// Construye el [BoxDecoration] con el gradiente y sombras del acento líquido.
  BoxDecoration build() {
    final opacity = customOpacity ?? intensity.opacity;
    final blur = customBlur ?? intensity.blurRadius;
    final spread = customSpread ?? intensity.spreadRadius;

    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color.withValues(alpha: opacity),
          color.withValues(alpha: opacity * 0.4),
          color.withValues(alpha: opacity * 0.1),
        ],
        stops: const [0.0, 0.4, 1.0],
      ),
      border: showBorder
          ? Border.all(
              color: color.withValues(alpha: opacity * 0.5),
              width: 1.2,
            )
          : null,
      borderRadius: borderRadius,
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: opacity * 0.6),
          blurRadius: blur,
          offset: Offset(0, spread * 0.5),
        ),
        BoxShadow(
          color: color.withValues(alpha: opacity * 0.15),
          blurRadius: blur * 0.6,
          offset: Offset(-spread * 0.5, -spread * 0.3),
        ),
      ],
    );
  }

  /// Atajo para crear un acento fuerte (como el NavigationBar seleccionado).
  factory LiquidHighlightDecoration.strong(Color color, {BorderRadius? borderRadius}) =>
      LiquidHighlightDecoration(
    color: color,
    intensity: LiquidIntensity.strong,
    borderRadius: borderRadius,
  );

  /// Atajo para crear un acento suave (como Card al hacer hover).
  factory LiquidHighlightDecoration.soft(Color color, {BorderRadius? borderRadius}) =>
      LiquidHighlightDecoration(
    color: color,
    intensity: LiquidIntensity.soft,
    borderRadius: borderRadius,
  );

  /// Atajo para crear un acento sutil (como AppBar).
  factory LiquidHighlightDecoration.subtle(Color color, {BorderRadius? borderRadius}) =>
      LiquidHighlightDecoration(
    color: color,
    intensity: LiquidIntensity.subtle,
    borderRadius: borderRadius,
    showBorder: false,
  );
}

/// Widget que envuelve a un child con el acento líquido.
///
/// Alternativa a [LiquidHighlightDecoration] cuando necesitás
/// que el glow esté por encima o por debajo del contenido.
class LiquidHighlight extends StatelessWidget {
  final Widget child;
  final Color color;
  final LiquidIntensity intensity;
  final BorderRadius? borderRadius;

  const LiquidHighlight({
    super.key,
    required this.child,
    required this.color,
    this.intensity = LiquidIntensity.strong,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: LiquidHighlightDecoration(
        color: color,
        intensity: intensity,
        borderRadius: borderRadius,
      ).build(),
      child: child,
    );
  }
}
