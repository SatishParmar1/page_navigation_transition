import 'package:flutter/material.dart';
import '../core/enums.dart';

/// Scale transition from a specified origin
class ScalePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The origin from which to scale
  final ScaleOrigin origin;

  /// The initial scale value
  final double beginScale;

  /// Creates a scale page transition
  ScalePageTransition({
    required this.page,
    this.origin = ScaleOrigin.center,
    this.beginScale = 0.0,
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

           final alignment = _getAlignment(origin);

           return ScaleTransition(
             scale: Tween<double>(
               begin: beginScale,
               end: 1.0,
             ).animate(curvedAnimation),
             alignment: alignment,
             child: child,
           );
         },
       );

  static Alignment _getAlignment(ScaleOrigin origin) {
    switch (origin) {
      case ScaleOrigin.center:
        return Alignment.center;
      case ScaleOrigin.topLeft:
        return Alignment.topLeft;
      case ScaleOrigin.topRight:
        return Alignment.topRight;
      case ScaleOrigin.bottomLeft:
        return Alignment.bottomLeft;
      case ScaleOrigin.bottomRight:
        return Alignment.bottomRight;
      case ScaleOrigin.topCenter:
        return Alignment.topCenter;
      case ScaleOrigin.bottomCenter:
        return Alignment.bottomCenter;
      case ScaleOrigin.centerLeft:
        return Alignment.centerLeft;
      case ScaleOrigin.centerRight:
        return Alignment.centerRight;
    }
  }
}

/// Scale with fade transition
class ScaleFadePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The origin from which to scale
  final ScaleOrigin origin;

  /// The initial scale value
  final double beginScale;

  /// Creates a scale with fade page transition
  ScaleFadePageTransition({
    required this.page,
    this.origin = ScaleOrigin.center,
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

           final alignment = _getAlignment(origin);

           return FadeTransition(
             opacity: curvedAnimation,
             child: ScaleTransition(
               scale: Tween<double>(
                 begin: beginScale,
                 end: 1.0,
               ).animate(curvedAnimation),
               alignment: alignment,
               child: child,
             ),
           );
         },
       );

  static Alignment _getAlignment(ScaleOrigin origin) {
    switch (origin) {
      case ScaleOrigin.center:
        return Alignment.center;
      case ScaleOrigin.topLeft:
        return Alignment.topLeft;
      case ScaleOrigin.topRight:
        return Alignment.topRight;
      case ScaleOrigin.bottomLeft:
        return Alignment.bottomLeft;
      case ScaleOrigin.bottomRight:
        return Alignment.bottomRight;
      case ScaleOrigin.topCenter:
        return Alignment.topCenter;
      case ScaleOrigin.bottomCenter:
        return Alignment.bottomCenter;
      case ScaleOrigin.centerLeft:
        return Alignment.centerLeft;
      case ScaleOrigin.centerRight:
        return Alignment.centerRight;
    }
  }
}

/// Shrink and grow transition (reverse scale - starts large, shrinks, then grows back)
class ShrinkGrowPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The minimum scale during the transition
  final double minScale;

  /// Creates a shrink and grow page transition
  ShrinkGrowPageTransition({
    required this.page,
    this.minScale = 0.5,
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

           // Create a scale animation that goes: 1.0 -> minScale -> 1.0
           return AnimatedBuilder(
             animation: curvedAnimation,
             builder: (context, _) {
               double scale;
               if (curvedAnimation.value < 0.5) {
                 // First half: shrink from 1.0 to minScale
                 scale = 1.0 - ((1.0 - minScale) * (curvedAnimation.value * 2));
               } else {
                 // Second half: grow from minScale to 1.0
                 scale =
                     minScale +
                     ((1.0 - minScale) * ((curvedAnimation.value - 0.5) * 2));
               }
               return Transform.scale(scale: scale, child: child);
             },
             child: child,
           );
         },
       );
}

/// Zoom in transition
class ZoomInPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a zoom in page transition
  ZoomInPageTransition({
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

/// Zoom out transition (starts from zoomed in)
class ZoomOutPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a zoom out page transition
  ZoomOutPageTransition({
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

           return ScaleTransition(
             scale: Tween<double>(
               begin: 2.0,
               end: 1.0,
             ).animate(curvedAnimation),
             child: child,
           );
         },
       );
}

/// Zoom in with fade transition
class ZoomInFadePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a zoom in with fade page transition
  ZoomInFadePageTransition({
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

/// Zoom out with fade transition
class ZoomOutFadePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a zoom out with fade page transition
  ZoomOutFadePageTransition({
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

/// Pop scale transition (bouncy scale)
class PopScalePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a pop scale page transition
  PopScalePageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 400),
    Duration reverseDuration = const Duration(milliseconds: 300),
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

/// Scale with rotation transition
class ScaleRotationPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The initial scale value
  final double beginScale;

  /// The initial rotation in turns
  final double beginTurns;

  /// Creates a scale with rotation page transition
  ScaleRotationPageTransition({
    required this.page,
    this.beginScale = 0.0,
    this.beginTurns = 0.5,
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
             child: RotationTransition(
               turns: Tween<double>(
                 begin: beginTurns,
                 end: 0.0,
               ).animate(curvedAnimation),
               child: child,
             ),
           );
         },
       );
}

/// Depth scale transition (with perspective)
class DepthScalePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a depth scale page transition
  DepthScalePageTransition({
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
                 begin: -200.0,
                 end: 0.0,
               ).evaluate(curvedAnimation);

               return Transform(
                 alignment: Alignment.center,
                 transform: Matrix4.identity()
                   ..setEntry(3, 2, 0.001)
                   ..translateByDouble(0.0, 0.0, translateZ, 1.0)
                   ..scaleByDouble(scale, scale, 1.0, 1.0),
                 child: Opacity(opacity: curvedAnimation.value, child: child),
               );
             },
             child: child,
           );
         },
       );
}
