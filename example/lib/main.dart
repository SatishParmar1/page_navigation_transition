import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_navigation_transition/page_navigation_transition.dart';

// Professional color palette
class AppColors {
  static const background = Color(0xFF0F172A); // slate-900
  static const backgroundAlt = Color(0xFF020617); // deep navy
  static const surface = Color(0xFF111827); // slate-800
  static const surfaceLight = Color(0xFF1E293B); // slate-700

  // Borders & dividers
  static const border = Color(0xFF334155);
  static const borderLight = Color(0xFF475569);

  // Text
  static const textPrimary = Color(0xFFF8FAFC);
  static const textSecondary = Color(0xFFCBD5E1);
  static const textMuted = Color(0xFF94A3B8);

  // Primary accent (Blue)
  static const accent = Color(0xFF3B82F6);
  static const accentLight = Color(0xFF60A5FA);

  // Secondary accents
  static const purple = Color(0xFF8B5CF6);
  static const teal = Color(0xFF14B8A6);
  static const cyan = Color(0xFF22D3EE);

  // Status
  static const success = Color(0xFF22C55E);
  static const warning = Color(0xFFFACC15);
  static const error = Color(0xFFEF4444);
  static const info = Color(0xFF38BDF8);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.background,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const TransitionShowcaseApp());
}

class TransitionShowcaseApp extends StatelessWidget {
  const TransitionShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Page Transitions',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.accent,
          secondary: AppColors.accentLight,
          surface: AppColors.surface,
          onSurface: AppColors.textPrimary,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
            color: AppColors.textPrimary,
          ),
          titleLarge: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
          bodyLarge: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.textMuted,
          ),
        ),
      ),
      home: const TransitionShowcaseHome(),
    );
  }
}

// Category data model
class CategoryData {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final List<TransitionItem> transitions;

  const CategoryData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.transitions,
  });
}

class TransitionShowcaseHome extends StatefulWidget {
  const TransitionShowcaseHome({super.key});

  @override
  State<TransitionShowcaseHome> createState() => _TransitionShowcaseHomeState();
}

class _TransitionShowcaseHomeState extends State<TransitionShowcaseHome>
    with TickerProviderStateMixin {
  late final List<AnimationController> _staggeredControllers;

  final List<CategoryData> categories = [
    CategoryData(
      title: 'Slide',
      subtitle: '9 transitions',
      icon: Icons.swap_horiz_rounded,
      iconColor: const Color(0xFF3B82F6),
      transitions: slideTransitions,
    ),
    CategoryData(
      title: 'Fade',
      subtitle: '8 transitions',
      icon: Icons.blur_on_rounded,
      iconColor: const Color(0xFF8B5CF6),
      transitions: fadeTransitions,
    ),
    CategoryData(
      title: 'Scale',
      subtitle: '10 transitions',
      icon: Icons.zoom_out_map_rounded,
      iconColor: const Color(0xFFEC4899),
      transitions: scaleTransitions,
    ),
    CategoryData(
      title: 'Rotation',
      subtitle: '9 transitions',
      icon: Icons.rotate_right_rounded,
      iconColor: const Color(0xFFF59E0B),
      transitions: rotationTransitions,
    ),
    CategoryData(
      title: 'Size',
      subtitle: '8 transitions',
      icon: Icons.aspect_ratio_rounded,
      iconColor: const Color(0xFF10B981),
      transitions: sizeTransitions,
    ),
    CategoryData(
      title: 'Material',
      subtitle: '5 transitions',
      icon: Icons.android_rounded,
      iconColor: const Color(0xFF06B6D4),
      transitions: materialTransitions,
    ),
    CategoryData(
      title: 'iOS',
      subtitle: '6 transitions',
      icon: Icons.phone_iphone_rounded,
      iconColor: const Color(0xFF71717A),
      transitions: iosTransitions,
    ),
    CategoryData(
      title: '3D',
      subtitle: '10 transitions',
      icon: Icons.view_in_ar_rounded,
      iconColor: const Color(0xFFEF4444),
      transitions: threeDTransitions,
    ),
    CategoryData(
      title: 'Physics',
      subtitle: '9 transitions',
      icon: Icons.sports_baseball_rounded,
      iconColor: const Color(0xFFF97316),
      transitions: physicsTransitions,
    ),
    CategoryData(
      title: 'Custom',
      subtitle: '10 transitions',
      icon: Icons.auto_awesome_rounded,
      iconColor: const Color(0xFF8B5CF6),
      transitions: customTransitions,
    ),
    CategoryData(
      title: 'Modern',
      subtitle: '9 transitions',
      icon: Icons.blur_circular_rounded,
      iconColor: const Color(0xFF0EA5E9),
      transitions: modernTransitions,
    ),
    CategoryData(
      title: 'Social',
      subtitle: '11 transitions',
      icon: Icons.photo_camera_rounded,
      iconColor: const Color(0xFFE11D48),
      transitions: socialTransitions,
    ),
    CategoryData(
      title: 'Accessibility',
      subtitle: '7 transitions',
      icon: Icons.accessibility_new_rounded,
      iconColor: const Color(0xFF14B8A6),
      transitions: accessibilityTransitions,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _staggeredControllers = List.generate(
      categories.length,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      ),
    );
    _startStaggeredAnimation();
  }

  void _startStaggeredAnimation() async {
    await Future.delayed(const Duration(milliseconds: 100));
    for (int i = 0; i < _staggeredControllers.length; i++) {
      await Future.delayed(const Duration(milliseconds: 40));
      if (mounted) {
        _staggeredControllers[i].forward();
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _staggeredControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    const Text(
                      'Page Transitions',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Explore 101 beautiful animation effects',
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Search/filter bar (decorative)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search_rounded,
                            color: AppColors.textMuted,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Search transitions...',
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 14,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceLight,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              '⌘ K',
                              style: TextStyle(
                                color: AppColors.textMuted,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Stats row with color
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.accent.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.folder_rounded,
                                color: AppColors.accent,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '13 categories',
                                style: TextStyle(
                                  color: AppColors.accent,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF10B981,
                            ).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(
                                0xFF10B981,
                              ).withValues(alpha: 0.2),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.auto_awesome_rounded,
                                color: const Color(0xFF10B981),
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '101 effects',
                                style: TextStyle(
                                  color: const Color(0xFF10B981),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Section title
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Categories list
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return AnimatedBuilder(
                    animation: _staggeredControllers[index],
                    builder: (context, child) {
                      final animation = CurvedAnimation(
                        parent: _staggeredControllers[index],
                        curve: Curves.easeOut,
                      );
                      return Transform.translate(
                        offset: Offset(0, 20 * (1 - animation.value)),
                        child: Opacity(
                          opacity: animation.value.clamp(0.0, 1.0),
                          child: _CategoryListItem(
                            category: categories[index],
                            isLast: index == categories.length - 1,
                          ),
                        ),
                      );
                    },
                  );
                }, childCount: categories.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryListItem extends StatefulWidget {
  final CategoryData category;
  final bool isLast;

  const _CategoryListItem({required this.category, this.isLast = false});

  @override
  State<_CategoryListItem> createState() => _CategoryListItemState();
}

class _CategoryListItemState extends State<_CategoryListItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isHovered = true),
      onTapUp: (_) => setState(() => _isHovered = false),
      onTapCancel: () => setState(() => _isHovered = false),
      onTap: () {
        Navigator.push(
          context,
          FadeScalePageTransition(
            page: TransitionListPage(
              title: widget.category.title,
              iconColor: widget.category.iconColor,
              transitions: widget.category.transitions,
            ),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        margin: EdgeInsets.only(bottom: widget.isLast ? 0 : 2),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: widget.category.iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                widget.category.icon,
                color: widget.category.iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.category.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.category.subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            // Arrow
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textMuted,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class TransitionListPage extends StatelessWidget {
  final String title;
  final Color iconColor;
  final List<TransitionItem> transitions;

  const TransitionListPage({
    super.key,
    required this.title,
    required this.iconColor,
    required this.transitions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.textPrimary,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        '$title Transitions',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: iconColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${transitions.length}',
                        style: TextStyle(
                          color: iconColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Transitions list
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return _TransitionTile(
                  item: transitions[index],
                  iconColor: iconColor,
                  index: index,
                );
              }, childCount: transitions.length),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }
}

class _TransitionTile extends StatefulWidget {
  final TransitionItem item;
  final Color iconColor;
  final int index;

  const _TransitionTile({
    required this.item,
    required this.iconColor,
    required this.index,
  });

  @override
  State<_TransitionTile> createState() => _TransitionTileState();
}

class _TransitionTileState extends State<_TransitionTile> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {
        Navigator.push(context, widget.item.route(const DemoPage()));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: _isPressed ? AppColors.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Index badge
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: widget.iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '${widget.index + 1}',
                  style: TextStyle(
                    color: widget.iconColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.item.description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textMuted,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Arrow
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textMuted,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.textPrimary,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Main content
            Expanded(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Success icon with gradient glow
                      Container(
                        width: 88,
                        height: 88,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.accent.withValues(alpha: 0.25),
                              AppColors.accentLight.withValues(alpha: 0.15),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: const Icon(
                          Icons.check_rounded,
                          size: 42,
                          color: AppColors.accent,
                        ),
                      ),

                      const SizedBox(height: 24),

                      const Text(
                        'Transition Complete',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.5,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Everything went smoothly',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Divider
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: AppColors.border,
                      ),

                      const SizedBox(height: 16),

                      // Accent chip
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Text(
                          'Status: Success',
                          style: TextStyle(
                            color: AppColors.accent,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Action button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accent,
                            foregroundColor: AppColors.textPrimary,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Go Back',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// ============ Transition Data ============

class TransitionItem {
  final String name;
  final String description;
  final PageRouteBuilder Function(Widget page) route;

  const TransitionItem({
    required this.name,
    required this.description,
    required this.route,
  });
}

final slideTransitions = [
  TransitionItem(
    name: 'Slide',
    description: 'Basic slide from right',
    route: (page) => SlidePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Slide from Bottom',
    description: 'Slides up from bottom',
    route: (page) =>
        SlidePageTransition(page: page, direction: SlideDirection.fromBottom),
  ),
  TransitionItem(
    name: 'Push',
    description: 'Push transition with previous page moving',
    route: (page) => PushPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Cover',
    description: 'New page covers the old one',
    route: (page) => CoverPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Reveal',
    description: 'Old page reveals the new one',
    route: (page) => RevealPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Parallax',
    description: 'Parallax effect during transition',
    route: (page) => ParallaxPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Slide + Fade',
    description: 'Slide with fade effect',
    route: (page) => SlideFadePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Elastic Slide',
    description: 'Slide with elastic overshoot',
    route: (page) => ElasticSlidePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Bouncy Slide',
    description: 'Slide with bouncy effect',
    route: (page) => BouncySlidePageTransition(page: page),
  ),
];

final fadeTransitions = [
  TransitionItem(
    name: 'Fade',
    description: 'Simple fade transition',
    route: (page) => FadePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Fade + Scale',
    description: 'Fade with scale effect',
    route: (page) => FadeScalePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Fade + Rotation',
    description: 'Fade with rotation effect',
    route: (page) => FadeRotationPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Fade + Slide',
    description: 'Fade with slide from bottom',
    route: (page) => FadeSlidePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Fade Through',
    description: 'Material fade through pattern',
    route: (page) => FadeThroughPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Cross Fade',
    description: 'Cross fade between pages',
    route: (page) => CrossFadePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Fade Zoom In',
    description: 'Fade with zoom in effect',
    route: (page) => FadeZoomInPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Fade Zoom Out',
    description: 'Fade with zoom out effect',
    route: (page) => FadeZoomOutPageTransition(page: page),
  ),
];

final scaleTransitions = [
  TransitionItem(
    name: 'Scale',
    description: 'Scale from center',
    route: (page) => ScalePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Scale + Fade',
    description: 'Scale with fade effect',
    route: (page) => ScaleFadePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Shrink & Grow',
    description: 'Old shrinks, new grows',
    route: (page) => ShrinkGrowPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Zoom In',
    description: 'Zoom in from small to full',
    route: (page) => ZoomInPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Zoom Out',
    description: 'Zoom from large to normal',
    route: (page) => ZoomOutPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Zoom In + Fade',
    description: 'Zoom in with fade',
    route: (page) => ZoomInFadePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Zoom Out + Fade',
    description: 'Zoom out with fade',
    route: (page) => ZoomOutFadePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Pop Scale',
    description: 'Pop effect with overshoot',
    route: (page) => PopScalePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Scale + Rotation',
    description: 'Scale with rotation',
    route: (page) => ScaleRotationPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Depth Scale',
    description: '3D depth scale effect',
    route: (page) => DepthScalePageTransition(page: page),
  ),
];

final rotationTransitions = [
  TransitionItem(
    name: 'Rotation',
    description: 'Full rotation transition',
    route: (page) => RotationPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Flip Horizontal',
    description: '3D horizontal flip',
    route: (page) => FlipHorizontalPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Flip Vertical',
    description: '3D vertical flip',
    route: (page) => FlipVerticalPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Rotation + Fade',
    description: 'Rotation with fade',
    route: (page) => RotationFadePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Rotation + Scale',
    description: 'Rotation with scale',
    route: (page) => RotationScalePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Rotation + Scale + Fade',
    description: 'Combined rotation effects',
    route: (page) => RotationScaleFadePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Spin',
    description: 'Spin entrance animation',
    route: (page) => SpinPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Tilt Rotation',
    description: '3D tilt effect',
    route: (page) => TiltRotationPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Door Rotation',
    description: 'Door opening effect',
    route: (page) => DoorRotationPageTransition(page: page),
  ),
];

final sizeTransitions = [
  TransitionItem(
    name: 'Size',
    description: 'Size-based transition',
    route: (page) => SizePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Expand Horizontal',
    description: 'Expand from left to right',
    route: (page) => ExpandHorizontalPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Expand Vertical',
    description: 'Expand from top to bottom',
    route: (page) => ExpandVerticalPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Expand from Center',
    description: 'Expand from center outward',
    route: (page) => ExpandFromCenterPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Clip Rect',
    description: 'Clip rectangle reveal',
    route: (page) => ClipRectPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Align Size',
    description: 'Aligned size transition',
    route: (page) => AlignSizePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Unfold',
    description: 'Unfold from corner',
    route: (page) => UnfoldPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Split',
    description: 'Split screen reveal',
    route: (page) => SplitPageTransition(page: page),
  ),
];

final materialTransitions = [
  TransitionItem(
    name: 'Shared Axis (Horizontal)',
    description: 'Material shared axis X',
    route: (page) => SharedAxisPageTransition(
      page: page,
      direction: SharedAxisDirection.horizontal,
    ),
  ),
  TransitionItem(
    name: 'Shared Axis (Vertical)',
    description: 'Material shared axis Y',
    route: (page) => SharedAxisPageTransition(
      page: page,
      direction: SharedAxisDirection.vertical,
    ),
  ),
  TransitionItem(
    name: 'Fade Through',
    description: 'Material fade through',
    route: (page) => FadeThroughMaterialPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Container Transform',
    description: 'Material container transform',
    route: (page) => ContainerTransformPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Elevation Scale',
    description: 'Elevation with scale',
    route: (page) => ElevationScalePageTransition(page: page),
  ),
];

final iosTransitions = [
  TransitionItem(
    name: 'Cupertino Slide',
    description: 'iOS default slide',
    route: (page) => CupertinoSlidePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Modal Slide',
    description: 'iOS modal presentation',
    route: (page) => ModalSlidePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Page Curl',
    description: 'Page curl effect',
    route: (page) => PageCurlPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Sheet',
    description: 'Bottom sheet style',
    route: (page) => SheetPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Fullscreen Modal',
    description: 'iOS fullscreen modal',
    route: (page) => FullscreenModalPageTransition(page: page),
  ),
  TransitionItem(
    name: 'App Store Card',
    description: 'App Store card expand',
    route: (page) => AppStoreCardPageTransition(page: page),
  ),
];

final threeDTransitions = [
  TransitionItem(
    name: 'Cube Horizontal',
    description: '3D cube rotation X',
    route: (page) => CubeHorizontalPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Cube Vertical',
    description: '3D cube rotation Y',
    route: (page) => CubeVerticalPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Inside Cube',
    description: 'Inside cube view',
    route: (page) => InsideCubePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Card Flip',
    description: '3D card flip',
    route: (page) => CardFlipPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Carousel',
    description: 'Carousel effect',
    route: (page) => CarouselPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Cover Flow',
    description: 'iTunes cover flow',
    route: (page) => CoverFlowPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Cylinder Wrap',
    description: 'Cylindrical wrap',
    route: (page) => CylinderWrapPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Perspective Zoom',
    description: 'Perspective zoom effect',
    route: (page) => PerspectiveZoomPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Parallax Depth',
    description: '3D parallax depth',
    route: (page) => ParallaxDepthPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Fold',
    description: 'Paper fold effect',
    route: (page) => FoldPageTransition(page: page),
  ),
];

final physicsTransitions = [
  TransitionItem(
    name: 'Spring',
    description: 'Spring physics animation',
    route: (page) => SpringPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Gravity Drop',
    description: 'Gravity drop effect',
    route: (page) => GravityDropPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Elastic Bounce',
    description: 'Elastic bounce entrance',
    route: (page) => ElasticBouncePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Damped Oscillation',
    description: 'Damped oscillation effect',
    route: (page) => DampedOscillationPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Inertia Slide',
    description: 'Inertia-based slide',
    route: (page) => InertiaSlidePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Rubber Band',
    description: 'Rubber band stretch',
    route: (page) => RubberBandPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Pendulum',
    description: 'Pendulum swing effect',
    route: (page) => PendulumPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Over-Scroll Bounce',
    description: 'Over-scroll with bounce',
    route: (page) => OverScrollBouncePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Spring Rebound',
    description: 'Spring rebound effect',
    route: (page) => SpringReboundPageTransition(page: page),
  ),
];

final customTransitions = [
  TransitionItem(
    name: 'Circular Reveal',
    description: 'Circular reveal from center',
    route: (page) => CircularRevealPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Blur',
    description: 'Blur transition effect',
    route: (page) => BlurPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Glitch',
    description: 'Digital glitch effect',
    route: (page) => GlitchPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Accordion',
    description: 'Accordion fold effect',
    route: (page) => AccordionPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Book Flip',
    description: 'Book page flip',
    route: (page) => BookFlipPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Stack Depth',
    description: 'Stack depth effect',
    route: (page) => StackDepthPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Shutter',
    description: 'Camera shutter effect',
    route: (page) => ShutterPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Wipe',
    description: 'Wipe reveal effect',
    route: (page) => WipePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Spotlight',
    description: 'Spotlight reveal',
    route: (page) => SpotlightPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Pixelate',
    description: 'Pixelation effect',
    route: (page) => PixelatePageTransition(page: page),
  ),
];

final modernTransitions = [
  TransitionItem(
    name: 'Glassmorphism',
    description: 'Frosted glass effect',
    route: (page) => GlassmorphismPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Sliding Glass Panels',
    description: 'Glass panel slide',
    route: (page) => SlidingGlassPanelsPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Liquid Swipe',
    description: 'Liquid swipe effect',
    route: (page) => LiquidSwipePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Wavy Edge',
    description: 'Wavy edge reveal',
    route: (page) => WavyEdgePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Gooey',
    description: 'Gooey blob effect',
    route: (page) => GooeyPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Splash Reveal',
    description: 'Splash reveal effect',
    route: (page) => SplashRevealPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Neumorphism',
    description: 'Soft UI transition',
    route: (page) => NeumorphismPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Bubble Inflate',
    description: 'Bubble inflate effect',
    route: (page) => BubbleInflatePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Curtain Reveal',
    description: 'Curtain opening effect',
    route: (page) => CurtainRevealPageTransition(page: page),
  ),
];

final socialTransitions = [
  TransitionItem(
    name: 'Story',
    description: 'Instagram stories style',
    route: (page) => StoryPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Reels',
    description: 'Instagram reels swipe',
    route: (page) => ReelsPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Snap',
    description: 'Snapchat/TikTok style',
    route: (page) => SnapPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Slide with Bounce',
    description: 'Slide with bounce effect',
    route: (page) => SlideWithBouncePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Flash',
    description: 'Camera flash effect',
    route: (page) => FlashPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Cross Fade Audio',
    description: 'Spotify-like cross fade',
    route: (page) => CrossFadeAudioPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Album Art Expand',
    description: 'Album art expansion',
    route: (page) => AlbumArtExpandPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Now Playing Slide',
    description: 'Music player slide',
    route: (page) => NowPlayingSlidePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Swipe Card',
    description: 'Tinder-like swipe',
    route: (page) => SwipeCardPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Pull to Dismiss',
    description: 'Pull down to dismiss',
    route: (page) => PullToDismissPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Stacked Cards',
    description: 'Card stack animation',
    route: (page) => StackedCardsPageTransition(page: page),
  ),
];

final accessibilityTransitions = [
  TransitionItem(
    name: 'No Animation',
    description: 'Instant transition',
    route: (page) => NoAnimationPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Simple Fade',
    description: 'Quick, subtle fade',
    route: (page) => SimpleFadePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Minimal Movement',
    description: 'Reduced motion',
    route: (page) => MinimalMovementPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Opacity Only',
    description: 'Opacity change only',
    route: (page) => OpacityOnlyPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Transform Only',
    description: 'Simple transform',
    route: (page) => TransformOnlyPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Adaptive',
    description: 'Respects system settings',
    route: (page) => AdaptivePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Fast Snap',
    description: 'Ultra-fast transition',
    route: (page) => FastSnapPageTransition(page: page),
  ),
];
