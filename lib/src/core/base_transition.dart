import 'package:flutter/material.dart';

/// Base class for all page transitions
/// 
/// This provides common functionality and configuration options
/// that are shared across all transition types.
abstract class BasePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Duration of the transition animation
  final Duration duration;

  /// Duration of the reverse transition animation
  final Duration reverseDuration;

  /// The curve to use for the forward animation
  final Curve curve;

  /// The curve to use for the reverse animation
  final Curve reverseCurve;

  /// Whether to maintain state when this route is inactive
  final bool maintainStateData;

  /// Whether this route is a full-screen dialog
  final bool fullscreenDialogData;

  /// Whether the route obscures previous routes when active
  final bool opaqueData;

  /// Whether to allow the route to be dismissed by tapping the barrier
  final bool barrierDismissibleData;

  /// The color of the barrier
  final Color? barrierColorData;

  /// The semantic label for the barrier
  final String? barrierLabelData;

  /// Creates a base page transition
  BasePageTransition({
    required this.page,
    this.duration = const Duration(milliseconds: 300),
    this.reverseDuration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.reverseCurve = Curves.easeInOut,
    this.maintainStateData = true,
    this.fullscreenDialogData = false,
    this.opaqueData = true,
    this.barrierDismissibleData = false,
    this.barrierColorData,
    this.barrierLabelData,
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          maintainState: maintainStateData,
          fullscreenDialog: fullscreenDialogData,
          opaque: opaqueData,
          barrierDismissible: barrierDismissibleData,
          barrierColor: barrierColorData,
          barrierLabel: barrierLabelData,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Subclasses should override this
            return child;
          },
        );

  /// Creates a curved animation from the given animation
  Animation<double> createCurvedAnimation(
    Animation<double> animation, {
    Curve? forwardCurve,
    Curve? reverseCurve,
  }) {
    return CurvedAnimation(
      parent: animation,
      curve: forwardCurve ?? curve,
      reverseCurve: reverseCurve ?? this.reverseCurve,
    );
  }
}

/// Mixin providing common animation helpers
mixin TransitionAnimationMixin {
  /// Creates an offset tween for slide animations
  Tween<Offset> createSlideTween({
    required Offset begin,
    Offset end = Offset.zero,
  }) {
    return Tween<Offset>(begin: begin, end: end);
  }

  /// Creates a double tween for fade/scale animations
  Tween<double> createDoubleTween({
    required double begin,
    double end = 1.0,
  }) {
    return Tween<double>(begin: begin, end: end);
  }

  /// Creates a rotation tween
  Tween<double> createRotationTween({
    required double beginAngle,
    double endAngle = 0.0,
  }) {
    return Tween<double>(begin: beginAngle, end: endAngle);
  }

  /// Creates a scale tween
  Tween<double> createScaleTween({
    double begin = 0.0,
    double end = 1.0,
  }) {
    return Tween<double>(begin: begin, end: end);
  }

  /// Converts degrees to radians
  double degreesToRadians(double degrees) {
    return degrees * (3.14159265359 / 180);
  }
}

/// Configuration class for transition customization
class TransitionConfig {
  /// Duration of the transition
  final Duration duration;

  /// Reverse duration of the transition
  final Duration reverseDuration;

  /// Forward animation curve
  final Curve curve;

  /// Reverse animation curve
  final Curve reverseCurve;

  /// Whether to enable haptic feedback
  final bool enableHaptics;

  /// Whether to use reduced motion settings
  final bool respectReducedMotion;

  /// Creates a transition configuration
  const TransitionConfig({
    this.duration = const Duration(milliseconds: 300),
    this.reverseDuration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.reverseCurve = Curves.easeInOut,
    this.enableHaptics = false,
    this.respectReducedMotion = true,
  });

  /// Default configuration
  static const TransitionConfig defaultConfig = TransitionConfig();

  /// Fast configuration
  static const TransitionConfig fast = TransitionConfig(
    duration: Duration(milliseconds: 150),
    reverseDuration: Duration(milliseconds: 150),
    curve: Curves.easeOut,
  );

  /// Slow configuration
  static const TransitionConfig slow = TransitionConfig(
    duration: Duration(milliseconds: 500),
    reverseDuration: Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  );

  /// Spring-like configuration
  static const TransitionConfig spring = TransitionConfig(
    duration: Duration(milliseconds: 400),
    reverseDuration: Duration(milliseconds: 400),
    curve: Curves.elasticOut,
    reverseCurve: Curves.easeIn,
  );

  /// Bouncy configuration
  static const TransitionConfig bouncy = TransitionConfig(
    duration: Duration(milliseconds: 500),
    reverseDuration: Duration(milliseconds: 300),
    curve: Curves.bounceOut,
    reverseCurve: Curves.easeIn,
  );

  /// Creates a copy with modified values
  TransitionConfig copyWith({
    Duration? duration,
    Duration? reverseDuration,
    Curve? curve,
    Curve? reverseCurve,
    bool? enableHaptics,
    bool? respectReducedMotion,
  }) {
    return TransitionConfig(
      duration: duration ?? this.duration,
      reverseDuration: reverseDuration ?? this.reverseDuration,
      curve: curve ?? this.curve,
      reverseCurve: reverseCurve ?? this.reverseCurve,
      enableHaptics: enableHaptics ?? this.enableHaptics,
      respectReducedMotion: respectReducedMotion ?? this.respectReducedMotion,
    );
  }
}
