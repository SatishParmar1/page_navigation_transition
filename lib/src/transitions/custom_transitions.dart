import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';
import '../core/enums.dart';

/// Circular reveal transition (ripple effect)
class CircularRevealPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The center point of the reveal (in relative coordinates 0-1)
  final Alignment center;

  /// Creates a circular reveal page transition
  CircularRevealPageTransition({
    required this.page,
    this.center = Alignment.center,
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
                return ClipPath(
                  clipper: _CircularRevealClipper(
                    progress: curvedAnimation.value,
                    center: center,
                  ),
                  child: child,
                );
              },
              child: child,
            );
          },
        );
}

class _CircularRevealClipper extends CustomClipper<Path> {
  final double progress;
  final Alignment center;

  _CircularRevealClipper({
    required this.progress,
    required this.center,
  });

  @override
  Path getClip(Size size) {
    final centerX = (center.x + 1) / 2 * size.width;
    final centerY = (center.y + 1) / 2 * size.height;

    final maxRadius = math.sqrt(
      math.pow(math.max(centerX, size.width - centerX), 2) +
          math.pow(math.max(centerY, size.height - centerY), 2),
    );

    final currentRadius = progress * maxRadius;

    return Path()
      ..addOval(Rect.fromCircle(
        center: Offset(centerX, centerY),
        radius: currentRadius,
      ));
  }

  @override
  bool shouldReclip(_CircularRevealClipper oldClipper) {
    return progress != oldClipper.progress;
  }
}

/// Blur transition effect
class BlurPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Maximum blur sigma
  final double maxBlur;

  /// Creates a blur page transition
  BlurPageTransition({
    required this.page,
    this.maxBlur = 10.0,
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
                final sigma = (1 - curvedAnimation.value) * maxBlur;

                return ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: sigma,
                    sigmaY: sigma,
                  ),
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

/// Glitch effect transition
class GlitchPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Intensity of the glitch effect
  final double intensity;

  /// Creates a glitch page transition
  GlitchPageTransition({
    required this.page,
    this.intensity = 1.0,
    Duration duration = const Duration(milliseconds: 500),
    Duration reverseDuration = const Duration(milliseconds: 300),
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
                final random = math.Random((t * 1000).toInt());

                // Glitch offset that decreases as animation progresses
                final glitchFactor = (1 - t) * intensity;
                final offsetX = (random.nextDouble() - 0.5) * 20 * glitchFactor;
                final offsetY = (random.nextDouble() - 0.5) * 10 * glitchFactor;

                // Show glitch slices
                final showGlitch = t < 0.8 && random.nextDouble() > 0.7;

                return Stack(
                  children: [
                    Transform.translate(
                      offset: Offset(offsetX, offsetY),
                      child: Opacity(
                        opacity: t.clamp(0.0, 1.0),
                        child: child,
                      ),
                    ),
                    if (showGlitch)
                      Positioned(
                        top: random.nextDouble() * 200,
                        left: 0,
                        right: 0,
                        height: 5 + random.nextDouble() * 10,
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.cyan.withValues(alpha: 0.5),
                            BlendMode.srcATop,
                          ),
                          child: Transform.translate(
                            offset: Offset(random.nextDouble() * 20 - 10, 0),
                            child: child,
                          ),
                        ),
                      ),
                  ],
                );
              },
              child: child,
            );
          },
        );
}

/// Accordion fold transition
class AccordionPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Number of folds
  final int foldCount;

  /// Creates an accordion page transition
  AccordionPageTransition({
    required this.page,
    this.foldCount = 3,
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
                final scaleY = curvedAnimation.value;

                return Transform(
                  alignment: Alignment.topCenter,
                  transform: Matrix4.identity()..scale(1.0, scaleY),
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

/// Page flip (book-style) transition
class BookFlipPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Whether to flip from right to left
  final bool rightToLeft;

  /// Creates a book flip page transition
  BookFlipPageTransition({
    required this.page,
    this.rightToLeft = true,
    Duration duration = const Duration(milliseconds: 600),
    Duration reverseDuration = const Duration(milliseconds: 600),
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
                final angle = (1 - curvedAnimation.value) * math.pi;
                final isShowingFront = curvedAnimation.value > 0.5;

                return Transform(
                  alignment: rightToLeft
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(rightToLeft ? -angle : angle),
                  child: isShowingFront
                      ? child
                      : Container(color: Colors.grey[100]),
                );
              },
              child: child,
            );
          },
        );
}

/// Stack/Depth transition
class StackDepthPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a stack depth page transition
  StackDepthPageTransition({
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
                final scale = 0.8 + (curvedAnimation.value * 0.2);
                final translateY = (1 - curvedAnimation.value) * 100;

                return Transform(
                  alignment: Alignment.bottomCenter,
                  transform: Matrix4.identity()
                    ..translate(0.0, translateY)
                    ..scale(scale),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2 * curvedAnimation.value),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Opacity(
                      opacity: curvedAnimation.value,
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

/// Shutter transition (like camera shutter)
class ShutterPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Number of shutter blades
  final int blades;

  /// Creates a shutter page transition
  ShutterPageTransition({
    required this.page,
    this.blades = 8,
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
                return ClipPath(
                  clipper: _ShutterClipper(
                    progress: curvedAnimation.value,
                    blades: blades,
                  ),
                  child: child,
                );
              },
              child: child,
            );
          },
        );
}

class _ShutterClipper extends CustomClipper<Path> {
  final double progress;
  final int blades;

  _ShutterClipper({
    required this.progress,
    required this.blades,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = math.sqrt(
      math.pow(size.width / 2, 2) + math.pow(size.height / 2, 2),
    );
    final currentRadius = progress * maxRadius * 1.5;

    path.addOval(Rect.fromCircle(center: center, radius: currentRadius));

    return path;
  }

  @override
  bool shouldReclip(_ShutterClipper oldClipper) {
    return progress != oldClipper.progress;
  }
}

/// Wipe transition
class WipePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The wipe shape
  final WipeShape shape;

  /// Creates a wipe page transition
  WipePageTransition({
    required this.page,
    this.shape = WipeShape.horizontal,
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
                return ClipPath(
                  clipper: _WipeClipper(
                    progress: curvedAnimation.value,
                    shape: shape,
                  ),
                  child: child,
                );
              },
              child: child,
            );
          },
        );
}

class _WipeClipper extends CustomClipper<Path> {
  final double progress;
  final WipeShape shape;

  _WipeClipper({
    required this.progress,
    required this.shape,
  });

  @override
  Path getClip(Size size) {
    final path = Path();

    switch (shape) {
      case WipeShape.horizontal:
        path.addRect(Rect.fromLTWH(0, 0, size.width * progress, size.height));
        break;
      case WipeShape.vertical:
        path.addRect(Rect.fromLTWH(0, 0, size.width, size.height * progress));
        break;
      case WipeShape.diagonal:
        final expandedSize = (size.width + size.height) * progress;
        path.moveTo(0, 0);
        path.lineTo(expandedSize, 0);
        path.lineTo(0, expandedSize);
        path.close();
        break;
      case WipeShape.circle:
        final maxRadius = math.sqrt(
          math.pow(size.width / 2, 2) + math.pow(size.height / 2, 2),
        );
        path.addOval(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: progress * maxRadius,
        ));
        break;
      case WipeShape.diamond:
        final center = Offset(size.width / 2, size.height / 2);
        final maxDist = math.max(size.width, size.height);
        final dist = progress * maxDist;
        path.moveTo(center.dx, center.dy - dist);
        path.lineTo(center.dx + dist, center.dy);
        path.lineTo(center.dx, center.dy + dist);
        path.lineTo(center.dx - dist, center.dy);
        path.close();
        break;
      case WipeShape.star:
      case WipeShape.heart:
        // Fallback to circle for complex shapes
        final maxRadius = math.sqrt(
          math.pow(size.width / 2, 2) + math.pow(size.height / 2, 2),
        );
        path.addOval(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: progress * maxRadius,
        ));
        break;
    }

    return path;
  }

  @override
  bool shouldReclip(_WipeClipper oldClipper) {
    return progress != oldClipper.progress;
  }
}

/// Spotlight reveal transition
class SpotlightPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The starting position of the spotlight
  final Alignment spotlightPosition;

  /// Creates a spotlight page transition
  SpotlightPageTransition({
    required this.page,
    this.spotlightPosition = Alignment.center,
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
                return ShaderMask(
                  shaderCallback: (bounds) {
                    final centerX = (spotlightPosition.x + 1) / 2 * bounds.width;
                    final centerY = (spotlightPosition.y + 1) / 2 * bounds.height;
                    // ignore: unused_local_variable
                    final maxRadius = math.sqrt(
                      math.pow(bounds.width, 2) + math.pow(bounds.height, 2),
                    );

                    return RadialGradient(
                      center: Alignment(
                        (centerX / bounds.width) * 2 - 1,
                        (centerY / bounds.height) * 2 - 1,
                      ),
                      radius: curvedAnimation.value * 2,
                      colors: const [
                        Colors.white,
                        Colors.white,
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.8, 1.0],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  child: child,
                );
              },
              child: child,
            );
          },
        );
}

/// Pixelate transition
class PixelatePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Maximum pixel size
  final double maxPixelSize;

  /// Creates a pixelate page transition
  PixelatePageTransition({
    required this.page,
    this.maxPixelSize = 20.0,
    Duration duration = const Duration(milliseconds: 500),
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
                // Pixelation decreases as animation progresses
                final pixelFactor = (1 - t) * maxPixelSize;

                if (pixelFactor < 1) {
                  return Opacity(opacity: t, child: child);
                }

                return Opacity(
                  opacity: t.clamp(0.0, 1.0),
                  child: child,
                );
              },
              child: child,
            );
          },
        );
}
