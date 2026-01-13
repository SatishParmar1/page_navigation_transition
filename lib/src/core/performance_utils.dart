import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Optimized transition wrapper with performance enhancements
///
/// Wraps transition children with [RepaintBoundary] to reduce unnecessary
/// repaints and improve animation performance.
class OptimizedTransitionWrapper extends StatelessWidget {
  /// The child widget to wrap
  final Widget child;

  /// Whether to use RepaintBoundary (default: true)
  final bool useRepaintBoundary;

  /// Whether to use cached child (prevents rebuilds)
  final bool cacheChild;

  /// Creates an optimized transition wrapper
  const OptimizedTransitionWrapper({
    super.key,
    required this.child,
    this.useRepaintBoundary = true,
    this.cacheChild = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget result = child;

    if (useRepaintBoundary) {
      result = RepaintBoundary(child: result);
    }

    return result;
  }
}

/// Cached matrix builder for optimized 3D effects
///
/// Caches transformation matrices to avoid recalculating them
/// on every animation frame.
class CachedMatrixBuilder {
  final Map<int, Matrix4> _cache = {};
  final Matrix4 Function(double value) _builder;
  final int _precision;

  /// Creates a cached matrix builder
  ///
  /// [builder] - Function that creates a Matrix4 for a given animation value
  /// [precision] - Number of decimal places to use for caching (default: 2)
  CachedMatrixBuilder({
    required Matrix4 Function(double value) builder,
    int precision = 2,
  }) : _builder = builder,
       _precision = precision;

  /// Gets a cached matrix for the given animation value
  Matrix4 get(double value) {
    final key = (value * _multiplier).round();
    return _cache.putIfAbsent(key, () => _builder(value));
  }

  int get _multiplier => _pow10(_precision);

  static int _pow10(int n) {
    int result = 1;
    for (int i = 0; i < n; i++) {
      result *= 10;
    }
    return result;
  }

  /// Clears the cache
  void invalidate() => _cache.clear();

  /// Clears entries outside the given range
  void trimToRange(double min, double max) {
    final minKey = (min * _multiplier).round();
    final maxKey = (max * _multiplier).round();
    _cache.removeWhere((key, _) => key < minKey || key > maxKey);
  }
}

/// Helper class for accessibility-aware transitions
///
/// Provides utilities for detecting reduced motion preferences
/// and adapting animations accordingly.
class AccessibilityHelper {
  /// Whether the system prefers reduced motion
  ///
  /// Returns true if the user has enabled reduced motion in system settings.
  static bool shouldReduceMotion(BuildContext context) {
    final mediaQuery = MediaQuery.maybeOf(context);
    return mediaQuery?.disableAnimations ?? false;
  }

  /// Adapts duration based on accessibility settings
  ///
  /// Returns a shorter duration if reduced motion is preferred,
  /// otherwise returns the original duration.
  static Duration adaptDuration(BuildContext context, Duration original) {
    if (shouldReduceMotion(context)) {
      // Use a much shorter duration for reduced motion
      return Duration(
        milliseconds: (original.inMilliseconds * 0.1).round().clamp(50, 150),
      );
    }
    return original;
  }

  /// Adapts curve based on accessibility settings
  ///
  /// Returns a simpler linear curve if reduced motion is preferred,
  /// otherwise returns the original curve.
  static Curve adaptCurve(BuildContext context, Curve original) {
    if (shouldReduceMotion(context)) {
      return Curves.linear;
    }
    return original;
  }

  /// Adapts a transition for accessibility
  ///
  /// Returns a simpler fade transition if reduced motion is preferred.
  static Widget adaptTransition({
    required BuildContext context,
    required Animation<double> animation,
    required Widget child,
    required Widget Function(Animation<double> animation, Widget child) builder,
  }) {
    if (shouldReduceMotion(context)) {
      // Use simple fade for reduced motion
      return FadeTransition(opacity: animation, child: child);
    }
    return builder(animation, child);
  }
}

/// Performance configuration for transitions
class PerformanceConfig {
  /// Whether to use RepaintBoundary wrappers
  final bool useRepaintBoundary;

  /// Whether to cache transformation matrices
  final bool cacheMatrices;

  /// Whether to respect reduced motion system settings
  final bool respectReducedMotion;

  /// Matrix cache precision (decimal places)
  final int matrixCachePrecision;

  /// Creates a performance configuration
  const PerformanceConfig({
    this.useRepaintBoundary = true,
    this.cacheMatrices = true,
    this.respectReducedMotion = true,
    this.matrixCachePrecision = 2,
  });

  /// Default performance configuration
  static const PerformanceConfig defaultConfig = PerformanceConfig();

  /// High performance configuration with all optimizations enabled
  static const PerformanceConfig highPerformance = PerformanceConfig(
    useRepaintBoundary: true,
    cacheMatrices: true,
    respectReducedMotion: true,
    matrixCachePrecision: 1, // Lower precision = more cache hits
  );

  /// Low overhead configuration with minimal optimizations
  static const PerformanceConfig lowOverhead = PerformanceConfig(
    useRepaintBoundary: false,
    cacheMatrices: false,
    respectReducedMotion: true,
  );

  /// Creates a copy with modified values
  PerformanceConfig copyWith({
    bool? useRepaintBoundary,
    bool? cacheMatrices,
    bool? respectReducedMotion,
    int? matrixCachePrecision,
  }) {
    return PerformanceConfig(
      useRepaintBoundary: useRepaintBoundary ?? this.useRepaintBoundary,
      cacheMatrices: cacheMatrices ?? this.cacheMatrices,
      respectReducedMotion: respectReducedMotion ?? this.respectReducedMotion,
      matrixCachePrecision: matrixCachePrecision ?? this.matrixCachePrecision,
    );
  }
}

/// Frame rate monitor for debugging transition performance
class TransitionPerformanceMonitor {
  static TransitionPerformanceMonitor? _instance;
  final List<Duration> _frameTimes = [];
  DateTime? _lastFrameTime;
  bool _isMonitoring = false;

  /// Gets the singleton instance
  static TransitionPerformanceMonitor get instance {
    _instance ??= TransitionPerformanceMonitor._();
    return _instance!;
  }

  TransitionPerformanceMonitor._();

  /// Starts monitoring frame times
  void startMonitoring() {
    if (_isMonitoring) return;
    _isMonitoring = true;
    _frameTimes.clear();
    _lastFrameTime = null;
    SchedulerBinding.instance.addPostFrameCallback(_onFrame);
  }

  /// Stops monitoring and returns statistics
  TransitionPerformanceStats stopMonitoring() {
    _isMonitoring = false;
    return TransitionPerformanceStats(
      frameTimes: List.unmodifiable(_frameTimes),
    );
  }

  void _onFrame(Duration timestamp) {
    if (!_isMonitoring) return;

    final now = DateTime.now();
    if (_lastFrameTime != null) {
      _frameTimes.add(now.difference(_lastFrameTime!));
    }
    _lastFrameTime = now;

    SchedulerBinding.instance.addPostFrameCallback(_onFrame);
  }
}

/// Performance statistics for a transition
class TransitionPerformanceStats {
  /// Individual frame times
  final List<Duration> frameTimes;

  /// Creates performance statistics
  const TransitionPerformanceStats({required this.frameTimes});

  /// Average frame time
  Duration get averageFrameTime {
    if (frameTimes.isEmpty) return Duration.zero;
    final total = frameTimes.fold<int>(0, (sum, d) => sum + d.inMicroseconds);
    return Duration(microseconds: total ~/ frameTimes.length);
  }

  /// Average FPS
  double get averageFps {
    if (averageFrameTime.inMicroseconds == 0) return 0;
    return 1000000 / averageFrameTime.inMicroseconds;
  }

  /// Number of dropped frames (>16.67ms)
  int get droppedFrames {
    return frameTimes.where((d) => d.inMilliseconds > 16).length;
  }

  /// Percentage of smooth frames
  double get smoothFramePercentage {
    if (frameTimes.isEmpty) return 100;
    return ((frameTimes.length - droppedFrames) / frameTimes.length) * 100;
  }

  @override
  String toString() {
    return 'TransitionPerformanceStats('
        'avgFps: ${averageFps.toStringAsFixed(1)}, '
        'droppedFrames: $droppedFrames, '
        'smoothness: ${smoothFramePercentage.toStringAsFixed(1)}%)';
  }
}
