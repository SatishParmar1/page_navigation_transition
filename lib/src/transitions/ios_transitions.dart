import 'package:flutter/material.dart';
import 'dart:math' as math;

/// iOS-style Cupertino slide from right transition
class CupertinoSlidePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Parallax factor for the background page
  final double parallaxFactor;

  /// Creates a Cupertino slide page transition
  CupertinoSlidePageTransition({
    required this.page,
    this.parallaxFactor = 0.3,
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

            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1 * curvedAnimation.value),
                      blurRadius: 10,
                      offset: const Offset(-5, 0),
                    ),
                  ],
                ),
                child: child,
              ),
            );
          },
        );
}

/// iOS-style modal slide from bottom transition
class ModalSlidePageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The border radius of the modal
  final double borderRadius;

  /// Creates a modal slide page transition
  ModalSlidePageTransition({
    required this.page,
    this.borderRadius = 12.0,
    Duration duration = const Duration(milliseconds: 400),
    Duration reverseDuration = const Duration(milliseconds: 400),
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

            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  topRight: Radius.circular(borderRadius),
                ),
                child: child,
              ),
            );
          },
        );
}

/// iOS-style page curl effect transition
class PageCurlPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a page curl page transition
  PageCurlPageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 600),
    Duration reverseDuration = const Duration(milliseconds: 600),
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

            return AnimatedBuilder(
              animation: curvedAnimation,
              builder: (context, _) {
                final angle = (1.0 - curvedAnimation.value) * -math.pi / 4;

                return Transform(
                  alignment: Alignment.centerLeft,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.002)
                    ..rotateY(angle),
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

/// iOS-style sheet transition (swipe up modal)
class SheetPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// The height percentage of the screen (0.0 to 1.0)
  final double heightFactor;

  /// Whether the sheet is dismissible
  final bool isDismissible;

  /// Creates a sheet page transition
  SheetPageTransition({
    required this.page,
    this.heightFactor = 0.9,
    this.isDismissible = true,
    Duration duration = const Duration(milliseconds: 300),
    Duration reverseDuration = const Duration(milliseconds: 300),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          opaque: false,
          barrierDismissible: isDismissible,
          barrierColor: Colors.black54,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
              reverseCurve: Curves.easeIn,
            );

            return Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 1.0),
                  end: Offset.zero,
                ).animate(curvedAnimation),
                child: FractionallySizedBox(
                  heightFactor: heightFactor,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                    child: child,
                  ),
                ),
              ),
            );
          },
        );
}

/// iOS-style fullscreen modal transition
class FullscreenModalPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates a fullscreen modal page transition
  FullscreenModalPageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 350),
    Duration reverseDuration = const Duration(milliseconds: 350),
    super.settings,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          fullscreenDialog: true,
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

/// iOS App Store style card expand transition
class AppStoreCardPageTransition<T> extends PageRouteBuilder<T> {
  /// The widget to display as the new page
  final Widget page;

  /// Creates an App Store card page transition
  AppStoreCardPageTransition({
    required this.page,
    Duration duration = const Duration(milliseconds: 500),
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
                final borderRadius = Tween<double>(
                  begin: 20.0,
                  end: 0.0,
                ).evaluate(curvedAnimation);

                final scale = Tween<double>(
                  begin: 0.9,
                  end: 1.0,
                ).evaluate(curvedAnimation);

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
