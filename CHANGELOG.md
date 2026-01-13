# Changelog

## [1.1.0]

### Added - New Features

#### 🛤️ Named Route Support
- `TransitionRouter` - Centralized route configuration with per-route transitions
- `TransitionRouteBuilder` - Generate routes with transitions for `onGenerateRoute`
- `TransitionRouteConfig` - Configure individual route transitions
- `TransitionType` enum for specifying transition types
- Extension methods: `pushNamedSlide`, `pushNamedFade`, `pushNamedScale`, `pushNamedCube`

#### 🦸 Hero Transitions
- `HeroSlidePageTransition` - Hero-aware slide transition
- `HeroFadePageTransition` - Hero-aware fade transition
- `HeroScalePageTransition` - Hero-aware scale transition
- `HeroZoomPageTransition` - Hero-aware zoom transition
- `HeroContainerTransformTransition` - Material container transform with hero
- `HeroTransitionHelper` - Utilities for hero animations
- `HeroTransitionWrapper` - Widget wrapper for hero setup

#### 🎨 Transition Presets & Themes
- `TransitionPreset` class with 8 pre-configured themes:
  - `elegant` - Subtle, sophisticated animations
  - `playful` - Bouncy, energetic animations
  - `professional` - Clean, efficient animations
  - `gaming` - Dramatic, impactful animations
  - `minimal` - Fast, no-nonsense animations
  - `iosStyle` - Native iOS feel
  - `material` - Material Design standard
  - `cinematic` - Slow, dramatic animations
- `TransitionTheme` inherited widget for app-wide theming
- `ThemedPageTransitions` - Automatically use theme preset

#### 🔧 Custom Curve Builder
- `CurveBuilder` - Fluent API for creating custom curves
- `CustomSpringCurve` - Configurable spring physics
- `CustomBounceCurve` - Configurable bounce with multiple bounces
- `CustomElasticCurve` - Configurable elastic oscillation
- `TransitionCurves` - 15+ pre-built curves library
- `SegmentedCurve` - Multi-segment curve support

#### 🎲 New 3D Effects (6 new transitions)
- `OrigamiPageTransition` - Paper-folding effect with configurable folds
- `PrismPageTransition` - Triangular prism rotation effect
- `SpherePageTransition` - Spherical distortion effect
- `ZStackPageTransition` - Depth stacking effect
- `LayeredDepthPageTransition` - Multi-layer parallax depth
- `HologramPageTransition` - Futuristic hologram with flicker effect

#### ⚡ Performance Optimizations
- `OptimizedTransitionWrapper` - RepaintBoundary wrapper
- `CachedMatrixBuilder` - Matrix caching for 3D effects
- `AccessibilityHelper` - Reduced motion detection and adaptation
- `PerformanceConfig` - Configurable performance settings
- `TransitionPerformanceMonitor` - Debug frame rate monitoring

### Changed
- `TransitionTheme` enum renamed to `TransitionStyle` to avoid naming conflict

---

## [1.0.0]

- **Slide Transitions** (8 effects) - Basic slides, Push, Cover, Reveal, Parallax, Elastic, Bouncy
- **Fade Transitions** (7 effects) - Fade, FadeScale, FadeRotation, FadeThrough, CrossFade
- **Scale Transitions** (8 effects) - Scale, Zoom In/Out, Pop, Shrink/Grow

## [1.0.0] 

### Added
- 🎉 Initial release with **100+ page navigation transitions**
- **10 transition categories:**
  - **Rotation Transitions** (9 effects) - Rotate, Flip Horizontal/Vertical, Spin, Door, Tilt
  - **Size Transitions** (6 effects) - Expand Horizontal/Vertical, Split, Unfold, ClipRect
  - **Material Design Transitions** (6 effects) - Shared Axis, Container Transform, Elevation
  - **iOS-Style Transitions** (7 effects) - Cupertino, Modal, Sheet, Page Curl, App Store Card
  - **3D Transitions** (9 effects) - Cube, Card Flip, Carousel, Cover Flow, Perspective
  - **Physics-Based Transitions** (7 effects) - Spring, Gravity, Elastic Bounce, Pendulum
  - **Custom Effects** (10 effects) - Circular Reveal, Blur, Glitch, Accordion, Wipe
  - **Modern UI Transitions** (9 effects) - Glassmorphism, Liquid Swipe, Gooey, Neumorphism
  - **Social Media Transitions** (8 effects) - Story, Reels, Snap, Swipe Card, Stacked Cards
  - **Accessibility Transitions** (7 effects) - No Animation, Simple Fade, Adaptive
- Extension methods on `BuildContext` and `NavigatorState` for easy navigation
- Static factory class `PageTransitions` for clean, consistent API
- Type-safe generic transitions
- Customizable duration, curves, and transition-specific parameters
- Full example app demonstrating all transitions
- Comprehensive documentation and README

### Features
- 📱 Works on iOS, Android, Web, Desktop (Windows, macOS, Linux)
- ⚡ Zero external dependencies (only Flutter SDK)
- 🎨 Highly customizable animations
- ♿ Accessibility-friendly options (respects system reduce motion)
- 📖 Well-documented API with examples
- 🧪 Type-safe with generics support
