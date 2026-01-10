# Page Navigation Transition

[![pub package](https://img.shields.io/pub/v/page_navigation_transition.svg)](https://pub.dev/packages/page_navigation_transition)
[![likes](https://img.shields.io/pub/likes/page_navigation_transition)](https://pub.dev/packages/page_navigation_transition/score)
[![popularity](https://img.shields.io/pub/popularity/page_navigation_transition)](https://pub.dev/packages/page_navigation_transition/score)
[![pub points](https://img.shields.io/pub/points/page_navigation_transition)](https://pub.dev/packages/page_navigation_transition/score)
[![license](https://img.shields.io/github/license/SatishParmar1/page_navigation_transition)](https://github.com/SatishParmar1/page_navigation_transition/blob/main/LICENSE)

A comprehensive Flutter package providing **100+ beautiful page navigation transitions** for your Flutter applications. Easily add smooth, professional animations when navigating between pages.

<p align="center">
  <img src="https://raw.githubusercontent.com/SatishParmar1/page_navigation_transition/main/screenshots/demo.gif" alt="Demo" width="300"/>
</p>

## ✨ Features

- **100+ Pre-built Transitions** organized into 13 categories
- **Type-safe** generic transitions
- **Customizable** duration, curves, and parameters
- **Extension methods** for easy navigation
- **Static factory** for cleaner code
- **Accessibility-friendly** options
- **Zero dependencies** - only Flutter SDK required
- **Cross-platform** - iOS, Android, Web, Desktop

## 📦 Transition Categories

| Category | Count | Examples |
|----------|-------|----------|
| 🎚️ **Slide** | 8 | Slide, Push, Cover, Reveal, Parallax, Elastic, Bouncy |
| 🌫️ **Fade** | 7 | Fade, FadeScale, FadeRotation, FadeThrough, CrossFade |
| 🔍 **Scale** | 8 | Scale, Zoom In/Out, Pop, Shrink/Grow |
| 🔄 **Rotation** | 9 | Rotate, Flip H/V, Spin, Door, Tilt |
| 📐 **Size** | 6 | Expand H/V, Split, Unfold, ClipRect |
| 🎨 **Material Design** | 6 | Shared Axis, Container Transform, Elevation |
| 🍎 **iOS Style** | 7 | Cupertino, Modal, Sheet, Page Curl, App Store Card |
| 🎲 **3D Effects** | 9 | Cube, Card Flip, Carousel, Cover Flow, Perspective |
| ⚡ **Physics-based** | 7 | Spring, Gravity, Elastic Bounce, Pendulum |
| ✨ **Custom Effects** | 10 | Circular Reveal, Blur, Glitch, Accordion, Wipe |
| 💎 **Modern UI** | 9 | Glassmorphism, Liquid Swipe, Gooey, Neumorphism |
| 📱 **Social Media** | 8 | Story, Reels, Snap, Swipe Card, Stacked Cards |
| ♿ **Accessibility** | 7 | No Animation, Simple Fade, Adaptive |

## 🚀 Getting Started

### Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  page_navigation_transition: ^1.0.0
```

Then run:

```bash
flutter pub get
```

### Import

```dart
import 'package:page_navigation_transition/page_navigation_transition.dart';
```

## 📖 Usage

### Method 1: Direct Usage

Use transitions directly with `Navigator.push`:

```dart
Navigator.push(
  context,
  SlidePageTransition<void>(
    page: SecondPage(),
    direction: SlideDirection.fromRight,
    duration: Duration(milliseconds: 300),
  ),
);
```

### Method 2: Extension Methods

Use convenient extension methods on `BuildContext` or `NavigatorState`:

```dart
// Using BuildContext extension
context.pushSlide(SecondPage());
context.pushFade(SecondPage());
context.pushCubeHorizontal(SecondPage());

// Using NavigatorState extension
Navigator.of(context).pushSpring(SecondPage());
Navigator.of(context).pushCircularReveal(SecondPage());
```

### Method 3: Static Factory Methods

Use the `PageTransitions` factory class:

```dart
Navigator.push(
  context,
  PageTransitions.slide(
    SecondPage(),
    direction: SlideDirection.fromBottom,
  ),
);

Navigator.push(
  context,
  PageTransitions.cubeHorizontal(SecondPage()),
);

Navigator.push(
  context,
  PageTransitions.circularReveal(
    SecondPage(),
    center: Alignment.bottomRight,
  ),
);
```

## 🎯 Examples

### Slide Transitions

```dart
// Basic slide from right
Navigator.push(context, SlidePageTransition(page: NextPage()));

// Slide from bottom with custom duration
Navigator.push(context, SlidePageTransition(
  page: NextPage(),
  direction: SlideDirection.fromBottom,
  duration: Duration(milliseconds: 500),
));

// Elastic slide
Navigator.push(context, ElasticSlidePageTransition(page: NextPage()));

// Parallax slide
Navigator.push(context, ParallaxPageTransition(
  page: NextPage(),
  parallaxFactor: 0.3,
));
```

### Fade Transitions

```dart
// Simple fade
Navigator.push(context, FadePageTransition(page: NextPage()));

// Fade with scale
Navigator.push(context, FadeScalePageTransition(
  page: NextPage(),
  beginScale: 0.8,
));

// Fade through (Material Design)
Navigator.push(context, FadeThroughPageTransition(page: NextPage()));
```

### 3D Transitions

```dart
// Cube rotation
Navigator.push(context, CubeHorizontalPageTransition(page: NextPage()));
Navigator.push(context, CubeVerticalPageTransition(page: NextPage()));

// Card flip
Navigator.push(context, CardFlipPageTransition(
  page: NextPage(),
  horizontal: true,
));

// Cover flow
Navigator.push(context, CoverFlowPageTransition(page: NextPage()));
```

### Material Design Transitions

```dart
// Shared axis horizontal
Navigator.push(context, SharedAxisPageTransition(
  page: NextPage(),
  direction: SharedAxisDirection.horizontal,
));

// Container transform
Navigator.push(context, ContainerTransformPageTransition(page: NextPage()));
```

### iOS-style Transitions

```dart
// Cupertino slide (iOS default)
Navigator.push(context, CupertinoSlidePageTransition(page: NextPage()));

// Modal sheet
Navigator.push(context, SheetPageTransition(
  page: NextPage(),
  heightFactor: 0.9,
));
```

### Physics-based Transitions

```dart
// Spring animation
Navigator.push(context, SpringPageTransition(page: NextPage()));

// Elastic bounce
Navigator.push(context, ElasticBouncePageTransition(page: NextPage()));

// Gravity drop
Navigator.push(context, GravityDropPageTransition(page: NextPage()));
```

### Custom Effects

```dart
// Circular reveal from center
Navigator.push(context, CircularRevealPageTransition(
  page: NextPage(),
  center: Alignment.center,
));

// Blur transition
Navigator.push(context, BlurPageTransition(
  page: NextPage(),
  maxBlur: 10.0,
));
```

### Modern UI Transitions

```dart
// Glassmorphism
Navigator.push(context, GlassmorphismPageTransition(page: NextPage()));

// Liquid swipe
Navigator.push(context, LiquidSwipePageTransition(page: NextPage()));

// Gooey effect
Navigator.push(context, GooeyPageTransition(page: NextPage()));
```

### Social Media Transitions

```dart
// Instagram stories
Navigator.push(context, StoryPageTransition(page: NextPage()));

// TikTok/Reels swipe
Navigator.push(context, ReelsPageTransition(page: NextPage()));

// Snapchat style
Navigator.push(context, SnapPageTransition(page: NextPage()));
```

### Accessibility

```dart
// No animation (instant)
Navigator.push(context, NoAnimationPageTransition(page: NextPage()));

// Adaptive (respects system reduce motion)
Navigator.push(context, AdaptivePageTransition(page: NextPage()));
```

## ⚙️ Configuration

All transitions support common parameters:

```dart
SlidePageTransition(
  page: NextPage(),           // Required: The destination page
  direction: SlideDirection.fromRight,  // Direction of slide
  duration: Duration(milliseconds: 300), // Animation duration
  curve: Curves.easeInOut,    // Animation curve
  settings: RouteSettings(name: '/next'), // Route settings
);
```

## 📋 Enums

### SlideDirection
- `fromLeft`, `fromRight`, `fromTop`, `fromBottom`
- `fromTopLeft`, `fromTopRight`, `fromBottomLeft`, `fromBottomRight`

### ScaleOrigin
- `center`, `topLeft`, `topRight`, `bottomLeft`, `bottomRight`
- `topCenter`, `bottomCenter`, `centerLeft`, `centerRight`

### SharedAxisDirection
- `horizontal`, `vertical`

### WipeShape
- `horizontal`, `vertical`, `diagonal`

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

<p align="center">
  <strong>Satish Parmar</strong>
</p>

<p align="center">
  <a href="https://github.com/SatishParmar1">
    <img src="https://img.shields.io/badge/GitHub-SatishParmar1-181717?style=for-the-badge&logo=github" alt="GitHub"/>
  </a>
</p>

<p align="center">
  <a href="https://github.com/SatishParmar1/page_navigation_transition">📦 Repository</a> •
  <a href="https://github.com/SatishParmar1/smart_review_prompter">🌟 smart_review_prompter</a>
</p>

---

<p align="center">
  <strong>⭐ If you like this package, please give it a star on GitHub! ⭐</strong>
</p>
