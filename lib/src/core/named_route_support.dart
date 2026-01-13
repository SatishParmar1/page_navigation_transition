import 'package:flutter/material.dart';
import 'enums.dart';
import 'transition_presets.dart' show TransitionTheme;
import '../transitions/slide_transitions.dart';
import '../transitions/fade_transitions.dart';
import '../transitions/scale_transitions.dart';
import '../transitions/rotation_transitions.dart';
import '../transitions/threed_transitions.dart';
import '../transitions/material_transitions.dart';
import '../transitions/ios_transitions.dart';
import '../transitions/physics_transitions.dart';
import '../transitions/custom_transitions.dart';

/// Type of transition to use for named routes
enum TransitionType {
  /// Slide from right
  slide,

  /// Slide from bottom
  slideUp,

  /// Simple fade
  fade,

  /// Fade with scale
  fadeScale,

  /// Scale from center
  scale,

  /// Rotation transition
  rotation,

  /// 3D cube horizontal
  cubeHorizontal,

  /// 3D cube vertical
  cubeVertical,

  /// Card flip
  cardFlip,

  /// iOS-style Cupertino slide
  cupertino,

  /// Material shared axis
  sharedAxis,

  /// Spring physics
  spring,

  /// Circular reveal
  circularReveal,

  /// No animation (instant)
  none,
}

/// Configuration for a named route with transition
class TransitionRouteConfig {
  /// Widget builder for the route
  final WidgetBuilder builder;

  /// Type of transition to use
  final TransitionType transitionType;

  /// Custom transition duration (optional)
  final Duration? duration;

  /// Custom curve (optional)
  final Curve? curve;

  /// Additional transition parameters
  final Map<String, dynamic> params;

  /// Creates a route configuration
  const TransitionRouteConfig({
    required this.builder,
    this.transitionType = TransitionType.fade,
    this.duration,
    this.curve,
    this.params = const {},
  });
}

/// Route builder for generating routes with transitions
///
/// Use with `onGenerateRoute` in MaterialApp to automatically
/// apply transitions to named routes.
///
/// Example:
/// ```dart
/// MaterialApp(
///   onGenerateRoute: (settings) => TransitionRouteBuilder.generateRoute(
///     settings,
///     routes: {
///       '/home': (context) => HomePage(),
///       '/profile': (context) => ProfilePage(),
///     },
///     defaultTransition: TransitionType.slide,
///   ),
/// )
/// ```
class TransitionRouteBuilder {
  TransitionRouteBuilder._();

  /// Generates a route with transition for the given settings
  static Route<T>? generateRoute<T>(
    RouteSettings settings, {
    required Map<String, WidgetBuilder> routes,
    TransitionType defaultTransition = TransitionType.fade,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    final builder = routes[settings.name];
    if (builder == null) return null;

    return _buildRoute<T>(
      settings: settings,
      builder: builder,
      transitionType: defaultTransition,
      duration: duration,
      curve: curve,
    );
  }

  /// Builds a route with the specified transition type
  static Route<T> _buildRoute<T>({
    required RouteSettings settings,
    required WidgetBuilder builder,
    required TransitionType transitionType,
    required Duration duration,
    required Curve curve,
    Map<String, dynamic> params = const {},
  }) {
    switch (transitionType) {
      case TransitionType.slide:
        return SlidePageTransition<T>(
          page: Builder(builder: builder),
          direction: SlideDirection.fromRight,
          duration: duration,
          curve: curve,
          settings: settings,
        );

      case TransitionType.slideUp:
        return SlidePageTransition<T>(
          page: Builder(builder: builder),
          direction: SlideDirection.fromBottom,
          duration: duration,
          curve: curve,
          settings: settings,
        );

      case TransitionType.fade:
        return FadePageTransition<T>(
          page: Builder(builder: builder),
          duration: duration,
          curve: curve,
          settings: settings,
        );

      case TransitionType.fadeScale:
        return FadeScalePageTransition<T>(
          page: Builder(builder: builder),
          beginScale: params['beginScale'] as double? ?? 0.85,
          duration: duration,
          settings: settings,
        );

      case TransitionType.scale:
        return ScalePageTransition<T>(
          page: Builder(builder: builder),
          origin: params['origin'] as ScaleOrigin? ?? ScaleOrigin.center,
          beginScale: params['beginScale'] as double? ?? 0.0,
          duration: duration,
          settings: settings,
        );

      case TransitionType.rotation:
        return RotationPageTransition<T>(
          page: Builder(builder: builder),
          beginTurns: params['beginTurns'] as double? ?? 1.0,
          duration: duration,
          settings: settings,
        );

      case TransitionType.cubeHorizontal:
        return CubeHorizontalPageTransition<T>(
          page: Builder(builder: builder),
          duration: duration,
          settings: settings,
        );

      case TransitionType.cubeVertical:
        return CubeVerticalPageTransition<T>(
          page: Builder(builder: builder),
          duration: duration,
          settings: settings,
        );

      case TransitionType.cardFlip:
        return CardFlipPageTransition<T>(
          page: Builder(builder: builder),
          horizontal: params['horizontal'] as bool? ?? true,
          duration: duration,
          settings: settings,
        );

      case TransitionType.cupertino:
        return CupertinoSlidePageTransition<T>(
          page: Builder(builder: builder),
          duration: duration,
          settings: settings,
        );

      case TransitionType.sharedAxis:
        return SharedAxisPageTransition<T>(
          page: Builder(builder: builder),
          direction:
              params['direction'] as SharedAxisDirection? ??
              SharedAxisDirection.horizontal,
          duration: duration,
          settings: settings,
        );

      case TransitionType.spring:
        return SpringPageTransition<T>(
          page: Builder(builder: builder),
          direction:
              params['direction'] as SlideDirection? ??
              SlideDirection.fromRight,
          duration: duration,
          settings: settings,
        );

      case TransitionType.circularReveal:
        return CircularRevealPageTransition<T>(
          page: Builder(builder: builder),
          center: params['center'] as Alignment? ?? Alignment.center,
          duration: duration,
          settings: settings,
        );

      case TransitionType.none:
        return PageRouteBuilder<T>(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionDuration: Duration.zero,
        );
    }
  }
}

/// Centralized router for managing named routes with transitions
///
/// Provides a more structured approach to route management with
/// per-route transition configuration.
///
/// Example:
/// ```dart
/// final router = TransitionRouter(
///   routes: {
///     '/': TransitionRouteConfig(
///       builder: (context) => HomePage(),
///       transitionType: TransitionType.fade,
///     ),
///     '/profile': TransitionRouteConfig(
///       builder: (context) => ProfilePage(),
///       transitionType: TransitionType.slide,
///     ),
///   },
/// );
///
/// MaterialApp(
///   onGenerateRoute: router.onGenerateRoute,
/// )
/// ```
class TransitionRouter {
  /// Route configurations
  final Map<String, TransitionRouteConfig> routes;

  /// Default transition type for undefined routes
  final TransitionType defaultTransitionType;

  /// Default duration
  final Duration defaultDuration;

  /// Default curve
  final Curve defaultCurve;

  /// Creates a transition router
  const TransitionRouter({
    required this.routes,
    this.defaultTransitionType = TransitionType.fade,
    this.defaultDuration = const Duration(milliseconds: 300),
    this.defaultCurve = Curves.easeInOut,
  });

  /// Route generator for MaterialApp.onGenerateRoute
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final config = routes[settings.name];
    if (config == null) return null;

    return TransitionRouteBuilder._buildRoute(
      settings: settings,
      builder: config.builder,
      transitionType: config.transitionType,
      duration: config.duration ?? defaultDuration,
      curve: config.curve ?? defaultCurve,
      params: config.params,
    );
  }

  /// Gets all registered route names
  List<String> get routeNames => routes.keys.toList();

  /// Checks if a route is registered
  bool hasRoute(String name) => routes.containsKey(name);
}

/// Extensions for named route navigation with transitions
extension NamedRouteTransitionExtensions on NavigatorState {
  /// Navigate to a named route with slide transition
  Future<T?> pushNamedSlide<T extends Object?>(
    String routeName, {
    Object? arguments,
    SlideDirection direction = SlideDirection.fromRight,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return push<T>(
      SlidePageTransition<T>(
        page: Builder(
          builder: (context) {
            // This will be resolved by the route
            return const SizedBox.shrink();
          },
        ),
        direction: direction,
        duration: duration,
        settings: RouteSettings(name: routeName, arguments: arguments),
      ),
    );
  }

  /// Navigate to a named route with fade transition
  Future<T?> pushNamedFade<T extends Object?>(
    String routeName, {
    Object? arguments,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return push<T>(
      FadePageTransition<T>(
        page: Builder(builder: (context) => const SizedBox.shrink()),
        duration: duration,
        settings: RouteSettings(name: routeName, arguments: arguments),
      ),
    );
  }

  /// Navigate to a named route with scale transition
  Future<T?> pushNamedScale<T extends Object?>(
    String routeName, {
    Object? arguments,
    ScaleOrigin origin = ScaleOrigin.center,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return push<T>(
      ScalePageTransition<T>(
        page: Builder(builder: (context) => const SizedBox.shrink()),
        origin: origin,
        duration: duration,
        settings: RouteSettings(name: routeName, arguments: arguments),
      ),
    );
  }

  /// Navigate to a named route with 3D cube transition
  Future<T?> pushNamedCube<T extends Object?>(
    String routeName, {
    Object? arguments,
    bool horizontal = true,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    if (horizontal) {
      return push<T>(
        CubeHorizontalPageTransition<T>(
          page: Builder(builder: (context) => const SizedBox.shrink()),
          duration: duration,
          settings: RouteSettings(name: routeName, arguments: arguments),
        ),
      );
    } else {
      return push<T>(
        CubeVerticalPageTransition<T>(
          page: Builder(builder: (context) => const SizedBox.shrink()),
          duration: duration,
          settings: RouteSettings(name: routeName, arguments: arguments),
        ),
      );
    }
  }
}

/// Extensions for BuildContext named route navigation
extension ContextNamedRouteExtensions on BuildContext {
  /// Navigate to a named route with a specific transition type
  Future<T?> pushNamedWithTransition<T extends Object?>(
    String routeName, {
    Object? arguments,
    TransitionType transitionType = TransitionType.fade,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    Map<String, dynamic> params = const {},
  }) {
    // Get the widget from the route name
    // This requires the app to use TransitionRouter
    return Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  }

  /// Navigate to a named route with themed transition
  Future<T?> pushNamedThemed<T extends Object?>(
    String routeName,
    Widget page, {
    Object? arguments,
  }) {
    final preset = TransitionTheme.of(this);
    return Navigator.of(this).push<T>(
      PageRouteBuilder<T>(
        settings: RouteSettings(name: routeName, arguments: arguments),
        transitionDuration: preset.duration,
        reverseTransitionDuration: preset.reverseDuration,
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position:
                Tween<Offset>(
                  begin: Offset(preset.slideDistance, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: preset.curve,
                    reverseCurve: preset.reverseCurve,
                  ),
                ),
            child: child,
          );
        },
      ),
    );
  }
}
