import 'package:flutter/material.dart';

/// Transition preset configuration
///
/// Pre-configured transition settings for different app styles and themes.
/// Use these presets to maintain consistent animation feel throughout your app.
///
/// Example:
/// ```dart
/// Navigator.push(
///   context,
///   SlidePageTransition(
///     page: NextPage(),
///     duration: TransitionPreset.elegant.duration,
///     curve: TransitionPreset.elegant.curve,
///   ),
/// );
/// ```
class TransitionPreset {
  /// Duration of the transition
  final Duration duration;

  /// Duration of the reverse transition
  final Duration reverseDuration;

  /// Forward animation curve
  final Curve curve;

  /// Reverse animation curve
  final Curve reverseCurve;

  /// Whether to enable haptic feedback
  final bool enableHaptics;

  /// Perspective value for 3D effects (lower = more dramatic)
  final double perspective;

  /// Scale factor for scale-based transitions
  final double scaleFactor;

  /// Slide distance factor for slide transitions
  final double slideDistance;

  /// Creates a transition preset
  const TransitionPreset({
    required this.duration,
    required this.reverseDuration,
    required this.curve,
    required this.reverseCurve,
    this.enableHaptics = false,
    this.perspective = 0.001,
    this.scaleFactor = 0.85,
    this.slideDistance = 1.0,
  });

  /// Elegant preset - Subtle, sophisticated animations
  ///
  /// Best for: Professional apps, finance, business tools
  static const TransitionPreset elegant = TransitionPreset(
    duration: Duration(milliseconds: 350),
    reverseDuration: Duration(milliseconds: 300),
    curve: Curves.easeOutCubic,
    reverseCurve: Curves.easeInCubic,
    enableHaptics: false,
    perspective: 0.0008,
    scaleFactor: 0.92,
    slideDistance: 0.3,
  );

  /// Playful preset - Bouncy, energetic animations
  ///
  /// Best for: Kids apps, games, entertainment
  static const TransitionPreset playful = TransitionPreset(
    duration: Duration(milliseconds: 500),
    reverseDuration: Duration(milliseconds: 400),
    curve: Curves.elasticOut,
    reverseCurve: Curves.easeIn,
    enableHaptics: true,
    perspective: 0.0015,
    scaleFactor: 0.7,
    slideDistance: 1.2,
  );

  /// Professional preset - Clean, efficient animations
  ///
  /// Best for: Productivity apps, enterprise software
  static const TransitionPreset professional = TransitionPreset(
    duration: Duration(milliseconds: 250),
    reverseDuration: Duration(milliseconds: 200),
    curve: Curves.easeInOut,
    reverseCurve: Curves.easeInOut,
    enableHaptics: false,
    perspective: 0.001,
    scaleFactor: 0.95,
    slideDistance: 1.0,
  );

  /// Gaming preset - Dramatic, impactful animations
  ///
  /// Best for: Games, immersive experiences
  static const TransitionPreset gaming = TransitionPreset(
    duration: Duration(milliseconds: 400),
    reverseDuration: Duration(milliseconds: 300),
    curve: Curves.easeOutBack,
    reverseCurve: Curves.easeInBack,
    enableHaptics: true,
    perspective: 0.002,
    scaleFactor: 0.6,
    slideDistance: 1.5,
  );

  /// Minimal preset - Fast, no-nonsense animations
  ///
  /// Best for: Utility apps, tools, accessibility-focused apps
  static const TransitionPreset minimal = TransitionPreset(
    duration: Duration(milliseconds: 150),
    reverseDuration: Duration(milliseconds: 150),
    curve: Curves.easeOut,
    reverseCurve: Curves.easeIn,
    enableHaptics: false,
    perspective: 0.001,
    scaleFactor: 1.0,
    slideDistance: 0.5,
  );

  /// iOS-style preset - Native iOS feel
  ///
  /// Best for: Apps targeting iOS users
  static const TransitionPreset iosStyle = TransitionPreset(
    duration: Duration(milliseconds: 400),
    reverseDuration: Duration(milliseconds: 400),
    curve: Curves.easeInOut,
    reverseCurve: Curves.easeInOut,
    enableHaptics: false,
    perspective: 0.001,
    scaleFactor: 0.94,
    slideDistance: 1.0,
  );

  /// Material Design preset - Standard Material feel
  ///
  /// Best for: Apps following Material Design guidelines
  static const TransitionPreset material = TransitionPreset(
    duration: Duration(milliseconds: 300),
    reverseDuration: Duration(milliseconds: 300),
    curve: Curves.easeInOutCubic,
    reverseCurve: Curves.easeInOutCubic,
    enableHaptics: false,
    perspective: 0.001,
    scaleFactor: 0.85,
    slideDistance: 1.0,
  );

  /// Cinematic preset - Slow, dramatic animations
  ///
  /// Best for: Media apps, portfolios, showcases
  static const TransitionPreset cinematic = TransitionPreset(
    duration: Duration(milliseconds: 600),
    reverseDuration: Duration(milliseconds: 500),
    curve: Curves.easeOutQuart,
    reverseCurve: Curves.easeInQuart,
    enableHaptics: false,
    perspective: 0.0005,
    scaleFactor: 0.8,
    slideDistance: 0.8,
  );

  /// Creates a copy with modified values
  TransitionPreset copyWith({
    Duration? duration,
    Duration? reverseDuration,
    Curve? curve,
    Curve? reverseCurve,
    bool? enableHaptics,
    double? perspective,
    double? scaleFactor,
    double? slideDistance,
  }) {
    return TransitionPreset(
      duration: duration ?? this.duration,
      reverseDuration: reverseDuration ?? this.reverseDuration,
      curve: curve ?? this.curve,
      reverseCurve: reverseCurve ?? this.reverseCurve,
      enableHaptics: enableHaptics ?? this.enableHaptics,
      perspective: perspective ?? this.perspective,
      scaleFactor: scaleFactor ?? this.scaleFactor,
      slideDistance: slideDistance ?? this.slideDistance,
    );
  }
}

/// Theme-aware transition configuration
///
/// Use [TransitionTheme] as an ancestor widget to provide default
/// transition settings to all descendants.
///
/// Example:
/// ```dart
/// TransitionTheme(
///   preset: TransitionPreset.elegant,
///   child: MaterialApp(...),
/// )
/// ```
class TransitionTheme extends InheritedWidget {
  /// The transition preset to use
  final TransitionPreset preset;

  /// Creates a transition theme
  const TransitionTheme({
    super.key,
    required this.preset,
    required super.child,
  });

  /// Gets the transition preset from the nearest ancestor
  static TransitionPreset of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<TransitionTheme>();
    return theme?.preset ?? TransitionPreset.material;
  }

  /// Gets the transition preset without registering for updates
  static TransitionPreset? maybeOf(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<TransitionTheme>();
    return theme?.preset;
  }

  @override
  bool updateShouldNotify(TransitionTheme oldWidget) {
    return preset != oldWidget.preset;
  }
}

/// Themed page transitions that automatically use the current theme's preset
class ThemedPageTransitions {
  ThemedPageTransitions._();

  /// Creates a slide transition using the current theme preset
  static PageRouteBuilder<T> slide<T>(
    BuildContext context,
    Widget page, {
    Offset begin = const Offset(1.0, 0.0),
    RouteSettings? settings,
  }) {
    final preset = TransitionTheme.of(context);
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: preset.duration,
      reverseTransitionDuration: preset.reverseDuration,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position:
              Tween<Offset>(
                begin: begin * preset.slideDistance,
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
    );
  }

  /// Creates a fade transition using the current theme preset
  static PageRouteBuilder<T> fade<T>(
    BuildContext context,
    Widget page, {
    RouteSettings? settings,
  }) {
    final preset = TransitionTheme.of(context);
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: preset.duration,
      reverseTransitionDuration: preset.reverseDuration,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: preset.curve,
            reverseCurve: preset.reverseCurve,
          ),
          child: child,
        );
      },
    );
  }

  /// Creates a scale transition using the current theme preset
  static PageRouteBuilder<T> scale<T>(
    BuildContext context,
    Widget page, {
    Alignment alignment = Alignment.center,
    RouteSettings? settings,
  }) {
    final preset = TransitionTheme.of(context);
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: preset.duration,
      reverseTransitionDuration: preset.reverseDuration,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: preset.scaleFactor, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              curve: preset.curve,
              reverseCurve: preset.reverseCurve,
            ),
          ),
          alignment: alignment,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }

  /// Creates a fade-through transition using the current theme preset
  static PageRouteBuilder<T> fadeThrough<T>(
    BuildContext context,
    Widget page, {
    RouteSettings? settings,
  }) {
    final preset = TransitionTheme.of(context);
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: preset.duration,
      reverseTransitionDuration: preset.reverseDuration,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: const Interval(0.0, 0.5),
          ),
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 0.92,
              end: 1.0,
            ).animate(CurvedAnimation(parent: animation, curve: preset.curve)),
            child: child,
          ),
        );
      },
    );
  }
}
