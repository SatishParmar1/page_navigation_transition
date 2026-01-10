import 'package:flutter/material.dart';
import '../core/enums.dart';

/// Instagram-style story transition (vertical slide)
class StoryPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a story page transition
  StoryPageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
              reverseCurve: Curves.easeIn,
            );

            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            );
          },
        );
}

/// Reels-style transition (quick vertical slide)
class ReelsPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a reels page transition
  ReelsPageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 200),
    Duration reverseDuration = const Duration(milliseconds: 200),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            );

            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            );
          },
        );
}

/// TikTok-style quick snap transition
class SnapPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The direction from which the page enters
  final SlideDirection direction;

  /// Creates a snap page transition
  SnapPageTransition({
    required this.page,
    this.direction = SlideDirection.fromBottom,
    Duration duration = const Duration(milliseconds: 150),
    Duration reverseDuration = const Duration(milliseconds: 150),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutQuart,
              reverseCurve: Curves.easeInQuart,
            );

            final offset = _getOffset(direction);

            return SlideTransition(
              position: Tween<Offset>(
                begin: offset,
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            );
          },
        );

  static Offset _getOffset(SlideDirection direction) {
    switch (direction) {
      case SlideDirection.fromRight:
        return const Offset(1.0, 0.0);
      case SlideDirection.fromLeft:
        return const Offset(-1.0, 0.0);
      case SlideDirection.fromTop:
        return const Offset(0.0, -1.0);
      case SlideDirection.fromBottom:
        return const Offset(0.0, 1.0);
      case SlideDirection.fromTopRight:
        return const Offset(1.0, -1.0);
      case SlideDirection.fromTopLeft:
        return const Offset(-1.0, -1.0);
      case SlideDirection.fromBottomRight:
        return const Offset(1.0, 1.0);
      case SlideDirection.fromBottomLeft:
        return const Offset(-1.0, 1.0);
    }
  }
}

/// Slide with bounce transition (TikTok-style)
class SlideWithBouncePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The direction from which the page enters
  final SlideDirection direction;

  /// Creates a slide with bounce page transition
  SlideWithBouncePageTransition({
    required this.page,
    this.direction = SlideDirection.fromRight,
    Duration duration = const Duration(milliseconds: 400),
    Duration reverseDuration = const Duration(milliseconds: 300),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.bounceOut,
              reverseCurve: Curves.easeIn,
            );

            final offset = _getOffset(direction);

            return SlideTransition(
              position: Tween<Offset>(
                begin: offset,
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            );
          },
        );

  static Offset _getOffset(SlideDirection direction) {
    switch (direction) {
      case SlideDirection.fromRight:
        return const Offset(1.0, 0.0);
      case SlideDirection.fromLeft:
        return const Offset(-1.0, 0.0);
      case SlideDirection.fromTop:
        return const Offset(0.0, -1.0);
      case SlideDirection.fromBottom:
        return const Offset(0.0, 1.0);
      case SlideDirection.fromTopRight:
        return const Offset(1.0, -1.0);
      case SlideDirection.fromTopLeft:
        return const Offset(-1.0, -1.0);
      case SlideDirection.fromBottomRight:
        return const Offset(1.0, 1.0);
      case SlideDirection.fromBottomLeft:
        return const Offset(-1.0, 1.0);
    }
  }
}

/// Flash transition
class FlashPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The flash color
  final Color flashColor;

  /// Creates a flash page transition
  FlashPageTransition({
    required this.page,
    this.flashColor = Colors.white,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return AnimatedBuilder(
              animation: animation,
              builder: (context, _) {
                final t = animation.value;
                // Flash peaks at 50% and fades
                final flashOpacity = t < 0.5 ? t * 2 : (1 - t) * 2;

                return Stack(
                  children: [
                    Opacity(
                      opacity: t,
                      child: child,
                    ),
                    if (flashOpacity > 0)
                      Positioned.fill(
                        child: Container(
                          color: flashColor.withValues(alpha: flashOpacity * 0.5),
                        ),
                      ),
                  ],
                );
              },
              child: child,
            );
          },
        );
}

/// Spotify-style cross-fade transition
class CrossFadeAudioPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a cross-fade audio page transition
  CrossFadeAudioPageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 400),
    Duration reverseDuration = const Duration(milliseconds: 400),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            );

            return FadeTransition(
              opacity: curvedAnimation,
              child: child,
            );
          },
        );
}

/// Spotify-style album art expansion transition
class AlbumArtExpandPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates an album art expand page transition
  AlbumArtExpandPageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 400),
    Duration reverseDuration = const Duration(milliseconds: 300),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
              reverseCurve: Curves.easeIn,
            );

            return AnimatedBuilder(
              animation: curvedAnimation,
              builder: (context, _) {
                final scale = 0.8 + (curvedAnimation.value * 0.2);
                final borderRadius = (1 - curvedAnimation.value) * 16;

                return Transform.scale(
                  scale: scale,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: FadeTransition(
                      opacity: curvedAnimation,
                      child: child,
                    ),
                  ),
                );
              },
              child: child,
            );
          },
        );
}

/// Spotify-style now playing slide up transition
class NowPlayingSlidePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a now playing slide page transition
  NowPlayingSlidePageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 350),
    Duration reverseDuration = const Duration(milliseconds: 300),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final slideAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
              reverseCurve: Curves.easeIn,
            );

            final fadeAnimation = CurvedAnimation(
              parent: animation,
              curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
            );

            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(slideAnimation),
              child: FadeTransition(
                opacity: Tween<double>(begin: 0.5, end: 1.0).animate(fadeAnimation),
                child: child,
              ),
            );
          },
        );
}

/// Tinder-style swipe card transition
class SwipeCardPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Whether to swipe right (true) or left (false)
  final bool swipeRight;

  /// Creates a swipe card page transition
  SwipeCardPageTransition({
    required this.page,
    this.swipeRight = true,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
              reverseCurve: Curves.easeIn,
            );

            return AnimatedBuilder(
              animation: curvedAnimation,
              builder: (context, _) {
                final slideOffset = (1 - curvedAnimation.value) * (swipeRight ? 1.5 : -1.5);
                final rotation = (1 - curvedAnimation.value) * (swipeRight ? 0.2 : -0.2);

                return Transform(
                  alignment: Alignment.bottomCenter,
                  transform: Matrix4.identity()
                    ..translate(slideOffset * MediaQuery.of(context).size.width)
                    ..rotateZ(rotation),
                  child: Opacity(
                    opacity: curvedAnimation.value.clamp(0.0, 1.0),
                    child: child,
                  ),
                );
              },
              child: child,
            );
          },
        );
}

/// Pull to dismiss transition
class PullToDismissPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a pull to dismiss page transition
  PullToDismissPageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          opaque: false,
          barrierColor: Colors.black54,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
              reverseCurve: Curves.easeIn,
            );

            return AnimatedBuilder(
              animation: curvedAnimation,
              builder: (context, _) {
                final translateY = (1 - curvedAnimation.value) * 100;
                final scale = 0.9 + (curvedAnimation.value * 0.1);

                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..translate(0.0, translateY)
                    ..scale(scale),
                  child: Opacity(
                    opacity: curvedAnimation.value,
                    child: child,
                  ),
                );
              },
              child: child,
            );
          },
        );
}

/// iOS App Switcher style stacked cards transition
class StackedCardsPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a stacked cards page transition
  StackedCardsPageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 400),
    Duration reverseDuration = const Duration(milliseconds: 400),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
              reverseCurve: Curves.easeIn,
            );

            return AnimatedBuilder(
              animation: curvedAnimation,
              builder: (context, _) {
                final scale = 0.85 + (curvedAnimation.value * 0.15);
                final translateY = (1 - curvedAnimation.value) * 50;
                final borderRadius = (1 - curvedAnimation.value) * 20;

                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..translate(0.0, translateY)
                    ..scale(scale),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: FadeTransition(
                      opacity: curvedAnimation,
                      child: child,
                    ),
                  ),
                );
              },
              child: child,
            );
          },
        );
}
