import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/enums.dart';

/// Rotation transition on Z-axis (2D rotation)
class RotationPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The initial rotation in turns (1.0 = 360 degrees)
  final double beginTurns;

  /// The alignment of the rotation
  final Alignment alignment;

  /// Creates a rotation page transition
  RotationPageTransition({
    required this.page,
    this.beginTurns = 1.0,
    this.alignment = Alignment.center,
    Duration duration = const Duration(milliseconds: 400),
    Duration reverseDuration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeInOut,
    Curve reverseCurve = Curves.easeInOut,
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
              reverseCurve: reverseCurve,
            );

            return RotationTransition(
              turns: Tween<double>(
                begin: beginTurns,
                end: 0.0,
              ).animate(curvedAnimation),
              alignment: alignment,
              child: child,
            );
          },
        );
}

/// Flip horizontal transition (rotate on X-axis)
class FlipHorizontalPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a flip horizontal page transition
  FlipHorizontalPageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 500),
    Duration reverseDuration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOut,
    Curve reverseCurve = Curves.easeInOut,
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
              reverseCurve: reverseCurve,
            );

            return AnimatedBuilder(
              animation: curvedAnimation,
              builder: (context, _) {
                final angle = (1.0 - curvedAnimation.value) * math.pi;
                final isShowingFront = curvedAnimation.value >= 0.5;

                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(angle),
                  child: isShowingFront
                      ? child
                      : Container(color: Colors.transparent),
                );
              },
              child: child,
            );
          },
        );
}

/// Flip vertical transition (rotate on Y-axis)
class FlipVerticalPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a flip vertical page transition
  FlipVerticalPageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 500),
    Duration reverseDuration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOut,
    Curve reverseCurve = Curves.easeInOut,
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
              reverseCurve: reverseCurve,
            );

            return AnimatedBuilder(
              animation: curvedAnimation,
              builder: (context, _) {
                final angle = (1.0 - curvedAnimation.value) * math.pi;
                final isShowingFront = curvedAnimation.value >= 0.5;

                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(angle),
                  child: isShowingFront
                      ? child
                      : Container(color: Colors.transparent),
                );
              },
              child: child,
            );
          },
        );
}

/// Rotation with fade transition
class RotationFadePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The initial rotation in turns
  final double beginTurns;

  /// The alignment of the rotation
  final Alignment alignment;

  /// Creates a rotation with fade page transition
  RotationFadePageTransition({
    required this.page,
    this.beginTurns = 0.5,
    this.alignment = Alignment.center,
    Duration duration = const Duration(milliseconds: 400),
    Duration reverseDuration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeInOut,
    Curve reverseCurve = Curves.easeInOut,
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
              reverseCurve: reverseCurve,
            );

            return FadeTransition(
              opacity: curvedAnimation,
              child: RotationTransition(
                turns: Tween<double>(
                  begin: beginTurns,
                  end: 0.0,
                ).animate(curvedAnimation),
                alignment: alignment,
                child: child,
              ),
            );
          },
        );
}

/// Rotation with scale transition
class RotationScalePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The initial rotation in turns
  final double beginTurns;

  /// The initial scale value
  final double beginScale;

  /// The alignment of the transformation
  final Alignment alignment;

  /// Creates a rotation with scale page transition
  RotationScalePageTransition({
    required this.page,
    this.beginTurns = 1.0,
    this.beginScale = 0.0,
    this.alignment = Alignment.center,
    Duration duration = const Duration(milliseconds: 400),
    Duration reverseDuration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeInOut,
    Curve reverseCurve = Curves.easeInOut,
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
              reverseCurve: reverseCurve,
            );

            return ScaleTransition(
              scale: Tween<double>(
                begin: beginScale,
                end: 1.0,
              ).animate(curvedAnimation),
              alignment: alignment,
              child: RotationTransition(
                turns: Tween<double>(
                  begin: beginTurns,
                  end: 0.0,
                ).animate(curvedAnimation),
                alignment: alignment,
                child: child,
              ),
            );
          },
        );
}

/// Rotation with scale and fade transition
class RotationScaleFadePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The initial rotation in turns
  final double beginTurns;

  /// The initial scale value
  final double beginScale;

  /// Creates a rotation with scale and fade page transition
  RotationScaleFadePageTransition({
    required this.page,
    this.beginTurns = 0.5,
    this.beginScale = 0.5,
    Duration duration = const Duration(milliseconds: 400),
    Duration reverseDuration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeInOut,
    Curve reverseCurve = Curves.easeInOut,
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
              reverseCurve: reverseCurve,
            );

            return FadeTransition(
              opacity: curvedAnimation,
              child: ScaleTransition(
                scale: Tween<double>(
                  begin: beginScale,
                  end: 1.0,
                ).animate(curvedAnimation),
                child: RotationTransition(
                  turns: Tween<double>(
                    begin: beginTurns,
                    end: 0.0,
                  ).animate(curvedAnimation),
                  child: child,
                ),
              ),
            );
          },
        );
}

/// Spin transition (full rotation with optional bouncing)
class SpinPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Number of full rotations
  final int rotations;

  /// Whether to use elastic curve
  final bool elastic;

  /// Creates a spin page transition
  SpinPageTransition({
    required this.page,
    this.rotations = 1,
    this.elastic = false,
    Duration duration = const Duration(milliseconds: 500),
    Duration reverseDuration = const Duration(milliseconds: 500),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: elastic ? Curves.elasticOut : Curves.easeInOut,
              reverseCurve: Curves.easeIn,
            );

            return ScaleTransition(
              scale: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(curvedAnimation),
              child: RotationTransition(
                turns: Tween<double>(
                  begin: rotations.toDouble(),
                  end: 0.0,
                ).animate(curvedAnimation),
                child: child,
              ),
            );
          },
        );
}

/// 3D tilt rotation transition
class TiltRotationPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The axis to rotate on
  final RotationAxis axis;

  /// The maximum tilt angle in radians
  final double maxTilt;

  /// Creates a tilt rotation page transition
  TiltRotationPageTransition({
    required this.page,
    this.axis = RotationAxis.y,
    this.maxTilt = math.pi / 4,
    Duration duration = const Duration(milliseconds: 400),
    Duration reverseDuration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeInOut,
    Curve reverseCurve = Curves.easeInOut,
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
              reverseCurve: reverseCurve,
            );

            return AnimatedBuilder(
              animation: curvedAnimation,
              builder: (context, _) {
                final angle = (1.0 - curvedAnimation.value) * maxTilt;
                Matrix4 transform = Matrix4.identity()..setEntry(3, 2, 0.001);

                switch (axis) {
                  case RotationAxis.x:
                    transform.rotateX(angle);
                    break;
                  case RotationAxis.y:
                    transform.rotateY(angle);
                    break;
                  case RotationAxis.z:
                    transform.rotateZ(angle);
                    break;
                }

                return Transform(
                  alignment: Alignment.center,
                  transform: transform,
                  child: Opacity(
                    opacity: curvedAnimation.value,
                    child: child,
                  ),
                );
              },
              child: child,
            );
          },
        );
}

/// Door open/close rotation transition
class DoorRotationPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Whether the door opens from the left
  final bool openFromLeft;

  /// Creates a door rotation page transition
  DoorRotationPageTransition({
    required this.page,
    this.openFromLeft = true,
    Duration duration = const Duration(milliseconds: 500),
    Duration reverseDuration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeInOut,
    Curve reverseCurve = Curves.easeInOut,
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
              reverseCurve: reverseCurve,
            );

            return AnimatedBuilder(
              animation: curvedAnimation,
              builder: (context, _) {
                final angle = (1.0 - curvedAnimation.value) * (math.pi / 2);

                return Transform(
                  alignment: openFromLeft ? Alignment.centerLeft : Alignment.centerRight,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(openFromLeft ? -angle : angle),
                  child: Opacity(
                    opacity: curvedAnimation.value,
                    child: child,
                  ),
                );
              },
              child: child,
            );
          },
        );
}
