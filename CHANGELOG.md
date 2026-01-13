# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 1.1.0 - 2026-01-13

### ✨ Added

#### 🛤️ Named Route Support
- Introduced `TransitionRouter` for centralized route configuration with per-route transitions.
- Added `TransitionRouteBuilder` to generate routes with transitions for `onGenerateRoute`.
- Added `TransitionRouteConfig` and `TransitionType` for granular control.
- New extension methods for easier navigation:
    - `pushNamedSlide`
    - `pushNamedFade`
    - `pushNamedScale`
    - `pushNamedCube`

#### 🦸 Hero Transitions
- Added **5 new Hero-aware transitions** that work seamlessly with Flutter's Hero animations:
    - `HeroSlidePageTransition`
    - `HeroFadePageTransition`
    - `HeroScalePageTransition`
    - `HeroZoomPageTransition`
    - `HeroContainerTransformTransition` (Material container transform implementation).
- Added `HeroTransitionHelper` and `HeroTransitionWrapper` for easier setup.

#### 🎨 Transition Presets & Themes
- Introduced `TransitionPreset` with **8 pre-configured themes**:
    - `elegant`, `playful`, `professional`, `gaming`, `minimal`, `iosStyle`, `material`, `cinematic`.
- Added `TransitionTheme` inherited widget for app-wide transition styling.
- Added `ThemedPageTransitions` to automatically apply the current theme.

#### 🔧 Custom Curve Builder
- Added `CurveBuilder` fluent API for creating custom animation curves.
- Added configurable physics curves: `CustomSpringCurve`, `CustomBounceCurve`, and `CustomElasticCurve`.
- Introduced `TransitionCurves` library with 15+ pre-built curves.
- Added `SegmentedCurve` for multi-segment animation timing.

#### 🎲 New 3D Effects
- Added **6 new advanced 3D transitions**:
    - `OrigamiPageTransition` (Paper-folding effect)
    - `PrismPageTransition`
    - `SpherePageTransition`
    - `ZStackPageTransition`
    - `LayeredDepthPageTransition`
    - `HologramPageTransition`

#### ⚡ Performance
- Added `OptimizedTransitionWrapper` (RepaintBoundary wrapper) for smoother high-load animations.
- Implemented `CachedMatrixBuilder` for 3D effect optimization.
- Added `AccessibilityHelper` for reduced motion detection.
- Added `TransitionPerformanceMonitor` for debugging frame rates.

### ♻️ Changed
- **Breaking/Rename:** Renamed `TransitionTheme` enum to `TransitionStyle` to avoid conflict with the new `TransitionTheme` class.
- Updated example app with a new silver/metallic theme and Sliver-based UI.
- Improved documentation with screenshots and video demos.

### 🐛 Fixed
- Fixed a `Row` overflow issue in the statistics section of the example app.

---

## 1.0.0 - 2026-01-10

🎉 **Initial Release**

### Summary
Initial release containing **100+ page navigation transitions** across 13 categories, full platform support, and extension methods.

### Features
- **Slide Transitions:** Slide, Push, Cover, Reveal, Parallax, SlideFade, SlideScale, ElasticSlide, BouncySlide.
- **Fade Transitions:** Fade, FadeScale, FadeRotation, FadeSlide, FadeThrough, CrossFade, FadeZoomIn, FadeZoomOut.
- **Scale Transitions:** Scale, ScaleFade, ZoomIn, ZoomOut, ZoomInFade, ZoomOutFade, PopScale, ShrinkGrow, ScaleRotation, DepthScale.
- **Rotation Transitions:** Rotation, FlipHorizontal, FlipVertical, RotationFade, RotationScale, Spin, TiltRotation, DoorRotation, RotationScaleFade.
- **Size Transitions:** Size, ExpandHorizontal, ExpandVertical, ExpandFromCenter, ClipRect, AlignSize, Split, Unfold.
- **Material Design:** SharedAxis, FadeThroughMaterial, ContainerTransform, ElevationScale, Material.
- **iOS Style:** CupertinoSlide, ModalSlide, PageCurl, Sheet, FullscreenModal, AppStoreCard.
- **3D Effects:** CubeHorizontal, CubeVertical, InsideCube, CardFlip, Carousel, CoverFlow, CylinderWrap, PerspectiveZoom, ParallaxDepth, Fold.
- **Physics-based:** Spring, GravityDrop, ElasticBounce, DampedOscillation, InertiaSlide, RubberBand, Pendulum, OverScrollBounce, SpringRebound.
- **Custom Effects:** CircularReveal, Blur, Glitch, Accordion, BookFlip, StackDepth, Shutter, Wipe, Spotlight, Pixelate.
- **Modern UI:** Glassmorphism, SlidingGlassPanels, LiquidSwipe, WavyEdge, Gooey, SplashReveal, Neumorphism, BubbleInflate, CurtainReveal.
- **Social Media Style:** Story, Reels, Snap, SlideWithBounce, Flash, CrossFadeAudio, AlbumArtExpand, NowPlayingSlide, SwipeCard, PullToDismiss, StackedCards.
- **Accessibility:** NoAnimation, SimpleFade, MinimalMovement, OpacityOnly, TransformOnly, Adaptive, FastSnap.

### Platform Support
- ✅ Android, iOS, Web, Windows, macOS, Linux.