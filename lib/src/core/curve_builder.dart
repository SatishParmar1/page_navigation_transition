import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Fluent curve builder for creating custom animation curves
///
/// Provides a builder pattern for constructing complex curves
/// from simpler components.
///
/// Example:
/// ```dart
/// final curve = CurveBuilder()
///   .spring(damping: 0.7)
///   .build();
/// ```
class CurveBuilder {
  Curve _curve = Curves.linear;

  /// Creates a new curve builder starting with linear
  CurveBuilder();

  /// Creates a curve builder starting with the given curve
  CurveBuilder.from(Curve curve) : _curve = curve;

  /// Applies spring physics to the curve
  CurveBuilder spring({
    double damping = 0.7,
    double stiffness = 100.0,
    double mass = 1.0,
  }) {
    _curve = CustomSpringCurve(
      damping: damping,
      stiffness: stiffness,
      mass: mass,
    );
    return this;
  }

  /// Applies bounce effect to the curve
  CurveBuilder bounce({int bounces = 3, double bounciness = 0.5}) {
    _curve = CustomBounceCurve(bounces: bounces, bounciness: bounciness);
    return this;
  }

  /// Applies elastic effect to the curve
  CurveBuilder elastic({double period = 0.4, double amplitude = 1.0}) {
    _curve = CustomElasticCurve(period: period, amplitude: amplitude);
    return this;
  }

  /// Applies ease-in effect
  CurveBuilder easeIn({double strength = 2.0}) {
    _curve = Interval(0.0, 1.0, curve: Curves.easeIn);
    return this;
  }

  /// Applies ease-out effect
  CurveBuilder easeOut({double strength = 2.0}) {
    _curve = Interval(0.0, 1.0, curve: Curves.easeOut);
    return this;
  }

  /// Applies ease-in-out effect
  CurveBuilder easeInOut({double strength = 2.0}) {
    _curve = Interval(0.0, 1.0, curve: Curves.easeInOut);
    return this;
  }

  /// Reverses the curve
  CurveBuilder reverse() {
    _curve = _curve.flipped;
    return this;
  }

  /// Chains this curve with another
  CurveBuilder chain(Curve other) {
    final current = _curve;
    _curve = _ChainedCurve(current, other);
    return this;
  }

  /// Applies the curve only to a portion of the animation
  CurveBuilder interval(double begin, double end) {
    _curve = Interval(begin, end, curve: _curve);
    return this;
  }

  /// Delays the start of the curve
  CurveBuilder delay(double amount) {
    _curve = Interval(amount, 1.0, curve: _curve);
    return this;
  }

  /// Builds the final curve
  Curve build() => _curve;
}

/// Custom spring curve with configurable physics
class CustomSpringCurve extends Curve {
  /// Damping ratio (0-1, where 1 is critically damped)
  final double damping;

  /// Spring stiffness
  final double stiffness;

  /// Mass of the spring
  final double mass;

  /// Creates a custom spring curve
  const CustomSpringCurve({
    this.damping = 0.7,
    this.stiffness = 100.0,
    this.mass = 1.0,
  });

  @override
  double transformInternal(double t) {
    // Simplified spring physics approximation
    final omega = math.sqrt(stiffness / mass);
    final dampedOmega = omega * math.sqrt(1 - damping * damping);

    if (damping >= 1.0) {
      // Critically or over-damped
      return 1 - (1 + omega * t) * math.exp(-omega * t);
    } else {
      // Under-damped (oscillating)
      return 1 -
          math.exp(-damping * omega * t) *
              (math.cos(dampedOmega * t) +
                  (damping * omega / dampedOmega) * math.sin(dampedOmega * t));
    }
  }
}

/// Custom bounce curve with configurable bounces
class CustomBounceCurve extends Curve {
  /// Number of bounces
  final int bounces;

  /// Bounciness factor (0-1)
  final double bounciness;

  /// Creates a custom bounce curve
  const CustomBounceCurve({this.bounces = 3, this.bounciness = 0.5});

  @override
  double transformInternal(double t) {
    // Calculate bounce segments
    double result = t;
    double amplitude = 1.0;
    double segmentStart = 0.0;
    double segmentLength = 1.0;

    for (int i = 0; i <= bounces; i++) {
      segmentLength = 1.0 / math.pow(2, i);
      final segmentEnd = segmentStart + segmentLength;

      if (t <= segmentEnd || i == bounces) {
        final localT = (t - segmentStart) / segmentLength;
        // Parabolic bounce
        result = 1 - amplitude * 4 * (localT - 0.5) * (localT - 0.5);
        if (i > 0) {
          result = 1 - (1 - result) * amplitude;
        }
        break;
      }

      segmentStart = segmentEnd;
      amplitude *= bounciness;
    }

    return result.clamp(0.0, 1.0);
  }
}

/// Custom elastic curve with configurable period and amplitude
class CustomElasticCurve extends Curve {
  /// Period of oscillation
  final double period;

  /// Amplitude of oscillation
  final double amplitude;

  /// Creates a custom elastic curve
  const CustomElasticCurve({this.period = 0.4, this.amplitude = 1.0});

  @override
  double transformInternal(double t) {
    if (t == 0 || t == 1) return t;

    final s = period / 4;
    final adjustedT = t - 1;

    return amplitude *
            math.pow(2, 10 * adjustedT) *
            math.sin((adjustedT - s) * (2 * math.pi) / period) +
        1;
  }
}

/// Chained curve that applies two curves in sequence
class _ChainedCurve extends Curve {
  final Curve first;
  final Curve second;

  const _ChainedCurve(this.first, this.second);

  @override
  double transformInternal(double t) {
    return second.transform(first.transform(t));
  }
}

/// Pre-built curve library with common transition curves
class TransitionCurves {
  TransitionCurves._();

  /// Smooth spring with gentle overshoot
  static const Curve smoothSpring = CustomSpringCurve(
    damping: 0.8,
    stiffness: 80.0,
  );

  /// Gentle bounce with minimal bounces
  static const Curve gentleBounce = CustomBounceCurve(
    bounces: 2,
    bounciness: 0.3,
  );

  /// Snappy curve for quick interactions
  static const Curve snappy = Interval(0.0, 1.0, curve: Curves.easeOutCubic);

  /// Dramatic curve for emphasis
  static const Curve dramatic = CustomSpringCurve(
    damping: 0.5,
    stiffness: 150.0,
  );

  /// Smooth deceleration
  static const Curve smoothDecelerate = Curves.easeOutQuint;

  /// Smooth acceleration
  static const Curve smoothAccelerate = Curves.easeInQuint;

  /// Overshoot with settle
  static const Curve overshoot = CustomSpringCurve(
    damping: 0.6,
    stiffness: 120.0,
  );

  /// Anticipation curve (slight pullback before action)
  static const Curve anticipation = Curves.easeInBack;

  /// Follow-through curve (slight overshoot after action)
  static const Curve followThrough = Curves.easeOutBack;

  /// Heavy bounce for playful animations
  static const Curve heavyBounce = CustomBounceCurve(
    bounces: 4,
    bounciness: 0.6,
  );

  /// Subtle elastic for delicate animations
  static const Curve subtleElastic = CustomElasticCurve(
    period: 0.6,
    amplitude: 0.5,
  );

  /// Material Design standard curve
  static const Curve materialStandard = Curves.easeInOutCubic;

  /// Material Design decelerated curve
  static const Curve materialDecelerated = Curves.easeOutCubic;

  /// Material Design accelerated curve
  static const Curve materialAccelerated = Curves.easeInCubic;

  /// iOS-style curve
  static const Curve iosStyle = Curves.easeInOut;
}

/// Curve segment for building complex curves
class CurveSegment {
  /// Start of the segment (0-1)
  final double start;

  /// End of the segment (0-1)
  final double end;

  /// Curve to apply in this segment
  final Curve curve;

  /// Creates a curve segment
  const CurveSegment({
    required this.start,
    required this.end,
    required this.curve,
  });
}

/// Multi-segment curve for complex animations
class SegmentedCurve extends Curve {
  /// List of curve segments
  final List<CurveSegment> segments;

  /// Creates a segmented curve
  const SegmentedCurve({required this.segments});

  @override
  double transformInternal(double t) {
    for (final segment in segments) {
      if (t >= segment.start && t <= segment.end) {
        final localT = (t - segment.start) / (segment.end - segment.start);
        return segment.curve.transform(localT);
      }
    }
    return t;
  }
}
