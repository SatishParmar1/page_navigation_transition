import 'package:flutter/material.dart';
import '../core/base_transition.dart';
import '../core/enums.dart';

/// Hero-aware slide page transition
///
/// A slide transition that coordinates with Flutter's Hero widget animations.
/// Use this when you have Hero widgets that should animate alongside
/// the page transition.
///
/// Example:
/// ```dart
/// Navigator.push(
///   context,
///   HeroSlidePageTransition(
///     page: DetailPage(),
///     heroTag: 'product-image-${product.id}',
///   ),
/// );
/// ```
class HeroSlidePageTransition<T> extends BasePageTransition<T> {
  /// Optional hero tag for coordination
  final String? heroTag;

  /// Direction of the slide
  final SlideDirection direction;

  /// Creates a hero-aware slide transition
  HeroSlidePageTransition({
    required super.page,
    this.heroTag,
    this.direction = SlideDirection.fromRight,
    super.duration = const Duration(milliseconds: 300),
    super.curve = Curves.easeInOut,
    super.settings,
  }) : super(maintainStateData: true);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final offsetTween = _getOffsetTween();
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: curve,
      reverseCurve: reverseCurve,
    );

    return SlideTransition(
      position: offsetTween.animate(curvedAnimation),
      child: child,
    );
  }

  Tween<Offset> _getOffsetTween() {
    switch (direction) {
      case SlideDirection.fromRight:
        return Tween(begin: const Offset(1.0, 0.0), end: Offset.zero);
      case SlideDirection.fromLeft:
        return Tween(begin: const Offset(-1.0, 0.0), end: Offset.zero);
      case SlideDirection.fromTop:
        return Tween(begin: const Offset(0.0, -1.0), end: Offset.zero);
      case SlideDirection.fromBottom:
        return Tween(begin: const Offset(0.0, 1.0), end: Offset.zero);
      case SlideDirection.fromTopRight:
        return Tween(begin: const Offset(1.0, -1.0), end: Offset.zero);
      case SlideDirection.fromTopLeft:
        return Tween(begin: const Offset(-1.0, -1.0), end: Offset.zero);
      case SlideDirection.fromBottomRight:
        return Tween(begin: const Offset(1.0, 1.0), end: Offset.zero);
      case SlideDirection.fromBottomLeft:
        return Tween(begin: const Offset(-1.0, 1.0), end: Offset.zero);
    }
  }
}

/// Hero-aware fade page transition
///
/// A fade transition that coordinates with Flutter's Hero widget animations.
/// The fade timing is optimized to not interfere with hero animations.
class HeroFadePageTransition<T> extends BasePageTransition<T> {
  /// Optional hero tag for coordination
  final String? heroTag;

  /// Whether to also apply a subtle scale
  final bool includeScale;

  /// Starting scale (if includeScale is true)
  final double beginScale;

  /// Creates a hero-aware fade transition
  HeroFadePageTransition({
    required super.page,
    this.heroTag,
    this.includeScale = false,
    this.beginScale = 0.95,
    super.duration = const Duration(milliseconds: 300),
    super.curve = Curves.easeInOut,
    super.settings,
  }) : super(maintainStateData: true);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: curve,
      reverseCurve: reverseCurve,
    );

    Widget result = FadeTransition(opacity: curvedAnimation, child: child);

    if (includeScale) {
      result = ScaleTransition(
        scale: Tween<double>(
          begin: beginScale,
          end: 1.0,
        ).animate(curvedAnimation),
        child: result,
      );
    }

    return result;
  }
}

/// Hero-aware scale page transition
///
/// A scale transition that coordinates with Flutter's Hero widget animations.
/// The bounding box expands from an origin point while heroes animate.
class HeroScalePageTransition<T> extends BasePageTransition<T> {
  /// Optional hero tag for coordination
  final String? heroTag;

  /// Starting scale
  final double beginScale;

  /// Scale origin (alignment)
  final Alignment alignment;

  /// Creates a hero-aware scale transition
  HeroScalePageTransition({
    required super.page,
    this.heroTag,
    this.beginScale = 0.0,
    this.alignment = Alignment.center,
    super.duration = const Duration(milliseconds: 300),
    super.curve = Curves.easeInOut,
    super.settings,
  }) : super(maintainStateData: true);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
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
      alignment: alignment,
      child: FadeTransition(opacity: curvedAnimation, child: child),
    );
  }
}

/// Hero-aware zoom page transition
///
/// A zoom transition optimized for hero animations where content
/// zooms from a source location.
class HeroZoomPageTransition<T> extends BasePageTransition<T> {
  /// Optional hero tag for coordination
  final String? heroTag;

  /// Source rectangle to zoom from (optional)
  final Rect? sourceRect;

  /// Starting scale
  final double beginScale;

  /// Creates a hero-aware zoom transition
  HeroZoomPageTransition({
    required super.page,
    this.heroTag,
    this.sourceRect,
    this.beginScale = 0.85,
    super.duration = const Duration(milliseconds: 350),
    super.curve = Curves.easeOutCubic,
    super.settings,
  }) : super(maintainStateData: true);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: curve,
      reverseCurve: reverseCurve,
    );

    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animation,
          curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
        ),
      ),
      child: ScaleTransition(
        scale: Tween<double>(
          begin: beginScale,
          end: 1.0,
        ).animate(curvedAnimation),
        child: child,
      ),
    );
  }
}

/// Hero-aware container transform transition
///
/// Mimics Material Design's container transform pattern where
/// a widget expands to fill the screen.
class HeroContainerTransformTransition<T> extends BasePageTransition<T> {
  /// Hero tag for the transform
  final String heroTag;

  /// Container color during transform
  final Color containerColor;

  /// Initial border radius
  final double beginRadius;

  /// Creates a hero container transform transition
  HeroContainerTransformTransition({
    required super.page,
    required this.heroTag,
    this.containerColor = Colors.white,
    this.beginRadius = 16.0,
    super.duration = const Duration(milliseconds: 400),
    super.curve = Curves.easeInOutCubic,
    super.settings,
  }) : super(maintainStateData: true, opaqueData: false);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: curve,
      reverseCurve: reverseCurve,
    );

    final radiusTween = Tween<double>(begin: beginRadius, end: 0.0);

    return AnimatedBuilder(
      animation: curvedAnimation,
      builder: (context, _) {
        final radius = radiusTween.evaluate(curvedAnimation);
        return ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            color: containerColor,
            child: FadeTransition(opacity: curvedAnimation, child: child),
          ),
        );
      },
    );
  }
}

/// Utility class for hero transition helpers
class HeroTransitionHelper {
  HeroTransitionHelper._();

  /// Recommended duration for hero transitions
  static const Duration recommendedDuration = Duration(milliseconds: 300);

  /// Curve that works well with hero animations
  static const Curve heroMatchingCurve = Curves.easeInOutCubic;

  /// Fast hero curve for quick transitions
  static const Curve heroFastCurve = Curves.easeOutCubic;

  /// Creates a flightShuttleBuilder for custom hero animation
  static Widget Function(
    BuildContext,
    Animation<double>,
    HeroFlightDirection,
    BuildContext,
    BuildContext,
  )
  customFlightShuttle({
    double? additionalScale,
    Widget Function(Widget child)? decorator,
  }) {
    return (
      BuildContext flightContext,
      Animation<double> animation,
      HeroFlightDirection flightDirection,
      BuildContext fromHeroContext,
      BuildContext toHeroContext,
    ) {
      final Hero toHero = toHeroContext.widget as Hero;
      Widget child = toHero.child;

      if (additionalScale != null) {
        final scale = Tween<double>(
          begin: flightDirection == HeroFlightDirection.push
              ? 1.0
              : additionalScale,
          end: flightDirection == HeroFlightDirection.push
              ? additionalScale
              : 1.0,
        ).animate(animation);

        child = ScaleTransition(scale: scale, child: child);
      }

      if (decorator != null) {
        child = decorator(child);
      }

      return child;
    };
  }

  /// Creates a hero with optimized settings for page transitions
  static Hero createOptimizedHero({
    required String tag,
    required Widget child,
    bool createRectTween = true,
    Widget Function(Widget)? decorateChild,
  }) {
    return Hero(
      tag: tag,
      createRectTween: createRectTween
          ? (begin, end) => MaterialRectArcTween(begin: begin, end: end)
          : null,
      child: decorateChild != null ? decorateChild(child) : child,
    );
  }
}

/// A wrapper that makes any widget hero-aware for transitions
class HeroTransitionWrapper extends StatelessWidget {
  /// The hero tag
  final String tag;

  /// The child widget
  final Widget child;

  /// Whether to use Material-style arc animation
  final bool useMaterialArc;

  /// Optional placeholder while hero is in flight
  final Widget? placeholderBuilder;

  /// Creates a hero transition wrapper
  const HeroTransitionWrapper({
    super.key,
    required this.tag,
    required this.child,
    this.useMaterialArc = true,
    this.placeholderBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      createRectTween: useMaterialArc
          ? (begin, end) => MaterialRectArcTween(begin: begin, end: end)
          : null,
      placeholderBuilder: placeholderBuilder != null
          ? (context, heroSize, child) => placeholderBuilder!
          : null,
      child: child,
    );
  }
}
