/// A comprehensive Flutter package for beautiful page navigation transitions.
///
/// This package provides 100+ pre-built page transitions organized into categories:
/// - Slide Transitions
/// - Fade Transitions
/// - Scale Transitions
/// - Rotation Transitions
/// - Size Transitions
/// - Material Design Transitions
/// - iOS-style Transitions
/// - 3D Transitions
/// - Physics-based Transitions
/// - Custom Effect Transitions
/// - Modern UI Transitions
/// - Social Media Transitions
/// - Accessibility-friendly Transitions
///
/// ## Usage
///
/// ### Direct Usage
/// ```dart
/// Navigator.push(
///   context,
///   SlidePageTransition(page: SecondPage()),
/// );
/// ```
///
/// ### Extension Methods
/// ```dart
/// context.pushSlide(SecondPage());
/// Navigator.of(context).pushFade(SecondPage());
/// ```
///
/// ### Static Factory Methods
/// ```dart
/// Navigator.push(
///   context,
///   PageTransitions.cubeHorizontal(SecondPage()),
/// );
/// ```
library page_navigation_transition;

// Core exports
export 'src/core/enums.dart';
export 'src/core/base_transition.dart';
export 'src/core/transition_builder.dart';
export 'src/core/performance_utils.dart';
export 'src/core/curve_builder.dart';
export 'src/core/transition_presets.dart';
export 'src/core/named_route_support.dart';

// Transition exports
export 'src/transitions/slide_transitions.dart';
export 'src/transitions/fade_transitions.dart';
export 'src/transitions/scale_transitions.dart';
export 'src/transitions/rotation_transitions.dart';
export 'src/transitions/size_transitions.dart';
export 'src/transitions/material_transitions.dart';
export 'src/transitions/ios_transitions.dart';
export 'src/transitions/threed_transitions.dart';
export 'src/transitions/physics_transitions.dart';
export 'src/transitions/custom_transitions.dart';
export 'src/transitions/modern_transitions.dart';
export 'src/transitions/social_transitions.dart';
export 'src/transitions/accessibility_transitions.dart';
export 'src/transitions/hero_transitions.dart';

// Helper exports
export 'src/helpers/navigation_extensions.dart';
export 'src/helpers/page_transitions.dart';
