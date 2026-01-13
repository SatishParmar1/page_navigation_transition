# Page Navigation Transition

[![pub package](https://img.shields.io/pub/v/page_navigation_transition.svg)](https://pub.dev/packages/page_navigation_transition)
[![likes](https://img.shields.io/pub/likes/page_navigation_transition)](https://pub.dev/packages/page_navigation_transition/score)
[![pub points](https://img.shields.io/pub/points/page_navigation_transition)](https://pub.dev/packages/page_navigation_transition/score)
[![license](https://img.shields.io/github/license/SatishParmar1/page_navigation_transition)](https://github.com/SatishParmar1/page_navigation_transition/blob/main/LICENSE)

A comprehensive Flutter package providing **110+ beautiful page navigation transitions** for your Flutter applications. Easily add smooth, professional animations when navigating between pages.

<p align="center">
  <img src="https://ik.imagekit.io/rh19kamog/Screenshot_20260113_160651.png" alt="Home Screen" width="250"/>
  <img src="https://ik.imagekit.io/rh19kamog/Screenshot_20260113_160722.png" alt="Categories" width="250"/>
  <img src="https://ik.imagekit.io/rh19kamog/Screenshot_20260113_160735.png" alt="Transitions" width="250"/>
</p>

<p align="center">
  <a href="https://ik.imagekit.io/rh19kamog/Screen_recording_20260113_160926.webm">
    <img src="https://img.shields.io/badge/▶️-Watch%20Demo%20Video-blue?style=for-the-badge" alt="Watch Demo"/>
  </a>
</p>

## ✨ Features

- **110+ Pre-built Transitions** organized into 14 categories
- **Type-safe** generic transitions
- **Customizable** duration, curves, and parameters
- **Extension methods** for easy navigation
- **Static factory** for cleaner code
- **Accessibility-friendly** options
- **Zero dependencies** - only Flutter SDK required
- **Cross-platform** - iOS, Android, Web, Desktop

### 🆕 New in v1.1.0

- 🛤️ **Named Route Support** - Use transitions with `onGenerateRoute` and named routes
- 🦸 **Hero Transitions** - Hero-aware transitions that coordinate with Flutter's Hero widget
- 🔧 **Custom Curve Builder** - Fluent API for creating spring, bounce, and elastic curves
- 🎨 **Transition Presets** - 8 pre-configured themes (Elegant, Playful, Professional, Gaming, etc.)
- 🎲 **6 New 3D Effects** - Origami, Prism, Sphere, ZStack, LayeredDepth, Hologram
- ⚡ **Performance Optimizations** - RepaintBoundary wrappers, matrix caching, reduced motion support

## 📦 Transition Categories

| Category | Count | Examples |
|----------|-------|----------|
| 🎚️ **Slide** | 9 | Slide, Push, Cover, Reveal, Parallax, Elastic, Bouncy |
| 🌫️ **Fade** | 8 | Fade, FadeScale, FadeRotation, FadeThrough, CrossFade |
| 🔍 **Scale** | 10 | Scale, Zoom In/Out, Pop, Shrink/Grow |
| 🔄 **Rotation** | 9 | Rotate, Flip H/V, Spin, Door, Tilt |
| 📐 **Size** | 8 | Expand H/V, Split, Unfold, ClipRect |
| 🎨 **Material Design** | 5 | Shared Axis, Container Transform, Elevation |
| 🍎 **iOS Style** | 6 | Cupertino, Modal, Sheet, Page Curl, App Store Card |
| 🎲 **3D Effects** | 16 | Cube, Card Flip, Carousel, Origami, Prism, Sphere, Hologram |
| ⚡ **Physics-based** | 9 | Spring, Gravity, Elastic Bounce, Pendulum |
| ✨ **Custom Effects** | 10 | Circular Reveal, Blur, Glitch, Accordion, Wipe |
| 💎 **Modern UI** | 9 | Glassmorphism, Liquid Swipe, Gooey, Neumorphism |
| 📱 **Social Media** | 11 | Story, Reels, Snap, Swipe Card, Stacked Cards |
| ♿ **Accessibility** | 7 | No Animation, Simple Fade, Adaptive |
| 🦸 **Hero** | 5 | HeroSlide, HeroFade, HeroScale, HeroZoom, HeroContainer |

## 🚀 Getting Started

### Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  page_navigation_transition: ^1.1.0
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

```dart
Navigator.push(
  context,
  PageTransitions.slide(SecondPage()),
);

Navigator.push(
  context,
  PageTransitions.cubeHorizontal(SecondPage()),
);
```

## � v1.1.0 Features

### 🛤️ Named Route Support

Use transitions with Flutter's named routes via `TransitionRouter`:

```dart
final router = TransitionRouter(
  routes: {
    '/': TransitionRouteConfig(
      builder: (context) => HomePage(),
      transitionType: TransitionType.fade,
    ),
    '/details': TransitionRouteConfig(
      builder: (context) => DetailsPage(),
      transitionType: TransitionType.slide,
    ),
  },
);

MaterialApp(
  onGenerateRoute: router.onGenerateRoute,
  initialRoute: '/',
)
```

### 🦸 Hero Transitions

Coordinate page transitions with Hero widget animations:

```dart
Navigator.push(context, HeroSlidePageTransition(
  page: DetailPage(),
  heroTag: 'product-${product.id}',
  direction: SlideDirection.fromRight,
));

Navigator.push(context, HeroContainerTransformTransition(
  page: DetailPage(),
  heroTag: 'card-${item.id}',
  containerColor: Colors.white,
));
```

### 🎨 Transition Presets

Use pre-configured themes for consistent animations:

```dart
// Wrap your app with TransitionTheme
TransitionTheme(
  preset: TransitionPreset.elegant,
  child: MaterialApp(...),
)

// Available presets:
TransitionPreset.elegant      // Subtle, sophisticated
TransitionPreset.playful      // Bouncy, energetic
TransitionPreset.professional // Clean, efficient
TransitionPreset.gaming       // Dramatic, impactful
TransitionPreset.minimal      // Fast, no-nonsense
TransitionPreset.iosStyle     // Native iOS feel
TransitionPreset.material     // Material Design standard
TransitionPreset.cinematic    // Slow, dramatic
```

### 🔧 Custom Curve Builder

Create custom animation curves with a fluent API:

```dart
// Spring curve
final springCurve = CurveBuilder()
  .spring(damping: 0.7, stiffness: 100)
  .build();

// Bounce curve
final bounceCurve = CurveBuilder()
  .bounce(bounces: 3, bounciness: 0.5)
  .build();

// Pre-built curves
TransitionCurves.smoothSpring
TransitionCurves.gentleBounce
TransitionCurves.snappy
```

### 🎲 New 3D Effects

Six stunning new 3D transitions:

```dart
// Origami paper-folding effect
Navigator.push(context, OrigamiPageTransition(page: NextPage()));

// Prism triangular rotation
Navigator.push(context, PrismPageTransition(page: NextPage()));

// Sphere mapping effect
Navigator.push(context, SpherePageTransition(page: NextPage()));

// Futuristic hologram
Navigator.push(context, HologramPageTransition(
  page: NextPage(),
  hologramColor: Colors.cyan,
));
```

## 📋 Transition Examples

### Slide Transitions
```dart
Navigator.push(context, SlidePageTransition(page: NextPage()));
Navigator.push(context, PushPageTransition(page: NextPage()));
Navigator.push(context, ParallaxPageTransition(page: NextPage()));
```

### 3D Transitions
```dart
Navigator.push(context, CubeHorizontalPageTransition(page: NextPage()));
Navigator.push(context, CardFlipPageTransition(page: NextPage()));
Navigator.push(context, CarouselPageTransition(page: NextPage()));
```

### Physics-based
```dart
Navigator.push(context, SpringPageTransition(page: NextPage()));
Navigator.push(context, ElasticBouncePageTransition(page: NextPage()));
Navigator.push(context, GravityDropPageTransition(page: NextPage()));
```

### Modern UI
```dart
Navigator.push(context, GlassmorphismPageTransition(page: NextPage()));
Navigator.push(context, LiquidSwipePageTransition(page: NextPage()));
Navigator.push(context, NeumorphismPageTransition(page: NextPage()));
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

### TransitionType (for named routes)
- `slide`, `slideUp`, `fade`, `fadeScale`, `scale`
- `rotation`, `cubeHorizontal`, `cubeVertical`, `cardFlip`
- `cupertino`, `sharedAxis`, `spring`, `circularReveal`, `none`

## 👤 Author

**Satish Parmar**

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=flat-square&logo=linkedin)](https://www.linkedin.com/in/satish-parmar-ak978312/)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black?style=flat-square&logo=github)](https://github.com/SatishParmar1)

### Other Packages by Author

| Package | Description |
|---------|-------------|
| 📸 [photo_opener_view](https://pub.dev/packages/photo_opener_view) | A beautiful photo viewer package for Flutter |
| ⭐ [smart_review_prompter](https://pub.dev/packages/smart_review_prompter) | Smart app review prompting for Flutter |
| 🎬 [page_navigation_transition](https://pub.dev/packages/page_navigation_transition) | 110+ page navigation transitions |

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## ⭐ Support

If you find this package helpful, please give it a ⭐ on [GitHub](https://github.com/SatishParmar1/page_navigation_transition)!

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<p align="center">
  Made with ❤️ by <a href="https://www.linkedin.com/in/satish-parmar-ak978312/">Satish Parmar</a>
</p>
