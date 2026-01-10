import 'package:flutter/material.dart';
import '../core/enums.dart';

/// Simple fade transition
class FadePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a fade page transition
  FadePageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
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
              child: child,
            );
          },
        );
}

/// Fade with scale transition
class FadeScalePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The initial scale of the page
  final double beginScale;

  /// The alignment of the scale transformation
  final Alignment scaleAlignment;

  /// Creates a fade with scale page transition
  FadeScalePageTransition({
    required this.page,
    this.beginScale = 0.8,
    this.scaleAlignment = Alignment.center,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
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
                alignment: scaleAlignment,
                child: child,
              ),
            );
          },
        );
}

/// Fade with rotation transition
class FadeRotationPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The initial rotation in turns (1.0 = 360 degrees)
  final double beginTurns;

  /// The alignment of the rotation
  final Alignment rotationAlignment;

  /// Creates a fade with rotation page transition
  FadeRotationPageTransition({
    required this.page,
    this.beginTurns = 0.5,
    this.rotationAlignment = Alignment.center,
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
                alignment: rotationAlignment,
                child: child,
              ),
            );
          },
        );
}

/// Fade with slide transition
class FadeSlidePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The direction from which the page slides
  final SlideDirection direction;

  /// The distance of the slide (0.0 to 1.0)
  final double slideDistance;

  /// Creates a fade with slide page transition
  FadeSlidePageTransition({
    required this.page,
    this.direction = SlideDirection.fromBottom,
    this.slideDistance = 0.3,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
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

            final offset = _getOffset(direction, slideDistance);

            return FadeTransition(
              opacity: curvedAnimation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: offset,
                  end: Offset.zero,
                ).animate(curvedAnimation),
                child: child,
              ),
            );
          },
        );

  static Offset _getOffset(SlideDirection direction, double distance) {
    switch (direction) {
      case SlideDirection.fromRight:
        return Offset(distance, 0.0);
      case SlideDirection.fromLeft:
        return Offset(-distance, 0.0);
      case SlideDirection.fromTop:
        return Offset(0.0, -distance);
      case SlideDirection.fromBottom:
        return Offset(0.0, distance);
      case SlideDirection.fromTopRight:
        return Offset(distance, -distance);
      case SlideDirection.fromTopLeft:
        return Offset(-distance, -distance);
      case SlideDirection.fromBottomRight:
        return Offset(distance, distance);
      case SlideDirection.fromBottomLeft:
        return Offset(-distance, distance);
    }
  }
}

/// Fade through transition (Material Design inspired)
/// Both pages fade but the outgoing page fades completely before incoming fades in
class FadeThroughPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Whether to include a scale effect
  final bool includeScale;

  /// Creates a fade through page transition
  FadeThroughPageTransition({
    required this.page,
    this.includeScale = true,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // First half: fade out (0.0 - 0.5)
            // Second half: fade in (0.5 - 1.0)
            final fadeInAnimation = CurvedAnimation(
              parent: animation,
              curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
            );

            final scaleAnimation = CurvedAnimation(
              parent: animation,
              curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
            );

            Widget result = FadeTransition(
              opacity: fadeInAnimation,
              child: child,
            );

            if (includeScale) {
              result = ScaleTransition(
                scale: Tween<double>(
                  begin: 0.92,
                  end: 1.0,
                ).animate(scaleAnimation),
                child: result,
              );
            }

            return result;
          },
        );
}

/// Cross fade transition between two pages
class CrossFadePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a cross fade page transition
  CrossFadePageTransition({
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

            return FadeTransition(
              opacity: curvedAnimation,
              child: child,
            );
          },
        );
}

/// Fade with zoom in effect
class FadeZoomInPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a fade with zoom in page transition
  FadeZoomInPageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeOut,
    Curve reverseCurve = Curves.easeIn,
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
                  begin: 0.5,
                  end: 1.0,
                ).animate(curvedAnimation),
                child: child,
              ),
            );
          },
        );
}

/// Fade with zoom out effect (starts larger and scales down)
class FadeZoomOutPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a fade with zoom out page transition
  FadeZoomOutPageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeOut,
    Curve reverseCurve = Curves.easeIn,
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
                  begin: 1.5,
                  end: 1.0,
                ).animate(curvedAnimation),
                child: child,
              ),
            );
          },
        );
}
