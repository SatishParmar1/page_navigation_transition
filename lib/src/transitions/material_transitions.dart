import 'package:flutter/material.dart';
import '../core/enums.dart';

/// Material Design Shared Axis transition
class SharedAxisPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The axis direction
  final SharedAxisDirection direction;

  /// Creates a shared axis page transition
  SharedAxisPageTransition({
    required this.page,
    this.direction = SharedAxisDirection.horizontal,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final fadeInAnimation = CurvedAnimation(
              parent: animation,
              curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
            );

            // ignore: unused_local_variable
            final fadeOutAnimation = CurvedAnimation(
              parent: animation,
              curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
            );

            Widget result = child;

            switch (direction) {
              case SharedAxisDirection.horizontal:
                result = SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.3, 0.0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                  )),
                  child: FadeTransition(
                    opacity: fadeInAnimation,
                    child: child,
                  ),
                );
                break;
              case SharedAxisDirection.vertical:
                result = SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 0.3),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                  )),
                  child: FadeTransition(
                    opacity: fadeInAnimation,
                    child: child,
                  ),
                );
                break;
              case SharedAxisDirection.scaled:
                result = ScaleTransition(
                  scale: Tween<double>(
                    begin: 0.8,
                    end: 1.0,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                  )),
                  child: FadeTransition(
                    opacity: fadeInAnimation,
                    child: child,
                  ),
                );
                break;
            }

            return result;
          },
        );
}

/// Material Design Fade Through transition
class FadeThroughMaterialPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a fade through page transition
  FadeThroughMaterialPageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Fade in starts at 30% and completes at 100%
            final fadeInAnimation = CurvedAnimation(
              parent: animation,
              curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
            );

            // Scale animation
            final scaleAnimation = CurvedAnimation(
              parent: animation,
              curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
            );

            return FadeTransition(
              opacity: fadeInAnimation,
              child: ScaleTransition(
                scale: Tween<double>(
                  begin: 0.92,
                  end: 1.0,
                ).animate(scaleAnimation),
                child: child,
              ),
            );
          },
        );
}

/// Material Design Container Transform transition
class ContainerTransformPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The color of the container during transition
  final Color containerColor;

  /// The beginning border radius
  final double beginRadius;

  /// Creates a container transform page transition
  ContainerTransformPageTransition({
    required this.page,
    this.containerColor = Colors.white,
    this.beginRadius = 16.0,
    Duration duration = const Duration(milliseconds: 400),
    Duration reverseDuration = const Duration(milliseconds: 400),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            );

            return AnimatedBuilder(
              animation: curvedAnimation,
              builder: (context, _) {
                final borderRadius = Tween<double>(
                  begin: beginRadius,
                  end: 0.0,
                ).evaluate(curvedAnimation);

                return ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Container(
                    color: containerColor,
                    child: FadeTransition(
                      opacity: curvedAnimation,
                      child: ScaleTransition(
                        scale: Tween<double>(
                          begin: 0.8,
                          end: 1.0,
                        ).animate(curvedAnimation),
                        child: child,
                      ),
                    ),
                  ),
                );
              },
              child: child,
            );
          },
        );
}

/// Elevation scale transition (Material Design inspired)
class ElevationScalePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The beginning elevation
  final double beginElevation;

  /// The ending elevation
  final double endElevation;

  /// Creates an elevation scale page transition
  ElevationScalePageTransition({
    required this.page,
    this.beginElevation = 0.0,
    this.endElevation = 8.0,
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

            return AnimatedBuilder(
              animation: curvedAnimation,
              builder: (context, _) {
                final elevation = Tween<double>(
                  begin: beginElevation,
                  end: endElevation,
                ).evaluate(curvedAnimation);

                return Material(
                  elevation: elevation,
                  child: ScaleTransition(
                    scale: Tween<double>(
                      begin: 0.9,
                      end: 1.0,
                    ).animate(curvedAnimation),
                    child: FadeTransition(
                      opacity: curvedAnimation,
                      child: child,
                    ),
                  ),
                );
              },
              child: child,
            );
          },
        );
}

/// Material Design style page transition
class MaterialPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a material page transition
  MaterialPageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            );

            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.25),
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
