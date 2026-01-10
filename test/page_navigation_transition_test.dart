import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:page_navigation_transition/page_navigation_transition.dart';

void main() {
  group('Slide Transitions', () {
    test('SlidePageTransition creates valid route', () {
      final route = SlidePageTransition<void>(
        page: const Scaffold(),
        direction: SlideDirection.fromRight,
      );

      expect(route, isA<PageRouteBuilder<void>>());
      expect(route.transitionDuration, const Duration(milliseconds: 300));
    });

    test('SlideFadePageTransition creates valid route', () {
      final route = SlideFadePageTransition<void>(
        page: const Scaffold(),
        direction: SlideDirection.fromBottom,
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });

    test('ElasticSlidePageTransition creates valid route', () {
      final route = ElasticSlidePageTransition<void>(
        page: const Scaffold(),
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });
  });

  group('Fade Transitions', () {
    test('FadePageTransition creates valid route', () {
      final route = FadePageTransition<void>(
        page: const Scaffold(),
        duration: const Duration(milliseconds: 500),
      );

      expect(route, isA<PageRouteBuilder<void>>());
      expect(route.transitionDuration, const Duration(milliseconds: 500));
    });

    test('FadeScalePageTransition creates valid route', () {
      final route = FadeScalePageTransition<void>(
        page: const Scaffold(),
        beginScale: 0.5,
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });
  });

  group('Scale Transitions', () {
    test('ScalePageTransition creates valid route', () {
      final route = ScalePageTransition<void>(
        page: const Scaffold(),
        origin: ScaleOrigin.topLeft,
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });

    test('ZoomInPageTransition creates valid route', () {
      final route = ZoomInPageTransition<void>(
        page: const Scaffold(),
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });
  });

  group('Rotation Transitions', () {
    test('RotationPageTransition creates valid route', () {
      final route = RotationPageTransition<void>(
        page: const Scaffold(),
        beginTurns: 0.5,
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });

    test('FlipHorizontalPageTransition creates valid route', () {
      final route = FlipHorizontalPageTransition<void>(
        page: const Scaffold(),
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });
  });

  group('3D Transitions', () {
    test('CubeHorizontalPageTransition creates valid route', () {
      final route = CubeHorizontalPageTransition<void>(
        page: const Scaffold(),
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });

    test('CardFlipPageTransition creates valid route', () {
      final route = CardFlipPageTransition<void>(
        page: const Scaffold(),
        horizontal: true,
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });
  });

  group('Material Transitions', () {
    test('SharedAxisPageTransition creates valid route', () {
      final route = SharedAxisPageTransition<void>(
        page: const Scaffold(),
        direction: SharedAxisDirection.horizontal,
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });

    test('ContainerTransformPageTransition creates valid route', () {
      final route = ContainerTransformPageTransition<void>(
        page: const Scaffold(),
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });
  });

  group('iOS Transitions', () {
    test('CupertinoSlidePageTransition creates valid route', () {
      final route = CupertinoSlidePageTransition<void>(
        page: const Scaffold(),
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });

    test('SheetPageTransition creates valid route', () {
      final route = SheetPageTransition<void>(
        page: const Scaffold(),
        heightFactor: 0.9,
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });
  });

  group('Physics Transitions', () {
    test('SpringPageTransition creates valid route', () {
      final route = SpringPageTransition<void>(
        page: const Scaffold(),
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });

    test('GravityDropPageTransition creates valid route', () {
      final route = GravityDropPageTransition<void>(
        page: const Scaffold(),
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });
  });

  group('Custom Transitions', () {
    test('CircularRevealPageTransition creates valid route', () {
      final route = CircularRevealPageTransition<void>(
        page: const Scaffold(),
        center: Alignment.center,
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });

    test('BlurPageTransition creates valid route', () {
      final route = BlurPageTransition<void>(
        page: const Scaffold(),
        maxBlur: 10.0,
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });
  });

  group('Modern Transitions', () {
    test('GlassmorphismPageTransition creates valid route', () {
      final route = GlassmorphismPageTransition<void>(
        page: const Scaffold(),
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });

    test('LiquidSwipePageTransition creates valid route', () {
      final route = LiquidSwipePageTransition<void>(
        page: const Scaffold(),
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });
  });

  group('Social Transitions', () {
    test('StoryPageTransition creates valid route', () {
      final route = StoryPageTransition<void>(
        page: const Scaffold(),
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });

    test('ReelsPageTransition creates valid route', () {
      final route = ReelsPageTransition<void>(
        page: const Scaffold(),
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });
  });

  group('Accessibility Transitions', () {
    test('NoAnimationPageTransition creates valid route', () {
      final route = NoAnimationPageTransition<void>(
        page: const Scaffold(),
      );

      expect(route, isA<PageRouteBuilder<void>>());
      expect(route.transitionDuration, Duration.zero);
    });

    test('AdaptivePageTransition creates valid route', () {
      final route = AdaptivePageTransition<void>(
        page: const Scaffold(),
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });
  });

  group('PageTransitions Factory', () {
    test('PageTransitions.slide creates valid route', () {
      final route = PageTransitions.slide<void>(
        const Scaffold(),
        direction: SlideDirection.fromRight,
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });

    test('PageTransitions.fade creates valid route', () {
      final route = PageTransitions.fade<void>(
        const Scaffold(),
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });

    test('PageTransitions.scale creates valid route', () {
      final route = PageTransitions.scale<void>(
        const Scaffold(),
        origin: ScaleOrigin.center,
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });

    test('PageTransitions.cubeHorizontal creates valid route', () {
      final route = PageTransitions.cubeHorizontal<void>(
        const Scaffold(),
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });

    test('PageTransitions.cupertino creates valid route', () {
      final route = PageTransitions.cupertino<void>(
        const Scaffold(),
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });

    test('PageTransitions.spring creates valid route', () {
      final route = PageTransitions.spring<void>(
        const Scaffold(),
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });

    test('PageTransitions.circularReveal creates valid route', () {
      final route = PageTransitions.circularReveal<void>(
        const Scaffold(),
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });

    test('PageTransitions.adaptive creates valid route', () {
      final route = PageTransitions.adaptive<void>(
        const Scaffold(),
      );

      expect(route, isA<PageRouteBuilder<void>>());
    });
  });

  group('Enums', () {
    test('SlideDirection has all directions', () {
      expect(SlideDirection.values.length, 8);
    });

    test('ScaleOrigin has all origins', () {
      expect(ScaleOrigin.values.length, 9);
    });

    test('RotationAxis has all axes', () {
      expect(RotationAxis.values.length, 3);
    });

    test('SharedAxisDirection has all directions', () {
      expect(SharedAxisDirection.values.length, 3);
    });
  });
}
