import 'package:flutter/material.dart';

/// Instant transition with no animation (accessibility option)
class NoAnimationPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a no animation page transition
  NoAnimationPageTransition({
    required this.page,
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        );
}

/// Simple cross-fade only transition (reduced motion)
class SimpleFadePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a simple fade page transition
  SimpleFadePageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 150),
    Duration reverseDuration = const Duration(milliseconds: 150),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
}

/// Minimal movement transition (very subtle slide)
class MinimalMovementPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a minimal movement page transition
  MinimalMovementPageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 200),
    Duration reverseDuration = const Duration(milliseconds: 200),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            );

            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.05, 0.0),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: FadeTransition(
                opacity: curvedAnimation,
                child: child,
              ),
            );
          },
        );
}

/// Opacity-only transition for performance
class OpacityOnlyPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates an opacity-only page transition
  OpacityOnlyPageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 200),
    Duration reverseDuration = const Duration(milliseconds: 200),
    Curve curve = Curves.linear,
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(parent: animation, curve: curve),
              child: child,
            );
          },
        );
}

/// Transform-only transition (no rebuilds)
class TransformOnlyPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a transform-only page transition
  TransformOnlyPageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 200),
    Duration reverseDuration = const Duration(milliseconds: 200),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: child,
            );
          },
        );
}

/// Adaptive transition that respects system reduced motion settings
class AdaptivePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The normal transition duration
  final Duration normalDuration;

  /// Creates an adaptive page transition
  AdaptivePageTransition({
    required this.page,
    this.normalDuration = const Duration(milliseconds: 300),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: normalDuration,
          reverseTransitionDuration: normalDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Check for reduced motion preference
            final reduceMotion = MediaQuery.of(context).disableAnimations;

            if (reduceMotion) {
              // Simple fade for reduced motion
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            }

            // Normal slide + fade transition
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            );

            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.2, 0.0),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: FadeTransition(
                opacity: curvedAnimation,
                child: child,
              ),
            );
          },
        );
}

/// Fast snap transition for quick navigation
class FastSnapPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a fast snap page transition
  FastSnapPageTransition({
    required this.page,
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: const Duration(milliseconds: 100),
          reverseTransitionDuration: const Duration(milliseconds: 100),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            );
          },
        );
}
