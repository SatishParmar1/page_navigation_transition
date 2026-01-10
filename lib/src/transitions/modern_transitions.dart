import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;

/// Frosted glass fade-in transition
class GlassmorphismPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Maximum blur sigma for the glass effect
  final double maxBlur;

  /// Creates a glassmorphism page transition
  GlassmorphismPageTransition({
    required this.page,
    this.maxBlur = 15.0,
    Duration duration = const Duration(milliseconds: 400),
    Duration reverseDuration = const Duration(milliseconds: 400),
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

            return AnimatedBuilder(
              animation: curvedAnimation,
              builder: (context, _) {
                final blur = (1 - curvedAnimation.value) * maxBlur;

                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
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

/// Sliding glass panels transition
class SlidingGlassPanelsPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Number of panels
  final int panelCount;

  /// Creates a sliding glass panels page transition
  SlidingGlassPanelsPageTransition({
    required this.page,
    this.panelCount = 4,
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
              curve: Curves.easeInOut,
            );

            return AnimatedBuilder(
              animation: curvedAnimation,
              builder: (context, _) {
                return Opacity(
                  opacity: curvedAnimation.value,
                  child: child,
                );
              },
              child: child,
            );
          },
        );
}

/// Liquid swipe transition
class LiquidSwipePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a liquid swipe page transition
  LiquidSwipePageTransition({
    required this.page,
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
                return ClipPath(
                  clipper: _LiquidClipper(progress: curvedAnimation.value),
                  child: child,
                );
              },
              child: child,
            );
          },
        );
}

class _LiquidClipper extends CustomClipper<Path> {
  final double progress;

  _LiquidClipper({required this.progress});

  @override
  Path getClip(Size size) {
    final path = Path();
    final waveWidth = size.width * 0.3;
    final startX = -waveWidth + (size.width + waveWidth * 2) * progress;

    path.moveTo(0, 0);
    path.lineTo(startX, 0);

    // Create wave effect
    for (double y = 0; y <= size.height; y += 10) {
      final waveOffset = math.sin((y / size.height) * math.pi * 2) * waveWidth * 0.5;
      path.lineTo(startX + waveOffset, y);
    }

    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(_LiquidClipper oldClipper) {
    return progress != oldClipper.progress;
  }
}

/// Wavy edge transition
class WavyEdgePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Wave frequency
  final double waveFrequency;

  /// Wave amplitude
  final double waveAmplitude;

  /// Creates a wavy edge page transition
  WavyEdgePageTransition({
    required this.page,
    this.waveFrequency = 3.0,
    this.waveAmplitude = 40.0,
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
              curve: Curves.easeInOut,
            );

            return AnimatedBuilder(
              animation: curvedAnimation,
              builder: (context, _) {
                return ClipPath(
                  clipper: _WavyClipper(
                    progress: curvedAnimation.value,
                    frequency: waveFrequency,
                    amplitude: waveAmplitude,
                  ),
                  child: child,
                );
              },
              child: child,
            );
          },
        );
}

class _WavyClipper extends CustomClipper<Path> {
  final double progress;
  final double frequency;
  final double amplitude;

  _WavyClipper({
    required this.progress,
    required this.frequency,
    required this.amplitude,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    final edgeX = size.width * progress;

    path.moveTo(0, 0);
    path.lineTo(edgeX, 0);

    // Create wavy edge
    for (double y = 0; y <= size.height; y += 5) {
      final wave = math.sin((y / size.height) * math.pi * frequency * 2) * amplitude * (1 - progress);
      path.lineTo(edgeX + wave, y);
    }

    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(_WavyClipper oldClipper) {
    return progress != oldClipper.progress;
  }
}

/// Gooey/sticky effect transition
class GooeyPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a gooey page transition
  GooeyPageTransition({
    required this.page,
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
                return ClipPath(
                  clipper: _GooeyClipper(progress: curvedAnimation.value),
                  child: child,
                );
              },
              child: child,
            );
          },
        );
}

class _GooeyClipper extends CustomClipper<Path> {
  final double progress;

  _GooeyClipper({required this.progress});

  @override
  Path getClip(Size size) {
    final path = Path();
    final centerY = size.height / 2;
    final maxBulge = size.width * 0.4;

    // Calculate edge position
    final edgeX = size.width * progress;

    path.moveTo(0, 0);
    path.lineTo(edgeX, 0);

    // Top curve
    final topControlX = edgeX + maxBulge * (1 - progress);
    path.quadraticBezierTo(topControlX, centerY * 0.5, edgeX, centerY);

    // Bottom curve
    path.quadraticBezierTo(topControlX, centerY * 1.5, edgeX, size.height);

    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(_GooeyClipper oldClipper) {
    return progress != oldClipper.progress;
  }
}

/// Splash reveal transition
class SplashRevealPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The origin of the splash
  final Alignment origin;

  /// The splash color
  final Color splashColor;

  /// Creates a splash reveal page transition
  SplashRevealPageTransition({
    required this.page,
    this.origin = Alignment.center,
    this.splashColor = Colors.blue,
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
              curve: Curves.easeOut,
            );

            return AnimatedBuilder(
              animation: curvedAnimation,
              builder: (context, _) {
                return Stack(
                  children: [
                    // Splash background
                    if (curvedAnimation.value < 1.0)
                      ClipPath(
                        clipper: _CircularRevealClipper(
                          progress: curvedAnimation.value,
                          center: origin,
                        ),
                        child: Container(color: splashColor),
                      ),
                    // Content
                    ClipPath(
                      clipper: _CircularRevealClipper(
                        progress: curvedAnimation.value,
                        center: origin,
                      ),
                      child: child,
                    ),
                  ],
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

    return Path()
      ..addOval(Rect.fromCircle(
        center: Offset(centerX, centerY),
        radius: progress * maxRadius,
      ));
  }

  @override
  bool shouldReclip(_CircularRevealClipper oldClipper) {
    return progress != oldClipper.progress;
  }
}

/// Neumorphism depth transition
class NeumorphismPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a neumorphism page transition
  NeumorphismPageTransition({
    required this.page,
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
                final elevation = curvedAnimation.value * 10;
                final scale = 0.95 + (curvedAnimation.value * 0.05);

                return Transform.scale(
                  scale: scale,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1 * curvedAnimation.value),
                          offset: Offset(elevation, elevation),
                          blurRadius: elevation * 2,
                        ),
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.7 * curvedAnimation.value),
                          offset: Offset(-elevation / 2, -elevation / 2),
                          blurRadius: elevation,
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

/// Inflate bubble effect transition
class BubbleInflatePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a bubble inflate page transition
  BubbleInflatePageTransition({
    required this.page,
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
              curve: Curves.elasticOut,
              reverseCurve: Curves.easeIn,
            );

            return AnimatedBuilder(
              animation: curvedAnimation,
              builder: (context, _) {
                return Transform.scale(
                  scale: curvedAnimation.value,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      (1 - curvedAnimation.value) * 100,
                    ),
                    child: Opacity(
                      opacity: curvedAnimation.value.clamp(0.0, 1.0),
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

/// Curtain reveal transition
class CurtainRevealPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Whether to reveal horizontally
  final bool horizontal;

  /// Creates a curtain reveal page transition
  CurtainRevealPageTransition({
    required this.page,
    this.horizontal = true,
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
              curve: Curves.easeInOut,
            );

            return AnimatedBuilder(
              animation: curvedAnimation,
              builder: (context, _) {
                return ClipRect(
                  clipper: _CurtainClipper(
                    progress: curvedAnimation.value,
                    horizontal: horizontal,
                  ),
                  child: child,
                );
              },
              child: child,
            );
          },
        );
}

class _CurtainClipper extends CustomClipper<Rect> {
  final double progress;
  final bool horizontal;

  _CurtainClipper({
    required this.progress,
    required this.horizontal,
  });

  @override
  Rect getClip(Size size) {
    if (horizontal) {
      final centerX = size.width / 2;
      final openWidth = progress * centerX;
      return Rect.fromLTRB(
        centerX - openWidth,
        0,
        centerX + openWidth,
        size.height,
      );
    } else {
      final centerY = size.height / 2;
      final openHeight = progress * centerY;
      return Rect.fromLTRB(
        0,
        centerY - openHeight,
        size.width,
        centerY + openHeight,
      );
    }
  }

  @override
  bool shouldReclip(_CurtainClipper oldClipper) {
    return progress != oldClipper.progress;
  }
}
