import 'package:flutter/foundation.dart' show internal;
import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';

const Duration _pressFeedbackDuration = Duration(milliseconds: 120);
const Curve _pressFeedbackCurve = material.Curves.easeOutCubic;
const double _defaultScale = 1.0;

/// Internal visual-only wrapper for pressed-state scale feedback.
///
/// Hit testing, semantics, focus, and gestures stay on the original Material
/// control. This helper only listens to the shared [statesController] and
/// animates the child when the owner reports `WidgetState.pressed`.
@internal
Widget buildPressFeedback({
  required WidgetStatesController statesController,
  required bool enabled,
  required double pressedScale,
  required Widget child,
}) {
  return _PressFeedback(
    statesController: statesController,
    enabled: enabled,
    pressedScale: pressedScale,
    child: child,
  );
}

@internal
Widget buildButtonPressFeedback({
  required WidgetStatesController? statesController,
  required bool enabled,
  required double pressedScale,
  required Widget Function(WidgetStatesController statesController) builder,
}) {
  return _ButtonPressFeedback(
    statesController: statesController,
    enabled: enabled,
    pressedScale: pressedScale,
    builder: builder,
  );
}

class _PressFeedback extends StatefulWidget {
  const _PressFeedback({
    required this.statesController,
    required this.enabled,
    required this.pressedScale,
    required this.child,
  });

  final WidgetStatesController statesController;
  final bool enabled;
  final double pressedScale;
  final Widget child;

  @override
  State<_PressFeedback> createState() => _PressFeedbackState();
}

class _PressFeedbackState extends State<_PressFeedback> {
  late bool _isPressed = _readPressed(widget.statesController);

  @override
  void initState() {
    super.initState();
    widget.statesController.addListener(_handleStatesChanged);
  }

  @override
  void didUpdateWidget(covariant _PressFeedback oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.statesController == widget.statesController) {
      return;
    }

    oldWidget.statesController.removeListener(_handleStatesChanged);
    widget.statesController.addListener(_handleStatesChanged);
    _syncPressedState();
  }

  @override
  void dispose() {
    widget.statesController.removeListener(_handleStatesChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return material.AnimatedScale(
      scale: widget.enabled && _isPressed ? widget.pressedScale : _defaultScale,
      duration: _pressFeedbackDuration,
      curve: _pressFeedbackCurve,
      child: widget.child,
    );
  }

  void _handleStatesChanged() {
    _syncPressedState();
  }

  void _syncPressedState() {
    final nextPressed = _readPressed(widget.statesController);

    if (nextPressed == _isPressed) {
      return;
    }

    setState(() {
      _isPressed = nextPressed;
    });
  }

  bool _readPressed(WidgetStatesController controller) {
    return controller.value.contains(WidgetState.pressed);
  }
}

class _ButtonPressFeedback extends StatefulWidget {
  const _ButtonPressFeedback({
    required this.statesController,
    required this.enabled,
    required this.pressedScale,
    required this.builder,
  });

  final WidgetStatesController? statesController;
  final bool enabled;
  final double pressedScale;
  final Widget Function(WidgetStatesController statesController) builder;

  @override
  State<_ButtonPressFeedback> createState() => _ButtonPressFeedbackState();
}

class _ButtonPressFeedbackState extends State<_ButtonPressFeedback> {
  WidgetStatesController? _internalController;

  @override
  void didUpdateWidget(covariant _ButtonPressFeedback oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.statesController == null && widget.statesController != null) {
      _disposeInternalController();
    }
  }

  @override
  void dispose() {
    _disposeInternalController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.statesController ?? _ensureInternalController();

    return buildPressFeedback(
      statesController: controller,
      enabled: widget.enabled,
      pressedScale: widget.pressedScale,
      child: widget.builder(controller),
    );
  }

  WidgetStatesController _ensureInternalController() {
    return _internalController ??= WidgetStatesController();
  }

  void _disposeInternalController() {
    _internalController?.dispose();
    _internalController = null;
  }
}
