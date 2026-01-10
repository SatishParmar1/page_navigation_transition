import 'package:flutter/material.dart';
import 'dart:math' as math;

/// 3D Cube horizontal rotation transition
class CubeHorizontalPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a cube horizontal page transition
  CubeHorizontalPageTransition({
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
                final angle = (1.0 - curvedAnimation.value) * (math.pi / 2);

                return Transform(
                  alignment: Alignment.centerRight,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(-angle),
                  child: child,
                );
              },
              child: child,
            );
          },
        );
}

/// 3D Cube vertical rotation transition
class CubeVerticalPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a cube vertical page transition
  CubeVerticalPageTransition({
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
                final angle = (1.0 - curvedAnimation.value) * (math.pi / 2);

                return Transform(
                  alignment: Alignment.bottomCenter,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(angle),
                  child: child,
                );
              },
              child: child,
            );
          },
        );
}

/// Inside cube rotation transition
class InsideCubePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Whether to rotate horizontally
  final bool horizontal;

  /// Creates an inside cube page transition
  InsideCubePageTransition({
    required this.page,
    this.horizontal = true,
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
                final angle = (1.0 - curvedAnimation.value) * (-math.pi / 2);

                final matrix = Matrix4.identity()..setEntry(3, 2, 0.001);
                if (horizontal) {
                  matrix.rotateY(angle);
                } else {
                  matrix.rotateX(-angle);
                }

                return Transform(
                  alignment: horizontal ? Alignment.centerLeft : Alignment.topCenter,
                  transform: matrix,
                  child: child,
                );
              },
              child: child,
            );
          },
        );
}

/// 3D Card flip transition
class CardFlipPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Whether to flip horizontally (true) or vertically (false)
  final bool horizontal;

  /// Creates a card flip page transition
  CardFlipPageTransition({
    required this.page,
    this.horizontal = true,
    Duration duration = const Duration(milliseconds: 600),
    Duration reverseDuration = const Duration(milliseconds: 600),
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

                Matrix4 transform = Matrix4.identity()
                  ..setEntry(3, 2, 0.002);

                if (horizontal) {
                  transform.rotateY(angle);
                } else {
                  transform.rotateX(angle);
                }

                return Transform(
                  alignment: Alignment.center,
                  transform: transform,
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

/// 3D Carousel rotation transition
class CarouselPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a carousel page transition
  CarouselPageTransition({
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
                final size = MediaQuery.of(context).size;
                final angle = (1.0 - curvedAnimation.value) * (math.pi / 3);
                final translateX = (1.0 - curvedAnimation.value) * size.width * 0.5;

                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..translate(translateX, 0.0, 0.0)
                    ..rotateY(-angle),
                  child: Opacity(
                    opacity: curvedAnimation.value.clamp(0.3, 1.0),
                    child: child,
                  ),
                );
              },
              child: child,
            );
          },
        );
}

/// Cover flow style transition
class CoverFlowPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a cover flow page transition
  CoverFlowPageTransition({
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
                final size = MediaQuery.of(context).size;
                final angle = (1.0 - curvedAnimation.value) * (math.pi / 4);
                final translateX = (1.0 - curvedAnimation.value) * size.width;
                final scale = 0.7 + (curvedAnimation.value * 0.3);

                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..translate(translateX, 0.0, 0.0)
                    ..rotateY(-angle)
                    ..scale(scale),
                  child: child,
                );
              },
              child: child,
            );
          },
        );
}

/// Cylinder wrap transition
class CylinderWrapPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a cylinder wrap page transition
  CylinderWrapPageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 600),
    Duration reverseDuration = const Duration(milliseconds: 600),
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
                final scale = 0.5 + (curvedAnimation.value * 0.5);

                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.002)
                    ..rotateY(angle)
                    ..scale(scale),
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

/// Perspective zoom transition with depth
class PerspectiveZoomPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a perspective zoom page transition
  PerspectiveZoomPageTransition({
    required this.page,
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
                final scale = Tween<double>(
                  begin: 0.5,
                  end: 1.0,
                ).evaluate(curvedAnimation);

                final translateZ = Tween<double>(
                  begin: -500.0,
                  end: 0.0,
                ).evaluate(curvedAnimation);

                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..translate(0.0, 0.0, translateZ)
                    ..scale(scale),
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

/// Multi-layer parallax transition
class ParallaxDepthPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a parallax depth page transition
  ParallaxDepthPageTransition({
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
                final size = MediaQuery.of(context).size;
                final translateX = (1.0 - curvedAnimation.value) * size.width;
                final scale = 0.8 + (curvedAnimation.value * 0.2);
                final translateZ = (1.0 - curvedAnimation.value) * -200;

                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..translate(translateX, 0.0, translateZ)
                    ..scale(scale),
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

/// Fold page transition (book-style)
class FoldPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Number of folds
  final int folds;

  /// Creates a fold page transition
  FoldPageTransition({
    required this.page,
    this.folds = 3,
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
                  alignment: Alignment.centerLeft,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(-angle),
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
