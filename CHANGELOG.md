# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2026-01-13

### Added

#### 🛤️ Named Route Support
- `TransitionRouter` - Centralized route configuration with per-route transitions
- `TransitionRouteBuilder` - Generate routes with transitions for `onGenerateRoute`
- `TransitionRouteConfig` - Configure individual route transitions
- `TransitionType` enum for specifying transition types
- Extension methods: `pushNamedSlide`, `pushNamedFade`, `pushNamedScale`, `pushNamedCube`

#### 🦸 Hero Transitions (5 new transitions)
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
- `OptimizedTransitionWrapper` - RepaintBoundary wrapper for smoother animations
- `CachedMatrixBuilder` - Matrix caching for 3D effects
- `AccessibilityHelper` - Reduced motion detection and adaptation
- `PerformanceConfig` - Configurable performance settings
- `TransitionPerformanceMonitor` - Debug frame rate monitoring

### Changed
- `TransitionTheme` enum renamed to `TransitionStyle` to avoid naming conflict with new `TransitionTheme` class
- Updated example app with new silver/metallic theme and Sliver-based UI
- Improved documentation with screenshots and video demo

### Fixed
- Fixed Row overflow issue in example app statistics section

---

## [1.0.0] - 2026-01-10

### Added
- 🎉 Initial release with **100+ page navigation transitions**
- **13 transition categories:**

#### 🎚️ Slide Transitions (9 effects)
- Slide, Push, Cover, Reveal, Parallax, SlideFade, SlideScale, ElasticSlide, BouncySlide

#### 🌫️ Fade Transitions (8 effects)
- Fade, FadeScale, FadeRotation, FadeSlide, FadeThrough, CrossFade, FadeZoomIn, FadeZoomOut

#### 🔍 Scale Transitions (10 effects)
- Scale, ScaleFade, ZoomIn, ZoomOut, ZoomInFade, ZoomOutFade, PopScale, ShrinkGrow, ScaleRotation, DepthScale

#### 🔄 Rotation Transitions (9 effects)
- Rotation, FlipHorizontal, FlipVertical, RotationFade, RotationScale, Spin, TiltRotation, DoorRotation, RotationScaleFade

#### 📐 Size Transitions (8 effects)
- Size, ExpandHorizontal, ExpandVertical, ExpandFromCenter, ClipRect, AlignSize, Split, Unfold

#### 🎨 Material Design Transitions (5 effects)
- SharedAxis, FadeThroughMaterial, ContainerTransform, ElevationScale, Material

#### 🍎 iOS Style Transitions (6 effects)
- CupertinoSlide, ModalSlide, PageCurl, Sheet, FullscreenModal, AppStoreCard

#### 🎲 3D Transitions (10 effects)
- CubeHorizontal, CubeVertical, InsideCube, CardFlip, Carousel, CoverFlow, CylinderWrap, PerspectiveZoom, ParallaxDepth, Fold

#### ⚡ Physics-based Transitions (9 effects)
- Spring, GravityDrop, ElasticBounce, DampedOscillation, InertiaSlide, RubberBand, Pendulum, OverScrollBounce, SpringRebound

#### ✨ Custom Effects (10 effects)
- CircularReveal, Blur, Glitch, Accordion, BookFlip, StackDepth, Shutter, Wipe, Spotlight, Pixelate

#### 💎 Modern UI Transitions (9 effects)
- Glassmorphism, SlidingGlassPanels, LiquidSwipe, WavyEdge, Gooey, SplashReveal, Neumorphism, BubbleInflate, CurtainReveal

#### 📱 Social Media Transitions (11 effects)
- Story, Reels, Snap, SlideWithBounce, Flash, CrossFadeAudio, AlbumArtExpand, NowPlayingSlide, SwipeCard, PullToDismiss, StackedCards

#### ♿ Accessibility Transitions (7 effects)
- NoAnimation, SimpleFade, MinimalMovement, OpacityOnly, TransformOnly, Adaptive, FastSnap

### Features
- Extension methods on `BuildContext` and `NavigatorState` for easy navigation
- Static factory class `PageTransitions` for clean, consistent API
- Type-safe generic transitions
- Customizable duration, curves, and transition-specific parameters
- Full example app demonstrating all transitions
- Comprehensive documentation and README

### Platform Support
- ✅ iOS
- ✅ Android
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

---

## Links

- 📦 [Package on pub.dev](https://pub.dev/packages/page_navigation_transition)
- 📱 [GitHub Repository](https://github.com/SatishParmar1/page_navigation_transition)
- 💼 [Author's LinkedIn](https://www.linkedin.com/in/satish-parmar-ak978312/)
- 📸 [Other Packages: photo_opener_view](https://pub.dev/packages/photo_opener_view)
