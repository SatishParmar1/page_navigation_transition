import 'package:flutter/material.dart';
import '../core/enums.dart';
import '../transitions/slide_transitions.dart';
import '../transitions/fade_transitions.dart';
import '../transitions/scale_transitions.dart';
import '../transitions/rotation_transitions.dart';
import '../transitions/material_transitions.dart';
import '../transitions/ios_transitions.dart';
import '../transitions/threed_transitions.dart';
import '../transitions/physics_transitions.dart';
import '../transitions/custom_transitions.dart';
import '../transitions/modern_transitions.dart';
import '../transitions/social_transitions.dart';
import '../transitions/accessibility_transitions.dart';

/// A utility class that provides static methods to create various page transitions
class PageTransitions {
  PageTransitions._();

  // ============ Slide Transitions ============

  /// Creates a slide transition from the specified direction
  static PageRouteBuilder<T> slide<T>(
    Widget page, {
    SlideDirection direction = SlideDirection.fromRight,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    RouteSettings? settings,
  }) {
    return SlidePageTransition<T>(
      page: page,
      direction: direction,
      duration: duration,
      curve: curve,
      settings: settings,
    );
  }

  /// Creates a slide with fade transition
  static PageRouteBuilder<T> slideFade<T>(
    Widget page, {
    SlideDirection direction = SlideDirection.fromRight,
    double slideDistance = 0.3,
    Duration duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) {
    return SlideFadePageTransition<T>(
      page: page,
      direction: direction,
      slideDistance: slideDistance,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a slide with scale transition
  static PageRouteBuilder<T> slideScale<T>(
    Widget page, {
    SlideDirection direction = SlideDirection.fromRight,
    double beginScale = 0.8,
    Duration duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) {
    return SlideScalePageTransition<T>(
      page: page,
      direction: direction,
      beginScale: beginScale,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates an elastic slide transition
  static PageRouteBuilder<T> elasticSlide<T>(
    Widget page, {
    SlideDirection direction = SlideDirection.fromRight,
    RouteSettings? settings,
  }) {
    return ElasticSlidePageTransition<T>(
      page: page,
      direction: direction,
      settings: settings,
    );
  }

  /// Creates a bouncy slide transition
  static PageRouteBuilder<T> bouncySlide<T>(
    Widget page, {
    SlideDirection direction = SlideDirection.fromRight,
    RouteSettings? settings,
  }) {
    return BouncySlidePageTransition<T>(
      page: page,
      direction: direction,
      settings: settings,
    );
  }

  /// Creates a push transition
  static PageRouteBuilder<T> push<T>(
    Widget page, {
    SlideDirection direction = SlideDirection.fromRight,
    Duration duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) {
    return PushPageTransition<T>(
      page: page,
      direction: direction,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a cover transition
  static PageRouteBuilder<T> cover<T>(
    Widget page, {
    SlideDirection direction = SlideDirection.fromRight,
    Duration duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) {
    return CoverPageTransition<T>(
      page: page,
      direction: direction,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a parallax transition
  static PageRouteBuilder<T> parallax<T>(
    Widget page, {
    SlideDirection direction = SlideDirection.fromRight,
    double parallaxFactor = 0.3,
    Duration duration = const Duration(milliseconds: 400),
    RouteSettings? settings,
  }) {
    return ParallaxPageTransition<T>(
      page: page,
      direction: direction,
      parallaxFactor: parallaxFactor,
      duration: duration,
      settings: settings,
    );
  }

  // ============ Fade Transitions ============

  /// Creates a simple fade transition
  static PageRouteBuilder<T> fade<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
    RouteSettings? settings,
  }) {
    return FadePageTransition<T>(
      page: page,
      duration: duration,
      curve: curve,
      settings: settings,
    );
  }

  /// Creates a fade with scale transition
  static PageRouteBuilder<T> fadeScale<T>(
    Widget page, {
    double beginScale = 0.8,
    Alignment scaleAlignment = Alignment.center,
    Duration duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) {
    return FadeScalePageTransition<T>(
      page: page,
      beginScale: beginScale,
      scaleAlignment: scaleAlignment,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a fade with rotation transition
  static PageRouteBuilder<T> fadeRotation<T>(
    Widget page, {
    double beginTurns = 0.5,
    Duration duration = const Duration(milliseconds: 400),
    RouteSettings? settings,
  }) {
    return FadeRotationPageTransition<T>(
      page: page,
      beginTurns: beginTurns,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a fade with slide transition
  static PageRouteBuilder<T> fadeSlide<T>(
    Widget page, {
    SlideDirection direction = SlideDirection.fromBottom,
    double slideDistance = 0.3,
    Duration duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) {
    return FadeSlidePageTransition<T>(
      page: page,
      direction: direction,
      slideDistance: slideDistance,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a fade through transition
  static PageRouteBuilder<T> fadeThrough<T>(
    Widget page, {
    bool includeScale = true,
    Duration duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) {
    return FadeThroughPageTransition<T>(
      page: page,
      includeScale: includeScale,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a fade zoom in transition
  static PageRouteBuilder<T> fadeZoomIn<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) {
    return FadeZoomInPageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a fade zoom out transition
  static PageRouteBuilder<T> fadeZoomOut<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) {
    return FadeZoomOutPageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  // ============ Scale Transitions ============

  /// Creates a scale transition
  static PageRouteBuilder<T> scale<T>(
    Widget page, {
    ScaleOrigin origin = ScaleOrigin.center,
    double beginScale = 0.0,
    Duration duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) {
    return ScalePageTransition<T>(
      page: page,
      origin: origin,
      beginScale: beginScale,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a scale with fade transition
  static PageRouteBuilder<T> scaleFade<T>(
    Widget page, {
    ScaleOrigin origin = ScaleOrigin.center,
    double beginScale = 0.8,
    Duration duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) {
    return ScaleFadePageTransition<T>(
      page: page,
      origin: origin,
      beginScale: beginScale,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a zoom in transition
  static PageRouteBuilder<T> zoomIn<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) {
    return ZoomInPageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a zoom out transition
  static PageRouteBuilder<T> zoomOut<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) {
    return ZoomOutPageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a zoom in with fade transition
  static PageRouteBuilder<T> zoomInFade<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) {
    return ZoomInFadePageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a zoom out with fade transition
  static PageRouteBuilder<T> zoomOutFade<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) {
    return ZoomOutFadePageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a pop scale transition
  static PageRouteBuilder<T> popScale<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 400),
    RouteSettings? settings,
  }) {
    return PopScalePageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a shrink and grow transition
  static PageRouteBuilder<T> shrinkGrow<T>(
    Widget page, {
    double minScale = 0.5,
    Duration duration = const Duration(milliseconds: 400),
    RouteSettings? settings,
  }) {
    return ShrinkGrowPageTransition<T>(
      page: page,
      minScale: minScale,
      duration: duration,
      settings: settings,
    );
  }

  // ============ Rotation Transitions ============

  /// Creates a rotation transition
  static PageRouteBuilder<T> rotation<T>(
    Widget page, {
    double beginTurns = 1.0,
    Alignment alignment = Alignment.center,
    Duration duration = const Duration(milliseconds: 400),
    RouteSettings? settings,
  }) {
    return RotationPageTransition<T>(
      page: page,
      beginTurns: beginTurns,
      alignment: alignment,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a flip horizontal transition
  static PageRouteBuilder<T> flipHorizontal<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 500),
    RouteSettings? settings,
  }) {
    return FlipHorizontalPageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a flip vertical transition
  static PageRouteBuilder<T> flipVertical<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 500),
    RouteSettings? settings,
  }) {
    return FlipVerticalPageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a spin transition
  static PageRouteBuilder<T> spin<T>(
    Widget page, {
    int rotations = 1,
    bool elastic = false,
    Duration duration = const Duration(milliseconds: 500),
    RouteSettings? settings,
  }) {
    return SpinPageTransition<T>(
      page: page,
      rotations: rotations,
      elastic: elastic,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a rotation with scale transition
  static PageRouteBuilder<T> rotationScale<T>(
    Widget page, {
    double beginTurns = 1.0,
    double beginScale = 0.0,
    Duration duration = const Duration(milliseconds: 400),
    RouteSettings? settings,
  }) {
    return RotationScalePageTransition<T>(
      page: page,
      beginTurns: beginTurns,
      beginScale: beginScale,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a door rotation transition
  static PageRouteBuilder<T> doorRotation<T>(
    Widget page, {
    bool openFromLeft = true,
    Duration duration = const Duration(milliseconds: 500),
    RouteSettings? settings,
  }) {
    return DoorRotationPageTransition<T>(
      page: page,
      openFromLeft: openFromLeft,
      duration: duration,
      settings: settings,
    );
  }

  // ============ 3D Transitions ============

  /// Creates a 3D cube horizontal transition
  static PageRouteBuilder<T> cubeHorizontal<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 500),
    RouteSettings? settings,
  }) {
    return CubeHorizontalPageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a 3D cube vertical transition
  static PageRouteBuilder<T> cubeVertical<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 500),
    RouteSettings? settings,
  }) {
    return CubeVerticalPageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a card flip transition
  static PageRouteBuilder<T> cardFlip<T>(
    Widget page, {
    bool horizontal = true,
    Duration duration = const Duration(milliseconds: 600),
    RouteSettings? settings,
  }) {
    return CardFlipPageTransition<T>(
      page: page,
      horizontal: horizontal,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a carousel transition
  static PageRouteBuilder<T> carousel<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 500),
    RouteSettings? settings,
  }) {
    return CarouselPageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a cover flow transition
  static PageRouteBuilder<T> coverFlow<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 500),
    RouteSettings? settings,
  }) {
    return CoverFlowPageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a perspective zoom transition
  static PageRouteBuilder<T> perspectiveZoom<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 400),
    RouteSettings? settings,
  }) {
    return PerspectiveZoomPageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  // ============ Material Transitions ============

  /// Creates a shared axis transition
  static PageRouteBuilder<T> sharedAxis<T>(
    Widget page, {
    SharedAxisDirection direction = SharedAxisDirection.horizontal,
    Duration duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) {
    return SharedAxisPageTransition<T>(
      page: page,
      direction: direction,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a container transform transition
  static PageRouteBuilder<T> containerTransform<T>(
    Widget page, {
    Color containerColor = Colors.white,
    double beginRadius = 16.0,
    Duration duration = const Duration(milliseconds: 400),
    RouteSettings? settings,
  }) {
    return ContainerTransformPageTransition<T>(
      page: page,
      containerColor: containerColor,
      beginRadius: beginRadius,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates an elevation scale transition
  static PageRouteBuilder<T> elevationScale<T>(
    Widget page, {
    double beginElevation = 0.0,
    double endElevation = 8.0,
    Duration duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) {
    return ElevationScalePageTransition<T>(
      page: page,
      beginElevation: beginElevation,
      endElevation: endElevation,
      duration: duration,
      settings: settings,
    );
  }

  // ============ iOS Transitions ============

  /// Creates a Cupertino-style slide transition
  static PageRouteBuilder<T> cupertino<T>(
    Widget page, {
    double parallaxFactor = 0.3,
    Duration duration = const Duration(milliseconds: 400),
    RouteSettings? settings,
  }) {
    return CupertinoSlidePageTransition<T>(
      page: page,
      parallaxFactor: parallaxFactor,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a modal slide transition
  static PageRouteBuilder<T> modal<T>(
    Widget page, {
    double borderRadius = 12.0,
    Duration duration = const Duration(milliseconds: 400),
    RouteSettings? settings,
  }) {
    return ModalSlidePageTransition<T>(
      page: page,
      borderRadius: borderRadius,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a sheet transition
  static PageRouteBuilder<T> sheet<T>(
    Widget page, {
    double heightFactor = 0.9,
    bool isDismissible = true,
    Duration duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) {
    return SheetPageTransition<T>(
      page: page,
      heightFactor: heightFactor,
      isDismissible: isDismissible,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a page curl transition
  static PageRouteBuilder<T> pageCurl<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 600),
    RouteSettings? settings,
  }) {
    return PageCurlPageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates an App Store card transition
  static PageRouteBuilder<T> appStoreCard<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 500),
    RouteSettings? settings,
  }) {
    return AppStoreCardPageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  // ============ Physics Transitions ============

  /// Creates a spring transition
  static PageRouteBuilder<T> spring<T>(
    Widget page, {
    SlideDirection direction = SlideDirection.fromRight,
    Duration duration = const Duration(milliseconds: 600),
    RouteSettings? settings,
  }) {
    return SpringPageTransition<T>(
      page: page,
      direction: direction,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a gravity drop transition
  static PageRouteBuilder<T> gravityDrop<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 500),
    RouteSettings? settings,
  }) {
    return GravityDropPageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates an elastic bounce transition
  static PageRouteBuilder<T> elasticBounce<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 800),
    RouteSettings? settings,
  }) {
    return ElasticBouncePageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates an over-scroll bounce transition
  static PageRouteBuilder<T> overScrollBounce<T>(
    Widget page, {
    SlideDirection direction = SlideDirection.fromRight,
    Duration duration = const Duration(milliseconds: 600),
    RouteSettings? settings,
  }) {
    return OverScrollBouncePageTransition<T>(
      page: page,
      direction: direction,
      duration: duration,
      settings: settings,
    );
  }

  // ============ Custom Transitions ============

  /// Creates a circular reveal transition
  static PageRouteBuilder<T> circularReveal<T>(
    Widget page, {
    Alignment center = Alignment.center,
    Duration duration = const Duration(milliseconds: 400),
    RouteSettings? settings,
  }) {
    return CircularRevealPageTransition<T>(
      page: page,
      center: center,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a blur transition
  static PageRouteBuilder<T> blur<T>(
    Widget page, {
    double maxBlur = 10.0,
    Duration duration = const Duration(milliseconds: 400),
    RouteSettings? settings,
  }) {
    return BlurPageTransition<T>(
      page: page,
      maxBlur: maxBlur,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a glitch transition
  static PageRouteBuilder<T> glitch<T>(
    Widget page, {
    double intensity = 1.0,
    Duration duration = const Duration(milliseconds: 500),
    RouteSettings? settings,
  }) {
    return GlitchPageTransition<T>(
      page: page,
      intensity: intensity,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a wipe transition
  static PageRouteBuilder<T> wipe<T>(
    Widget page, {
    WipeShape shape = WipeShape.horizontal,
    Duration duration = const Duration(milliseconds: 400),
    RouteSettings? settings,
  }) {
    return WipePageTransition<T>(
      page: page,
      shape: shape,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a spotlight transition
  static PageRouteBuilder<T> spotlight<T>(
    Widget page, {
    Alignment spotlightPosition = Alignment.center,
    Duration duration = const Duration(milliseconds: 500),
    RouteSettings? settings,
  }) {
    return SpotlightPageTransition<T>(
      page: page,
      spotlightPosition: spotlightPosition,
      duration: duration,
      settings: settings,
    );
  }

  // ============ Modern Transitions ============

  /// Creates a glassmorphism transition
  static PageRouteBuilder<T> glass<T>(
    Widget page, {
    double maxBlur = 15.0,
    Duration duration = const Duration(milliseconds: 400),
    RouteSettings? settings,
  }) {
    return GlassmorphismPageTransition<T>(
      page: page,
      maxBlur: maxBlur,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a liquid swipe transition
  static PageRouteBuilder<T> liquidSwipe<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 600),
    RouteSettings? settings,
  }) {
    return LiquidSwipePageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a wavy edge transition
  static PageRouteBuilder<T> wavyEdge<T>(
    Widget page, {
    double waveFrequency = 3.0,
    double waveAmplitude = 40.0,
    Duration duration = const Duration(milliseconds: 500),
    RouteSettings? settings,
  }) {
    return WavyEdgePageTransition<T>(
      page: page,
      waveFrequency: waveFrequency,
      waveAmplitude: waveAmplitude,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a gooey transition
  static PageRouteBuilder<T> gooey<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 600),
    RouteSettings? settings,
  }) {
    return GooeyPageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a neumorphism transition
  static PageRouteBuilder<T> neumorphism<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 400),
    RouteSettings? settings,
  }) {
    return NeumorphismPageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a bubble inflate transition
  static PageRouteBuilder<T> bubbleInflate<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 500),
    RouteSettings? settings,
  }) {
    return BubbleInflatePageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a curtain reveal transition
  static PageRouteBuilder<T> curtainReveal<T>(
    Widget page, {
    bool horizontal = true,
    Duration duration = const Duration(milliseconds: 500),
    RouteSettings? settings,
  }) {
    return CurtainRevealPageTransition<T>(
      page: page,
      horizontal: horizontal,
      duration: duration,
      settings: settings,
    );
  }

  // ============ Social Transitions ============

  /// Creates a story transition (Instagram-style)
  static PageRouteBuilder<T> story<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) {
    return StoryPageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a reels transition
  static PageRouteBuilder<T> reels<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 200),
    RouteSettings? settings,
  }) {
    return ReelsPageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a snap transition (TikTok-style)
  static PageRouteBuilder<T> snap<T>(
    Widget page, {
    SlideDirection direction = SlideDirection.fromBottom,
    Duration duration = const Duration(milliseconds: 150),
    RouteSettings? settings,
  }) {
    return SnapPageTransition<T>(
      page: page,
      direction: direction,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a flash transition
  static PageRouteBuilder<T> flash<T>(
    Widget page, {
    Color flashColor = Colors.white,
    Duration duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) {
    return FlashPageTransition<T>(
      page: page,
      flashColor: flashColor,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a swipe card transition
  static PageRouteBuilder<T> swipeCard<T>(
    Widget page, {
    bool swipeRight = true,
    Duration duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) {
    return SwipeCardPageTransition<T>(
      page: page,
      swipeRight: swipeRight,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates a stacked cards transition
  static PageRouteBuilder<T> stackedCards<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 400),
    RouteSettings? settings,
  }) {
    return StackedCardsPageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  // ============ Accessibility Transitions ============

  /// Creates a no animation transition
  static PageRouteBuilder<T> none<T>(
    Widget page, {
    RouteSettings? settings,
  }) {
    return NoAnimationPageTransition<T>(
      page: page,
      settings: settings,
    );
  }

  /// Creates a simple fade transition
  static PageRouteBuilder<T> simpleFade<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 150),
    RouteSettings? settings,
  }) {
    return SimpleFadePageTransition<T>(
      page: page,
      duration: duration,
      settings: settings,
    );
  }

  /// Creates an adaptive transition
  static PageRouteBuilder<T> adaptive<T>(
    Widget page, {
    Duration normalDuration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) {
    return AdaptivePageTransition<T>(
      page: page,
      normalDuration: normalDuration,
      settings: settings,
    );
  }

  /// Creates a fast snap transition
  static PageRouteBuilder<T> fastSnap<T>(
    Widget page, {
    RouteSettings? settings,
  }) {
    return FastSnapPageTransition<T>(
      page: page,
      settings: settings,
    );
  }
}
