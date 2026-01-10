import 'package:flutter/material.dart';
import '../core/enums.dart';

/// Size transition that expands from a specified direction
class SizePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The direction to expand from
  final ExpandDirection direction;

  /// The axis along which to size
  final Axis axis;

  /// Creates a size page transition
  SizePageTransition({
    required this.page,
    this.direction = ExpandDirection.center,
    this.axis = Axis.vertical,
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

            final axisAlignment = _getAxisAlignment(direction);

            return SizeTransition(
              sizeFactor: curvedAnimation,
              axis: axis,
              axisAlignment: axisAlignment,
              child: child,
            );
          },
        );

  static double _getAxisAlignment(ExpandDirection direction) {
    switch (direction) {
      case ExpandDirection.horizontal:
        return 0.0;
      case ExpandDirection.vertical:
        return 0.0;
      case ExpandDirection.center:
        return 0.0;
    }
  }
}

/// Expand horizontally transition
class ExpandHorizontalPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The alignment of the expansion (-1.0 = left, 0.0 = center, 1.0 = right)
  final double axisAlignment;

  /// Creates an expand horizontal page transition
  ExpandHorizontalPageTransition({
    required this.page,
    this.axisAlignment = 0.0,
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

            return SizeTransition(
              sizeFactor: curvedAnimation,
              axis: Axis.horizontal,
              axisAlignment: axisAlignment,
              child: child,
            );
          },
        );
}

/// Expand vertically transition
class ExpandVerticalPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The alignment of the expansion (-1.0 = top, 0.0 = center, 1.0 = bottom)
  final double axisAlignment;

  /// Creates an expand vertical page transition
  ExpandVerticalPageTransition({
    required this.page,
    this.axisAlignment = 0.0,
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

            return SizeTransition(
              sizeFactor: curvedAnimation,
              axis: Axis.vertical,
              axisAlignment: axisAlignment,
              child: child,
            );
          },
        );
}

/// Expand from center transition (both axes)
class ExpandFromCenterPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates an expand from center page transition
  ExpandFromCenterPageTransition({
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

            return ScaleTransition(
              scale: curvedAnimation,
              child: child,
            );
          },
        );
}

/// Clip rect transition (reveals page with a growing rectangle)
class ClipRectPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The alignment from which to expand
  final Alignment alignment;

  /// Creates a clip rect page transition
  ClipRectPageTransition({
    required this.page,
    this.alignment = Alignment.center,
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

            return ClipRect(
              clipper: _ExpandingRectClipper(
                progress: curvedAnimation.value,
                alignment: alignment,
              ),
              child: child,
            );
          },
        );
}

class _ExpandingRectClipper extends CustomClipper<Rect> {
  final double progress;
  final Alignment alignment;

  _ExpandingRectClipper({
    required this.progress,
    required this.alignment,
  });

  @override
  Rect getClip(Size size) {
    final centerX = (alignment.x + 1) / 2 * size.width;
    final centerY = (alignment.y + 1) / 2 * size.height;

    final maxDistance = size.width > size.height ? size.width : size.height;
    final currentSize = progress * maxDistance * 2;

    return Rect.fromCenter(
      center: Offset(centerX, centerY),
      width: currentSize,
      height: currentSize,
    );
  }

  @override
  bool shouldReclip(_ExpandingRectClipper oldClipper) {
    return progress != oldClipper.progress || alignment != oldClipper.alignment;
  }
}

/// Align-based size transition
class AlignSizePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The starting alignment
  final Alignment beginAlignment;

  /// The ending alignment
  final Alignment endAlignment;

  /// Creates an align-based size page transition
  AlignSizePageTransition({
    required this.page,
    this.beginAlignment = Alignment.topLeft,
    this.endAlignment = Alignment.center,
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
                return Align(
                  alignment: AlignmentTween(
                    begin: beginAlignment,
                    end: endAlignment,
                  ).evaluate(curvedAnimation),
                  child: SizeTransition(
                    sizeFactor: curvedAnimation,
                    child: child,
                  ),
                );
              },
              child: child,
            );
          },
        );
}

/// Unfold transition (like unfolding paper)
class UnfoldPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Whether to unfold horizontally (true) or vertically (false)
  final bool horizontal;

  /// Creates an unfold page transition
  UnfoldPageTransition({
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

            return SizeTransition(
              sizeFactor: curvedAnimation,
              axis: horizontal ? Axis.horizontal : Axis.vertical,
              axisAlignment: -1.0,
              child: FadeTransition(
                opacity: curvedAnimation,
                child: child,
              ),
            );
          },
        );
}

/// Split transition (splits in two and expands)
class SplitPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Whether to split horizontally
  final bool horizontal;

  /// Creates a split page transition
  SplitPageTransition({
    required this.page,
    this.horizontal = true,
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
                return ClipRect(
                  child: Stack(
                    children: [
                      // First half
                      Positioned(
                        left: horizontal ? 0 : null,
                        right: horizontal ? null : 0,
                        top: horizontal ? null : 0,
                        bottom: horizontal ? null : null,
                        child: ClipRect(
                          clipper: _SplitClipper(
                            progress: curvedAnimation.value,
                            isFirstHalf: true,
                            horizontal: horizontal,
                          ),
                          child: child,
                        ),
                      ),
                      // Second half
                      Positioned(
                        left: horizontal ? null : 0,
                        right: horizontal ? 0 : null,
                        top: horizontal ? null : null,
                        bottom: horizontal ? null : 0,
                        child: ClipRect(
                          clipper: _SplitClipper(
                            progress: curvedAnimation.value,
                            isFirstHalf: false,
                            horizontal: horizontal,
                          ),
                          child: child,
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: child,
            );
          },
        );
}

class _SplitClipper extends CustomClipper<Rect> {
  final double progress;
  final bool isFirstHalf;
  final bool horizontal;

  _SplitClipper({
    required this.progress,
    required this.isFirstHalf,
    required this.horizontal,
  });

  @override
  Rect getClip(Size size) {
    if (horizontal) {
      final halfWidth = size.width / 2;
      final expandedWidth = halfWidth * progress;

      if (isFirstHalf) {
        return Rect.fromLTWH(0, 0, expandedWidth, size.height);
      } else {
        return Rect.fromLTWH(
          size.width - expandedWidth,
          0,
          expandedWidth,
          size.height,
        );
      }
    } else {
      final halfHeight = size.height / 2;
      final expandedHeight = halfHeight * progress;

      if (isFirstHalf) {
        return Rect.fromLTWH(0, 0, size.width, expandedHeight);
      } else {
        return Rect.fromLTWH(
          0,
          size.height - expandedHeight,
          size.width,
          expandedHeight,
        );
      }
    }
  }

  @override
  bool shouldReclip(_SplitClipper oldClipper) {
    return progress != oldClipper.progress;
  }
}
