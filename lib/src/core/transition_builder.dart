import 'package:flutter/material.dart';
import 'enums.dart';

/// A builder class for creating custom transitions by chaining multiple effects
class TransitionBuilder {
  final Widget page;
  final Duration duration;
  final Duration reverseDuration;
  final Curve curve;
  final Curve reverseCurve;
  final List<Widget Function(Animation<double>, Widget)> _effects = [];

  /// Creates a transition builder
  TransitionBuilder({
    required this.page,
    this.duration = const Duration(milliseconds: 300),
    this.reverseDuration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.reverseCurve = Curves.easeInOut,
  });

  /// Adds a fade effect
  TransitionBuilder fade({double begin = 0.0, double end = 1.0}) {
    _effects.add((animation, child) {
      return FadeTransition(
        opacity: Tween<double>(begin: begin, end: end).animate(animation),
        child: child,
      );
    });
    return this;
  }

  /// Adds a slide effect
  TransitionBuilder slide({
    SlideDirection direction = SlideDirection.fromRight,
    double distance = 1.0,
  }) {
    _effects.add((animation, child) {
      final offset = _getSlideOffset(direction, distance);
      return SlideTransition(
        position: Tween<Offset>(begin: offset, end: Offset.zero).animate(animation),
        child: child,
      );
    });
    return this;
  }

  /// Adds a scale effect
  TransitionBuilder scale({
    double begin = 0.0,
    double end = 1.0,
    Alignment alignment = Alignment.center,
  }) {
    _effects.add((animation, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: begin, end: end).animate(animation),
        alignment: alignment,
        child: child,
      );
    });
    return this;
  }

  /// Adds a rotation effect
  TransitionBuilder rotate({
    double beginTurns = 0.0,
    double endTurns = 0.0,
    Alignment alignment = Alignment.center,
  }) {
    _effects.add((animation, child) {
      return RotationTransition(
        turns: Tween<double>(begin: beginTurns, end: endTurns).animate(animation),
        alignment: alignment,
        child: child,
      );
    });
    return this;
  }

  /// Adds a 3D rotation effect on X axis
  TransitionBuilder rotateX({
    double beginAngle = 0.0,
    double endAngle = 0.0,
    Alignment alignment = Alignment.center,
  }) {
    _effects.add((animation, child) {
      return AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          final angle = Tween<double>(begin: beginAngle, end: endAngle)
              .evaluate(animation);
          return Transform(
            alignment: alignment,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(angle),
            child: child,
          );
        },
        child: child,
      );
    });
    return this;
  }

  /// Adds a 3D rotation effect on Y axis
  TransitionBuilder rotateY({
    double beginAngle = 0.0,
    double endAngle = 0.0,
    Alignment alignment = Alignment.center,
  }) {
    _effects.add((animation, child) {
      return AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          final angle = Tween<double>(begin: beginAngle, end: endAngle)
              .evaluate(animation);
          return Transform(
            alignment: alignment,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: child,
          );
        },
        child: child,
      );
    });
    return this;
  }

  /// Adds a blur effect
  TransitionBuilder blur({
    double beginSigma = 10.0,
    double endSigma = 0.0,
  }) {
    _effects.add((animation, child) {
      return AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          final sigma = Tween<double>(begin: beginSigma, end: endSigma)
              .evaluate(animation);
          return ImageFiltered(
            imageFilter: sigma > 0
                ? ColorFilter.mode(
                    Colors.transparent,
                    BlendMode.srcOver,
                  )
                : ColorFilter.mode(
                    Colors.transparent,
                    BlendMode.srcOver,
                  ),
            child: child,
          );
        },
        child: child,
      );
    });
    return this;
  }

  /// Builds the page route with all chained effects
  PageRouteBuilder<T> build<T>({RouteSettings? settings}) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: duration,
      reverseTransitionDuration: reverseDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
          reverseCurve: reverseCurve,
        );

        Widget result = child;
        for (final effect in _effects) {
          result = effect(curvedAnimation, result);
        }
        return result;
      },
    );
  }

  Offset _getSlideOffset(SlideDirection direction, double distance) {
    switch (direction) {
      case SlideDirection.fromRight:
        return Offset(distance, 0);
      case SlideDirection.fromLeft:
        return Offset(-distance, 0);
      case SlideDirection.fromTop:
        return Offset(0, -distance);
      case SlideDirection.fromBottom:
        return Offset(0, distance);
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
