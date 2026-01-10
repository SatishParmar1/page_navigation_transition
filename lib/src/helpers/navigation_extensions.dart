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

/// Extension on Navigator for easy transition navigation
extension NavigatorTransitionExtensions on NavigatorState {
  // ============ Slide Transitions ============

  /// Navigate with a slide transition
  Future<T?> pushSlide<T>(
    Widget page, {
    SlideDirection direction = SlideDirection.fromRight,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return push(SlidePageTransition<T>(
      page: page,
      direction: direction,
      duration: duration,
      curve: curve,
    ));
  }

  /// Navigate with a slide and fade transition
  Future<T?> pushSlideFade<T>(
    Widget page, {
    SlideDirection direction = SlideDirection.fromRight,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return push(SlideFadePageTransition<T>(
      page: page,
      direction: direction,
      duration: duration,
      curve: curve,
    ));
  }

  /// Navigate with an elastic slide transition
  Future<T?> pushElasticSlide<T>(
    Widget page, {
    SlideDirection direction = SlideDirection.fromRight,
  }) {
    return push(ElasticSlidePageTransition<T>(
      page: page,
      direction: direction,
    ));
  }

  /// Navigate with a bouncy slide transition
  Future<T?> pushBouncySlide<T>(
    Widget page, {
    SlideDirection direction = SlideDirection.fromRight,
  }) {
    return push(BouncySlidePageTransition<T>(
      page: page,
      direction: direction,
    ));
  }

  // ============ Fade Transitions ============

  /// Navigate with a fade transition
  Future<T?> pushFade<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return push(FadePageTransition<T>(
      page: page,
      duration: duration,
      curve: curve,
    ));
  }

  /// Navigate with a fade and scale transition
  Future<T?> pushFadeScale<T>(
    Widget page, {
    double beginScale = 0.8,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return push(FadeScalePageTransition<T>(
      page: page,
      beginScale: beginScale,
      duration: duration,
    ));
  }

  /// Navigate with a fade through transition
  Future<T?> pushFadeThrough<T>(Widget page) {
    return push(FadeThroughPageTransition<T>(page: page));
  }

  // ============ Scale Transitions ============

  /// Navigate with a scale transition
  Future<T?> pushScale<T>(
    Widget page, {
    ScaleOrigin origin = ScaleOrigin.center,
    double beginScale = 0.0,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return push(ScalePageTransition<T>(
      page: page,
      origin: origin,
      beginScale: beginScale,
      duration: duration,
    ));
  }

  /// Navigate with a zoom in transition
  Future<T?> pushZoomIn<T>(Widget page) {
    return push(ZoomInPageTransition<T>(page: page));
  }

  /// Navigate with a zoom in and fade transition
  Future<T?> pushZoomInFade<T>(Widget page) {
    return push(ZoomInFadePageTransition<T>(page: page));
  }

  /// Navigate with a pop scale transition
  Future<T?> pushPopScale<T>(Widget page) {
    return push(PopScalePageTransition<T>(page: page));
  }

  // ============ Rotation Transitions ============

  /// Navigate with a rotation transition
  Future<T?> pushRotation<T>(
    Widget page, {
    double beginTurns = 1.0,
    Duration duration = const Duration(milliseconds: 400),
  }) {
    return push(RotationPageTransition<T>(
      page: page,
      beginTurns: beginTurns,
      duration: duration,
    ));
  }

  /// Navigate with a flip horizontal transition
  Future<T?> pushFlipHorizontal<T>(Widget page) {
    return push(FlipHorizontalPageTransition<T>(page: page));
  }

  /// Navigate with a flip vertical transition
  Future<T?> pushFlipVertical<T>(Widget page) {
    return push(FlipVerticalPageTransition<T>(page: page));
  }

  /// Navigate with a spin transition
  Future<T?> pushSpin<T>(
    Widget page, {
    int rotations = 1,
    bool elastic = false,
  }) {
    return push(SpinPageTransition<T>(
      page: page,
      rotations: rotations,
      elastic: elastic,
    ));
  }

  // ============ 3D Transitions ============

  /// Navigate with a 3D cube horizontal transition
  Future<T?> pushCubeHorizontal<T>(Widget page) {
    return push(CubeHorizontalPageTransition<T>(page: page));
  }

  /// Navigate with a 3D cube vertical transition
  Future<T?> pushCubeVertical<T>(Widget page) {
    return push(CubeVerticalPageTransition<T>(page: page));
  }

  /// Navigate with a card flip transition
  Future<T?> pushCardFlip<T>(
    Widget page, {
    bool horizontal = true,
  }) {
    return push(CardFlipPageTransition<T>(
      page: page,
      horizontal: horizontal,
    ));
  }

  /// Navigate with a carousel transition
  Future<T?> pushCarousel<T>(Widget page) {
    return push(CarouselPageTransition<T>(page: page));
  }

  /// Navigate with a cover flow transition
  Future<T?> pushCoverFlow<T>(Widget page) {
    return push(CoverFlowPageTransition<T>(page: page));
  }

  // ============ Material Transitions ============

  /// Navigate with a shared axis transition
  Future<T?> pushSharedAxis<T>(
    Widget page, {
    SharedAxisDirection direction = SharedAxisDirection.horizontal,
  }) {
    return push(SharedAxisPageTransition<T>(
      page: page,
      direction: direction,
    ));
  }

  /// Navigate with a container transform transition
  Future<T?> pushContainerTransform<T>(Widget page) {
    return push(ContainerTransformPageTransition<T>(page: page));
  }

  // ============ iOS Transitions ============

  /// Navigate with a Cupertino-style slide transition
  Future<T?> pushCupertino<T>(Widget page) {
    return push(CupertinoSlidePageTransition<T>(page: page));
  }

  /// Navigate with a modal slide transition
  Future<T?> pushModal<T>(Widget page) {
    return push(ModalSlidePageTransition<T>(page: page));
  }

  /// Navigate with a sheet transition
  Future<T?> pushSheet<T>(
    Widget page, {
    double heightFactor = 0.9,
  }) {
    return push(SheetPageTransition<T>(
      page: page,
      heightFactor: heightFactor,
    ));
  }

  // ============ Physics Transitions ============

  /// Navigate with a spring transition
  Future<T?> pushSpring<T>(
    Widget page, {
    SlideDirection direction = SlideDirection.fromRight,
  }) {
    return push(SpringPageTransition<T>(
      page: page,
      direction: direction,
    ));
  }

  /// Navigate with a gravity drop transition
  Future<T?> pushGravityDrop<T>(Widget page) {
    return push(GravityDropPageTransition<T>(page: page));
  }

  /// Navigate with an elastic bounce transition
  Future<T?> pushElasticBounce<T>(Widget page) {
    return push(ElasticBouncePageTransition<T>(page: page));
  }

  // ============ Custom Transitions ============

  /// Navigate with a circular reveal transition
  Future<T?> pushCircularReveal<T>(
    Widget page, {
    Alignment center = Alignment.center,
  }) {
    return push(CircularRevealPageTransition<T>(
      page: page,
      center: center,
    ));
  }

  /// Navigate with a blur transition
  Future<T?> pushBlur<T>(
    Widget page, {
    double maxBlur = 10.0,
  }) {
    return push(BlurPageTransition<T>(
      page: page,
      maxBlur: maxBlur,
    ));
  }

  /// Navigate with a glitch transition
  Future<T?> pushGlitch<T>(Widget page) {
    return push(GlitchPageTransition<T>(page: page));
  }

  // ============ Modern Transitions ============

  /// Navigate with a glassmorphism transition
  Future<T?> pushGlass<T>(Widget page) {
    return push(GlassmorphismPageTransition<T>(page: page));
  }

  /// Navigate with a liquid swipe transition
  Future<T?> pushLiquidSwipe<T>(Widget page) {
    return push(LiquidSwipePageTransition<T>(page: page));
  }

  /// Navigate with a gooey transition
  Future<T?> pushGooey<T>(Widget page) {
    return push(GooeyPageTransition<T>(page: page));
  }

  // ============ Social Transitions ============

  /// Navigate with a story transition
  Future<T?> pushStory<T>(Widget page) {
    return push(StoryPageTransition<T>(page: page));
  }

  /// Navigate with a reels transition
  Future<T?> pushReels<T>(Widget page) {
    return push(ReelsPageTransition<T>(page: page));
  }

  /// Navigate with a snap transition
  Future<T?> pushSnap<T>(Widget page) {
    return push(SnapPageTransition<T>(page: page));
  }

  // ============ Accessibility Transitions ============

  /// Navigate with no animation
  Future<T?> pushNoAnimation<T>(Widget page) {
    return push(NoAnimationPageTransition<T>(page: page));
  }

  /// Navigate with an adaptive transition that respects system settings
  Future<T?> pushAdaptive<T>(Widget page) {
    return push(AdaptivePageTransition<T>(page: page));
  }
}

/// Extension on BuildContext for easy navigation
extension BuildContextTransitionExtensions on BuildContext {
  /// Get the navigator
  NavigatorState get _navigator => Navigator.of(this);

  // ============ Slide Transitions ============

  /// Navigate with a slide transition
  Future<T?> pushSlide<T>(
    Widget page, {
    SlideDirection direction = SlideDirection.fromRight,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.easeInOut,
  }) {
    return _navigator.pushSlide<T>(
      page,
      direction: direction,
      duration: duration,
      curve: curve,
    );
  }

  /// Navigate with a slide and fade transition
  Future<T?> pushSlideFade<T>(
    Widget page, {
    SlideDirection direction = SlideDirection.fromRight,
  }) {
    return _navigator.pushSlideFade<T>(page, direction: direction);
  }

  // ============ Fade Transitions ============

  /// Navigate with a fade transition
  Future<T?> pushFade<T>(Widget page) {
    return _navigator.pushFade<T>(page);
  }

  /// Navigate with a fade and scale transition
  Future<T?> pushFadeScale<T>(Widget page, {double beginScale = 0.8}) {
    return _navigator.pushFadeScale<T>(page, beginScale: beginScale);
  }

  // ============ Scale Transitions ============

  /// Navigate with a scale transition
  Future<T?> pushScale<T>(Widget page, {ScaleOrigin origin = ScaleOrigin.center}) {
    return _navigator.pushScale<T>(page, origin: origin);
  }

  /// Navigate with a zoom in transition
  Future<T?> pushZoomIn<T>(Widget page) {
    return _navigator.pushZoomIn<T>(page);
  }

  // ============ 3D Transitions ============

  /// Navigate with a cube horizontal transition
  Future<T?> pushCubeHorizontal<T>(Widget page) {
    return _navigator.pushCubeHorizontal<T>(page);
  }

  /// Navigate with a cube vertical transition
  Future<T?> pushCubeVertical<T>(Widget page) {
    return _navigator.pushCubeVertical<T>(page);
  }

  // ============ Material Transitions ============

  /// Navigate with a shared axis transition
  Future<T?> pushSharedAxis<T>(
    Widget page, {
    SharedAxisDirection direction = SharedAxisDirection.horizontal,
  }) {
    return _navigator.pushSharedAxis<T>(page, direction: direction);
  }

  // ============ iOS Transitions ============

  /// Navigate with a Cupertino slide transition
  Future<T?> pushCupertino<T>(Widget page) {
    return _navigator.pushCupertino<T>(page);
  }

  /// Navigate with a modal transition
  Future<T?> pushModal<T>(Widget page) {
    return _navigator.pushModal<T>(page);
  }

  /// Navigate with a sheet transition
  Future<T?> pushSheet<T>(Widget page, {double heightFactor = 0.9}) {
    return _navigator.pushSheet<T>(page, heightFactor: heightFactor);
  }

  // ============ Physics Transitions ============

  /// Navigate with a spring transition
  Future<T?> pushSpring<T>(Widget page) {
    return _navigator.pushSpring<T>(page);
  }

  /// Navigate with an elastic bounce transition
  Future<T?> pushElasticBounce<T>(Widget page) {
    return _navigator.pushElasticBounce<T>(page);
  }

  // ============ Custom Transitions ============

  /// Navigate with a circular reveal transition
  Future<T?> pushCircularReveal<T>(Widget page, {Alignment center = Alignment.center}) {
    return _navigator.pushCircularReveal<T>(page, center: center);
  }

  // ============ Modern Transitions ============

  /// Navigate with a glass transition
  Future<T?> pushGlass<T>(Widget page) {
    return _navigator.pushGlass<T>(page);
  }

  /// Navigate with a liquid swipe transition
  Future<T?> pushLiquidSwipe<T>(Widget page) {
    return _navigator.pushLiquidSwipe<T>(page);
  }

  // ============ Accessibility Transitions ============

  /// Navigate with no animation
  Future<T?> pushNoAnimation<T>(Widget page) {
    return _navigator.pushNoAnimation<T>(page);
  }

  /// Navigate with an adaptive transition
  Future<T?> pushAdaptive<T>(Widget page) {
    return _navigator.pushAdaptive<T>(page);
  }
}
