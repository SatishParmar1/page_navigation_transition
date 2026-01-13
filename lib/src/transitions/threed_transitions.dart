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
                 alignment: horizontal
                     ? Alignment.centerLeft
                     : Alignment.topCenter,
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

               Matrix4 transform = Matrix4.identity()..setEntry(3, 2, 0.002);

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
               final translateX =
                   (1.0 - curvedAnimation.value) * size.width * 0.5;

               return Transform(
                 alignment: Alignment.center,
                 transform: Matrix4.identity()
                   ..setEntry(3, 2, 0.001)
                   ..translateByDouble(translateX, 0.0, 0.0, 1.0)
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
                   ..translateByDouble(translateX, 0.0, 0.0, 1.0)
                   ..rotateY(-angle)
                   ..scaleByDouble(scale, scale, 1.0, 1.0),
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
                   ..scaleByDouble(scale, scale, 1.0, 1.0),
                 child: Opacity(opacity: curvedAnimation.value, child: child),
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
                   ..translateByDouble(translateX, 0.0, translateZ, 1.0)
                   ..scaleByDouble(scale, scale, 1.0, 1.0),
                 child: Opacity(opacity: curvedAnimation.value, child: child),
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
                 child: Opacity(opacity: curvedAnimation.value, child: child),
               );
             },
             child: child,
           );
         },
       );
}

/// Origami-style folding page transition
///
/// Creates a paper-folding effect where the page unfolds
/// into view with configurable fold segments.
class OrigamiPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Number of fold segments
  final int folds;

  /// Axis of the fold
  final Axis foldAxis;

  /// Creates an origami page transition
  OrigamiPageTransition({
    required this.page,
    this.folds = 3,
    this.foldAxis = Axis.horizontal,
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
               final angle = (1.0 - curvedAnimation.value) * (math.pi / 2);
               final scale = 0.5 + (curvedAnimation.value * 0.5);

               final matrix = Matrix4.identity()..setEntry(3, 2, 0.002);

               if (foldAxis == Axis.horizontal) {
                 matrix.rotateY(-angle * 0.5);
                 matrix.rotateZ(angle * 0.1);
               } else {
                 matrix.rotateX(angle * 0.5);
                 matrix.rotateZ(-angle * 0.1);
               }
               matrix.scaleByDouble(scale, scale, 1.0, 1.0);

               return Transform(
                 alignment: foldAxis == Axis.horizontal
                     ? Alignment.centerLeft
                     : Alignment.topCenter,
                 transform: matrix,
                 child: Opacity(
                   opacity: curvedAnimation.value.clamp(0.0, 1.0),
                   child: child,
                 ),
               );
             },
             child: child,
           );
         },
       );
}

/// Prism rotation page transition
///
/// Creates a triangular prism rotation effect where
/// the page rotates around a 3D prism shape.
class PrismPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Whether to rotate clockwise
  final bool clockwise;

  /// Creates a prism page transition
  PrismPageTransition({
    required this.page,
    this.clockwise = true,
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
               // Prism has 3 faces, so rotation is 120 degrees (2π/3)
               final angle = (1.0 - curvedAnimation.value) * (2 * math.pi / 3);
               final direction = clockwise ? 1.0 : -1.0;

               return Transform(
                 alignment: Alignment.center,
                 transform: Matrix4.identity()
                   ..setEntry(3, 2, 0.0015)
                   ..rotateY(angle * direction),
                 child: Opacity(
                   opacity: curvedAnimation.value.clamp(0.2, 1.0),
                   child: child,
                 ),
               );
             },
             child: child,
           );
         },
       );
}

/// Sphere mapping page transition
///
/// Creates a spherical distortion effect as if the page
/// wraps around a sphere.
class SpherePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Radius factor for the sphere effect
  final double radiusFactor;

  /// Creates a sphere page transition
  SpherePageTransition({
    required this.page,
    this.radiusFactor = 1.0,
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
               final progress = curvedAnimation.value;
               final rotationAngle = (1.0 - progress) * math.pi;
               final scale = 0.3 + (progress * 0.7);
               final translateZ = (1.0 - progress) * -300 * radiusFactor;

               return Transform(
                 alignment: Alignment.center,
                 transform: Matrix4.identity()
                   ..setEntry(3, 2, 0.001)
                   ..translateByDouble(0.0, 0.0, translateZ, 1.0)
                   ..rotateY(rotationAngle * 0.5)
                   ..rotateX(rotationAngle * 0.3)
                   ..scaleByDouble(scale, scale, 1.0, 1.0),
                 child: Opacity(opacity: progress, child: child),
               );
             },
             child: child,
           );
         },
       );
}

/// Z-Stack depth page transition
///
/// Creates a stacking effect where pages appear to stack
/// on top of each other with depth.
class ZStackPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Depth of the stack effect
  final double depth;

  /// Offset for stacked pages
  final double stackOffset;

  /// Creates a z-stack page transition
  ZStackPageTransition({
    required this.page,
    this.depth = 200.0,
    this.stackOffset = 30.0,
    Duration duration = const Duration(milliseconds: 400),
    Duration reverseDuration = const Duration(milliseconds: 400),
    Curve curve = Curves.easeOutCubic,
    Curve reverseCurve = Curves.easeInCubic,
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
               final progress = curvedAnimation.value;
               final translateZ = (1.0 - progress) * -depth;
               final translateY = (1.0 - progress) * stackOffset;
               final scale = 0.85 + (progress * 0.15);

               return Transform(
                 alignment: Alignment.center,
                 transform: Matrix4.identity()
                   ..setEntry(3, 2, 0.001)
                   ..translateByDouble(0.0, translateY, translateZ, 1.0)
                   ..scaleByDouble(scale, scale, 1.0, 1.0),
                 child: Opacity(
                   opacity: progress.clamp(0.0, 1.0),
                   child: child,
                 ),
               );
             },
             child: child,
           );
         },
       );
}

/// Layered depth page transition
///
/// Creates a multi-layer parallax depth effect where
/// different parts of the animation move at different speeds.
class LayeredDepthPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Number of conceptual layers
  final int layers;

  /// Depth multiplier for effect intensity
  final double depthMultiplier;

  /// Creates a layered depth page transition
  LayeredDepthPageTransition({
    required this.page,
    this.layers = 3,
    this.depthMultiplier = 1.0,
    Duration duration = const Duration(milliseconds: 500),
    Duration reverseDuration = const Duration(milliseconds: 500),
    Curve curve = Curves.easeOutCubic,
    Curve reverseCurve = Curves.easeInCubic,
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
               final progress = curvedAnimation.value;

               // Multi-layer effect with varying speeds
               final translateX =
                   (1.0 - progress) * size.width * 0.3 * depthMultiplier;
               final translateZ = (1.0 - progress) * -150 * depthMultiplier;
               final rotateY = (1.0 - progress) * (math.pi / 12);
               final scale = 0.9 + (progress * 0.1);

               return Transform(
                 alignment: Alignment.centerRight,
                 transform: Matrix4.identity()
                   ..setEntry(3, 2, 0.001)
                   ..translateByDouble(translateX, 0.0, translateZ, 1.0)
                   ..rotateY(-rotateY)
                   ..scaleByDouble(scale, scale, 1.0, 1.0),
                 child: Opacity(
                   opacity: progress.clamp(0.0, 1.0),
                   child: child,
                 ),
               );
             },
             child: child,
           );
         },
       );
}

/// Hologram page transition
///
/// Creates a futuristic hologram-like effect with color
/// tinting and subtle flickering animation.
class HologramPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Primary color of the hologram effect
  final Color hologramColor;

  /// Intensity of the flicker effect (0.0 - 1.0)
  final double flickerIntensity;

  /// Creates a hologram page transition
  HologramPageTransition({
    required this.page,
    this.hologramColor = const Color(0xFF00FFFF), // Cyan
    this.flickerIntensity = 0.3,
    Duration duration = const Duration(milliseconds: 600),
    Duration reverseDuration = const Duration(milliseconds: 600),
    Curve curve = Curves.easeOutCubic,
    Curve reverseCurve = Curves.easeInCubic,
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
               final progress = curvedAnimation.value;

               // Flicker effect based on progress
               final flickerValue = progress < 0.3
                   ? (math.sin(progress * 30) * flickerIntensity +
                         (1 - flickerIntensity))
                   : 1.0;

               final scale = 0.95 + (progress * 0.05);
               final translateZ = (1.0 - progress) * -50;

               return Transform(
                 alignment: Alignment.center,
                 transform: Matrix4.identity()
                   ..setEntry(3, 2, 0.001)
                   ..translateByDouble(0.0, 0.0, translateZ, 1.0)
                   ..scaleByDouble(scale, scale, 1.0, 1.0),
                 child: Opacity(
                   opacity: (progress * flickerValue).clamp(0.0, 1.0),
                   child: ColorFiltered(
                     colorFilter: ColorFilter.mode(
                       hologramColor.withValues(alpha: 0.1 * (1 - progress)),
                       BlendMode.overlay,
                     ),
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
