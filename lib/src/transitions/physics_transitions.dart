import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../core/enums.dart';

/// Spring physics transition
class SpringPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The direction from which the page enters
  final SlideDirection direction;

  /// Creates a spring page transition
  SpringPageTransition({
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

/// Gravity drop transition
class GravityDropPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a gravity drop page transition
  GravityDropPageTransition({
    required this.page,
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

           return SlideTransition(
             position: Tween<Offset>(
               begin: const Offset(0.0, -1.5),
               end: Offset.zero,
             ).animate(curvedAnimation),
             child: child,
           );
         },
       );
}

/// Elastic bounce transition
class ElasticBouncePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates an elastic bounce page transition
  ElasticBouncePageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 800),
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

           return ScaleTransition(
             scale: Tween<double>(
               begin: 0.0,
               end: 1.0,
             ).animate(curvedAnimation),
             child: child,
           );
         },
       );
}

/// Damped oscillation transition
class DampedOscillationPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a damped oscillation page transition
  DampedOscillationPageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 700),
    Duration reverseDuration = const Duration(milliseconds: 400),
    super.settings,
  }) : super(
         pageBuilder: (context, animation, secondaryAnimation) => page,
         transitionDuration: duration,
         reverseTransitionDuration: reverseDuration,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           return AnimatedBuilder(
             animation: animation,
             builder: (context, _) {
               // Damped oscillation formula
               final t = animation.value;
               final damping = math.exp(-3 * t);
               final oscillation = math.sin(t * math.pi * 4) * damping;
               final scale = 1.0 + (oscillation * 0.1 * (1 - t));

               return Transform.scale(
                 scale: t < 0.01 ? 0.01 : scale.clamp(0.5, 1.2),
                 child: Opacity(opacity: t.clamp(0.0, 1.0), child: child),
               );
             },
             child: child,
           );
         },
       );
}

/// Inertia slide transition
class InertiaSlidePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The direction from which the page slides
  final SlideDirection direction;

  /// Creates an inertia slide page transition
  InertiaSlidePageTransition({
    required this.page,
    this.direction = SlideDirection.fromRight,
    Duration duration = const Duration(milliseconds: 500),
    Duration reverseDuration = const Duration(milliseconds: 400),
    super.settings,
  }) : super(
         pageBuilder: (context, animation, secondaryAnimation) => page,
         transitionDuration: duration,
         reverseTransitionDuration: reverseDuration,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           final curvedAnimation = CurvedAnimation(
             parent: animation,
             curve: Curves.decelerate,
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
        return const Offset(1.5, 0.0);
      case SlideDirection.fromLeft:
        return const Offset(-1.5, 0.0);
      case SlideDirection.fromTop:
        return const Offset(0.0, -1.5);
      case SlideDirection.fromBottom:
        return const Offset(0.0, 1.5);
      case SlideDirection.fromTopRight:
        return const Offset(1.5, -1.5);
      case SlideDirection.fromTopLeft:
        return const Offset(-1.5, -1.5);
      case SlideDirection.fromBottomRight:
        return const Offset(1.5, 1.5);
      case SlideDirection.fromBottomLeft:
        return const Offset(-1.5, 1.5);
    }
  }
}

/// Rubber band stretch transition
class RubberBandPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a rubber band page transition
  RubberBandPageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 600),
    Duration reverseDuration = const Duration(milliseconds: 400),
    super.settings,
  }) : super(
         pageBuilder: (context, animation, secondaryAnimation) => page,
         transitionDuration: duration,
         reverseTransitionDuration: reverseDuration,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           return AnimatedBuilder(
             animation: animation,
             builder: (context, _) {
               final t = animation.value;
               // Rubber band effect - overshoot then settle
               double scaleX, scaleY;

               if (t < 0.5) {
                 // Stretch phase
                 scaleX = t * 2 * 1.2;
                 scaleY = t * 2 * 0.8;
               } else {
                 // Settle phase
                 final settleT = (t - 0.5) * 2;
                 scaleX = 1.2 - (0.2 * settleT);
                 scaleY = 0.8 + (0.2 * settleT);
               }

               return Transform(
                 alignment: Alignment.center,
                 transform: Matrix4.identity()
                   ..scale(
                     scaleX.clamp(0.01, 1.5),
                     scaleY.clamp(0.01, 1.5),
                     1.0,
                   ),
                 child: Opacity(opacity: t.clamp(0.0, 1.0), child: child),
               );
             },
             child: child,
           );
         },
       );
}

/// Pendulum swing transition
class PendulumPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a pendulum page transition
  PendulumPageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 700),
    Duration reverseDuration = const Duration(milliseconds: 500),
    super.settings,
  }) : super(
         pageBuilder: (context, animation, secondaryAnimation) => page,
         transitionDuration: duration,
         reverseTransitionDuration: reverseDuration,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           return AnimatedBuilder(
             animation: animation,
             builder: (context, _) {
               final t = animation.value;
               // Pendulum swing with damping
               final damping = math.exp(-2 * t);
               final swing = math.sin(t * math.pi * 3) * damping * (1 - t);
               final rotation = swing * 0.2;

               return Transform(
                 alignment: Alignment.topCenter,
                 transform: Matrix4.identity()..rotateZ(rotation),
                 child: Opacity(opacity: t.clamp(0.0, 1.0), child: child),
               );
             },
             child: child,
           );
         },
       );
}

/// Over-scroll bounce transition
class OverScrollBouncePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The direction from which the page enters
  final SlideDirection direction;

  /// Creates an over-scroll bounce page transition
  OverScrollBouncePageTransition({
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
           return AnimatedBuilder(
             animation: animation,
             builder: (context, _) {
               final t = animation.value;
               // Over-scroll effect
               double progress;
               if (t < 0.7) {
                 // Overshoot
                 progress = (t / 0.7) * 1.1;
               } else {
                 // Bounce back
                 progress = 1.1 - ((t - 0.7) / 0.3 * 0.1);
               }

               final offset = _getOffset(
                 direction,
                 1 - progress.clamp(0.0, 1.1),
               );

               return Transform.translate(
                 offset: Offset(
                   offset.dx * MediaQuery.of(context).size.width,
                   offset.dy * MediaQuery.of(context).size.height,
                 ),
                 child: child,
               );
             },
             child: child,
           );
         },
       );

  static Offset _getOffset(SlideDirection direction, double factor) {
    switch (direction) {
      case SlideDirection.fromRight:
        return Offset(factor, 0.0);
      case SlideDirection.fromLeft:
        return Offset(-factor, 0.0);
      case SlideDirection.fromTop:
        return Offset(0.0, -factor);
      case SlideDirection.fromBottom:
        return Offset(0.0, factor);
      case SlideDirection.fromTopRight:
        return Offset(factor, -factor);
      case SlideDirection.fromTopLeft:
        return Offset(-factor, -factor);
      case SlideDirection.fromBottomRight:
        return Offset(factor, factor);
      case SlideDirection.fromBottomLeft:
        return Offset(-factor, factor);
    }
  }
}

/// Spring rebound transition with scale
class SpringReboundPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a spring rebound page transition
  SpringReboundPageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 700),
    Duration reverseDuration = const Duration(milliseconds: 400),
    super.settings,
  }) : super(
         pageBuilder: (context, animation, secondaryAnimation) => page,
         transitionDuration: duration,
         reverseTransitionDuration: reverseDuration,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           final scaleAnimation = CurvedAnimation(
             parent: animation,
             curve: Curves.elasticOut,
           );

           final fadeAnimation = CurvedAnimation(
             parent: animation,
             curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
           );

           return FadeTransition(
             opacity: fadeAnimation,
             child: ScaleTransition(
               scale: Tween<double>(
                 begin: 0.3,
                 end: 1.0,
               ).animate(scaleAnimation),
               child: child,
             ),
           );
         },
       );
}
