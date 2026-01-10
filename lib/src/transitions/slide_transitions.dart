import 'package:flutter/material.dart';
import '../core/enums.dart';

/// Slide transition that slides the page from a specified direction
class SlidePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The direction from which the page slides in
  final SlideDirection direction;

  /// Creates a slide page transition
  SlidePageTransition({
    required this.page,
    this.direction = SlideDirection.fromRight,
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

            final offset = _getOffset(direction);

            return SlideTransition(
              position: Tween<Offset>(
                begin: offset,
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            );
          },
        );

  static Offset _getOffset(SlideDirection direction) {
    switch (direction) {
      case SlideDirection.fromRight:
        return const Offset(1.0, 0.0);
      case SlideDirection.fromLeft:
        return const Offset(-1.0, 0.0);
      case SlideDirection.fromTop:
        return const Offset(0.0, -1.0);
      case SlideDirection.fromBottom:
        return const Offset(0.0, 1.0);
      case SlideDirection.fromTopRight:
        return const Offset(1.0, -1.0);
      case SlideDirection.fromTopLeft:
        return const Offset(-1.0, -1.0);
      case SlideDirection.fromBottomRight:
        return const Offset(1.0, 1.0);
      case SlideDirection.fromBottomLeft:
        return const Offset(-1.0, 1.0);
    }
  }
}

/// Push transition where new page pushes old page away
class PushPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The direction from which the page slides in
  final SlideDirection direction;

  /// Creates a push page transition
  PushPageTransition({
    required this.page,
    this.direction = SlideDirection.fromRight,
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

            final enterOffset = _getEnterOffset(direction);
            final exitOffset = _getExitOffset(direction);

            return Stack(
              children: [
                SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset.zero,
                    end: exitOffset,
                  ).animate(curvedAnimation),
                  child: Container(), // Placeholder for previous page
                ),
                SlideTransition(
                  position: Tween<Offset>(
                    begin: enterOffset,
                    end: Offset.zero,
                  ).animate(curvedAnimation),
                  child: child,
                ),
              ],
            );
          },
        );

  static Offset _getEnterOffset(SlideDirection direction) {
    switch (direction) {
      case SlideDirection.fromRight:
        return const Offset(1.0, 0.0);
      case SlideDirection.fromLeft:
        return const Offset(-1.0, 0.0);
      case SlideDirection.fromTop:
        return const Offset(0.0, -1.0);
      case SlideDirection.fromBottom:
        return const Offset(0.0, 1.0);
      case SlideDirection.fromTopRight:
        return const Offset(1.0, -1.0);
      case SlideDirection.fromTopLeft:
        return const Offset(-1.0, -1.0);
      case SlideDirection.fromBottomRight:
        return const Offset(1.0, 1.0);
      case SlideDirection.fromBottomLeft:
        return const Offset(-1.0, 1.0);
    }
  }

  static Offset _getExitOffset(SlideDirection direction) {
    switch (direction) {
      case SlideDirection.fromRight:
        return const Offset(-0.3, 0.0);
      case SlideDirection.fromLeft:
        return const Offset(0.3, 0.0);
      case SlideDirection.fromTop:
        return const Offset(0.0, 0.3);
      case SlideDirection.fromBottom:
        return const Offset(0.0, -0.3);
      case SlideDirection.fromTopRight:
        return const Offset(-0.3, 0.3);
      case SlideDirection.fromTopLeft:
        return const Offset(0.3, 0.3);
      case SlideDirection.fromBottomRight:
        return const Offset(-0.3, -0.3);
      case SlideDirection.fromBottomLeft:
        return const Offset(0.3, -0.3);
    }
  }
}

/// Cover transition where new page slides over the old page
class CoverPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The direction from which the page slides in
  final SlideDirection direction;

  /// Creates a cover page transition
  CoverPageTransition({
    required this.page,
    this.direction = SlideDirection.fromRight,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    Curve reverseCurve = Curves.easeInOut,
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          opaque: false,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
              reverseCurve: reverseCurve,
            );

            final offset = _getOffset(direction);

            return SlideTransition(
              position: Tween<Offset>(
                begin: offset,
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: Material(
                elevation: 8,
                child: child,
              ),
            );
          },
        );

  static Offset _getOffset(SlideDirection direction) {
    switch (direction) {
      case SlideDirection.fromRight:
        return const Offset(1.0, 0.0);
      case SlideDirection.fromLeft:
        return const Offset(-1.0, 0.0);
      case SlideDirection.fromTop:
        return const Offset(0.0, -1.0);
      case SlideDirection.fromBottom:
        return const Offset(0.0, 1.0);
      case SlideDirection.fromTopRight:
        return const Offset(1.0, -1.0);
      case SlideDirection.fromTopLeft:
        return const Offset(-1.0, -1.0);
      case SlideDirection.fromBottomRight:
        return const Offset(1.0, 1.0);
      case SlideDirection.fromBottomLeft:
        return const Offset(-1.0, 1.0);
    }
  }
}

/// Reveal transition where old page slides away revealing new page
class RevealPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The direction in which the old page slides away
  final SlideDirection direction;

  /// Creates a reveal page transition
  RevealPageTransition({
    required this.page,
    this.direction = SlideDirection.fromLeft,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    Curve reverseCurve = Curves.easeInOut,
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          opaque: false,
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

/// Parallax transition where both pages move at different speeds
class ParallaxPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The direction from which the page slides in
  final SlideDirection direction;

  /// The parallax factor (how much slower the background moves)
  final double parallaxFactor;

  /// Creates a parallax page transition
  ParallaxPageTransition({
    required this.page,
    this.direction = SlideDirection.fromRight,
    this.parallaxFactor = 0.3,
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

            final enterOffset = _getEnterOffset(direction);

            return Stack(
              children: [
                // Old page moves slower (parallax effect)
                SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset.zero,
                    end: Offset(
                      -enterOffset.dx * parallaxFactor,
                      -enterOffset.dy * parallaxFactor,
                    ),
                  ).animate(curvedAnimation),
                  child: Container(), // Placeholder
                ),
                // New page slides in
                SlideTransition(
                  position: Tween<Offset>(
                    begin: enterOffset,
                    end: Offset.zero,
                  ).animate(curvedAnimation),
                  child: child,
                ),
              ],
            );
          },
        );

  static Offset _getEnterOffset(SlideDirection direction) {
    switch (direction) {
      case SlideDirection.fromRight:
        return const Offset(1.0, 0.0);
      case SlideDirection.fromLeft:
        return const Offset(-1.0, 0.0);
      case SlideDirection.fromTop:
        return const Offset(0.0, -1.0);
      case SlideDirection.fromBottom:
        return const Offset(0.0, 1.0);
      case SlideDirection.fromTopRight:
        return const Offset(1.0, -1.0);
      case SlideDirection.fromTopLeft:
        return const Offset(-1.0, -1.0);
      case SlideDirection.fromBottomRight:
        return const Offset(1.0, 1.0);
      case SlideDirection.fromBottomLeft:
        return const Offset(-1.0, 1.0);
    }
  }
}

/// Slide with fade transition
class SlideFadePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The direction from which the page slides in
  final SlideDirection direction;

  /// How far the slide travels (0.0 to 1.0)
  final double slideDistance;

  /// Creates a slide with fade page transition
  SlideFadePageTransition({
    required this.page,
    this.direction = SlideDirection.fromRight,
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

            return SlideTransition(
              position: Tween<Offset>(
                begin: offset,
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: FadeTransition(
                opacity: curvedAnimation,
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

/// Slide with scale transition
class SlideScalePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The direction from which the page slides in
  final SlideDirection direction;

  /// The initial scale of the incoming page
  final double beginScale;

  /// Creates a slide with scale page transition
  SlideScalePageTransition({
    required this.page,
    this.direction = SlideDirection.fromRight,
    this.beginScale = 0.8,
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

            final offset = _getOffset(direction);

            return SlideTransition(
              position: Tween<Offset>(
                begin: offset,
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: ScaleTransition(
                scale: Tween<double>(
                  begin: beginScale,
                  end: 1.0,
                ).animate(curvedAnimation),
                child: child,
              ),
            );
          },
        );

  static Offset _getOffset(SlideDirection direction) {
    switch (direction) {
      case SlideDirection.fromRight:
        return const Offset(1.0, 0.0);
      case SlideDirection.fromLeft:
        return const Offset(-1.0, 0.0);
      case SlideDirection.fromTop:
        return const Offset(0.0, -1.0);
      case SlideDirection.fromBottom:
        return const Offset(0.0, 1.0);
      case SlideDirection.fromTopRight:
        return const Offset(1.0, -1.0);
      case SlideDirection.fromTopLeft:
        return const Offset(-1.0, -1.0);
      case SlideDirection.fromBottomRight:
        return const Offset(1.0, 1.0);
      case SlideDirection.fromBottomLeft:
        return const Offset(-1.0, 1.0);
    }
  }
}

/// Elastic slide transition with bounce effect
class ElasticSlidePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The direction from which the page slides in
  final SlideDirection direction;

  /// Creates an elastic slide page transition
  ElasticSlidePageTransition({
    required this.page,
    this.direction = SlideDirection.fromRight,
    Duration duration = const Duration(milliseconds: 600),
    Duration reverseDuration = const Duration(milliseconds: 400),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.elasticOut,
              reverseCurve: Curves.easeIn,
            );

            final offset = _getOffset(direction);

            return SlideTransition(
              position: Tween<Offset>(
                begin: offset,
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            );
          },
        );

  static Offset _getOffset(SlideDirection direction) {
    switch (direction) {
      case SlideDirection.fromRight:
        return const Offset(1.0, 0.0);
      case SlideDirection.fromLeft:
        return const Offset(-1.0, 0.0);
      case SlideDirection.fromTop:
        return const Offset(0.0, -1.0);
      case SlideDirection.fromBottom:
        return const Offset(0.0, 1.0);
      case SlideDirection.fromTopRight:
        return const Offset(1.0, -1.0);
      case SlideDirection.fromTopLeft:
        return const Offset(-1.0, -1.0);
      case SlideDirection.fromBottomRight:
        return const Offset(1.0, 1.0);
      case SlideDirection.fromBottomLeft:
        return const Offset(-1.0, 1.0);
    }
  }
}

/// Bouncy slide transition
class BouncySlidePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The direction from which the page slides in
  final SlideDirection direction;

  /// Creates a bouncy slide page transition
  BouncySlidePageTransition({
    required this.page,
    this.direction = SlideDirection.fromRight,
    Duration duration = const Duration(milliseconds: 500),
    Duration reverseDuration = const Duration(milliseconds: 300),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.bounceOut,
              reverseCurve: Curves.easeIn,
            );

            final offset = _getOffset(direction);

            return SlideTransition(
              position: Tween<Offset>(
                begin: offset,
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            );
          },
        );

  static Offset _getOffset(SlideDirection direction) {
    switch (direction) {
      case SlideDirection.fromRight:
        return const Offset(1.0, 0.0);
      case SlideDirection.fromLeft:
        return const Offset(-1.0, 0.0);
      case SlideDirection.fromTop:
        return const Offset(0.0, -1.0);
      case SlideDirection.fromBottom:
        return const Offset(0.0, 1.0);
      case SlideDirection.fromTopRight:
        return const Offset(1.0, -1.0);
      case SlideDirection.fromTopLeft:
        return const Offset(-1.0, -1.0);
      case SlideDirection.fromBottomRight:
        return const Offset(1.0, 1.0);
      case SlideDirection.fromBottomLeft:
        return const Offset(-1.0, 1.0);
    }
  }
}
