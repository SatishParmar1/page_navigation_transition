import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_navigation_transition/page_navigation_transition.dart';

// ============ Premium Silver Theme ============
class AppColors {
  // Silver/Metallic Base
  static const background = Color(0xFF0A0A0F);
  static const backgroundGradientStart = Color(0xFF0F0F14);
  static const backgroundGradientEnd = Color(0xFF050508);

  // Metallic Surfaces
  static const surface = Color(0xFF16161D);
  static const surfaceLight = Color(0xFF1E1E26);
  static const surfaceElevated = Color(0xFF24242E);

  // Silver Accents
  static const silver = Color(0xFFC0C0C8);
  static const silverLight = Color(0xFFE8E8F0);
  static const silverDark = Color(0xFF8A8A94);

  // Borders
  static const border = Color(0xFF2A2A35);
  static const borderLight = Color(0xFF3A3A48);
  static const glowBorder = Color(0xFF4A4A58);

  // Text
  static const textPrimary = Color(0xFFF5F5FA);
  static const textSecondary = Color(0xFFB8B8C4);
  static const textMuted = Color(0xFF6E6E7A);

  // Accent Colors
  static const accent = Color(0xFF7C7CFF); // Soft purple
  static const accentLight = Color(0xFFA5A5FF);
  static const accentGlow = Color(0xFF5050FF);

  // Category Colors
  static const blue = Color(0xFF5B8DEF);
  static const purple = Color(0xFF9B7AEA);
  static const pink = Color(0xFFE879B9);
  static const orange = Color(0xFFE89B5C);
  static const green = Color(0xFF5ECD97);
  static const cyan = Color(0xFF5BC9D9);
  static const red = Color(0xFFE87979);
  static const teal = Color(0xFF4BC9B0);
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
    return TransitionTheme(
      preset: TransitionPreset.elegant,
      child: MaterialApp(
        title: 'Page Transitions Pro',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: const ColorScheme.dark(
            primary: AppColors.accent,
            secondary: AppColors.accentLight,
            surface: AppColors.surface,
            onSurface: AppColors.textPrimary,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

// ============ Data Models ============
class CategoryData {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final List<TransitionItem> transitions;
  final bool isNew;

  const CategoryData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.transitions,
    this.isNew = false,
  });
}

class TransitionItem {
  final String name;
  final String description;
  final PageRouteBuilder Function(Widget page) route;
  final bool isNew;

  const TransitionItem({
    required this.name,
    required this.description,
    required this.route,
    this.isNew = false,
  });
}

// ============ Home Screen ============
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _fadeController;
  int _selectedPresetIndex = 0;

  final presets = [
    ('Elegant', TransitionPreset.elegant, AppColors.purple),
    ('Playful', TransitionPreset.playful, AppColors.pink),
    ('Professional', TransitionPreset.professional, AppColors.blue),
    ('Gaming', TransitionPreset.gaming, AppColors.red),
    ('Minimal', TransitionPreset.minimal, AppColors.green),
  ];

  final List<CategoryData> categories = [
    // New Categories First
    CategoryData(
      title: 'Hero',
      subtitle: '5 transitions',
      icon: Icons.animation_rounded,
      color: AppColors.accent,
      isNew: true,
      transitions: heroTransitions,
    ),
    CategoryData(
      title: '3D Effects',
      subtitle: '16 transitions',
      icon: Icons.view_in_ar_rounded,
      color: AppColors.red,
      isNew: true,
      transitions: threeDTransitions,
    ),
    // Standard Categories
    CategoryData(
      title: 'Slide',
      subtitle: '9 transitions',
      icon: Icons.swipe_rounded,
      color: AppColors.blue,
      transitions: slideTransitions,
    ),
    CategoryData(
      title: 'Fade',
      subtitle: '8 transitions',
      icon: Icons.blur_on_rounded,
      color: AppColors.purple,
      transitions: fadeTransitions,
    ),
    CategoryData(
      title: 'Scale',
      subtitle: '10 transitions',
      icon: Icons.zoom_out_map_rounded,
      color: AppColors.pink,
      transitions: scaleTransitions,
    ),
    CategoryData(
      title: 'Rotation',
      subtitle: '9 transitions',
      icon: Icons.rotate_right_rounded,
      color: AppColors.orange,
      transitions: rotationTransitions,
    ),
    CategoryData(
      title: 'Physics',
      subtitle: '9 transitions',
      icon: Icons.sports_tennis_rounded,
      color: AppColors.teal,
      transitions: physicsTransitions,
    ),
    CategoryData(
      title: 'iOS Style',
      subtitle: '6 transitions',
      icon: Icons.phone_iphone_rounded,
      color: AppColors.silverDark,
      transitions: iosTransitions,
    ),
    CategoryData(
      title: 'Material',
      subtitle: '5 transitions',
      icon: Icons.android_rounded,
      color: AppColors.green,
      transitions: materialTransitions,
    ),
    CategoryData(
      title: 'Modern UI',
      subtitle: '9 transitions',
      icon: Icons.blur_circular_rounded,
      color: AppColors.cyan,
      transitions: modernTransitions,
    ),
    CategoryData(
      title: 'Size',
      subtitle: '8 transitions',
      icon: Icons.aspect_ratio_rounded,
      color: AppColors.orange,
      transitions: sizeTransitions,
    ),
    CategoryData(
      title: 'Custom',
      subtitle: '10 transitions',
      icon: Icons.auto_awesome_rounded,
      color: AppColors.purple,
      transitions: customTransitions,
    ),
    CategoryData(
      title: 'Social',
      subtitle: '11 transitions',
      icon: Icons.photo_camera_rounded,
      color: AppColors.pink,
      transitions: socialTransitions,
    ),
    CategoryData(
      title: 'Accessibility',
      subtitle: '7 transitions',
      icon: Icons.accessibility_new_rounded,
      color: AppColors.green,
      transitions: accessibilityTransitions,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.backgroundGradientStart,
              AppColors.backgroundGradientEnd,
            ],
          ),
        ),
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Custom App Bar
            _buildSliverAppBar(),

            // Stats Section
            SliverToBoxAdapter(child: _buildStatsSection()),

            // Preset Selector
            SliverToBoxAdapter(child: _buildPresetSection()),

            // Categories Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Row(
                  children: [
                    Container(
                      width: 3,
                      height: 18,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'CATEGORIES',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${categories.length} groups',
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Category Grid
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.4,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _CategoryCard(
                    category: categories[index],
                    index: index,
                    animation: _fadeController,
                  ),
                  childCount: categories.length,
                ),
              ),
            ),

            // Footer
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 140,
      floating: false,
      pinned: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Logo
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.accent.withValues(alpha: 0.2),
                            AppColors.accentGlow.withValues(alpha: 0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.accent.withValues(alpha: 0.3),
                        ),
                      ),
                      child: const Icon(
                        Icons.animation_rounded,
                        color: AppColors.accent,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Page Transitions',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Pro Edition • v1.1.0',
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Settings button
                    _IconButton(
                      icon: Icons.tune_rounded,
                      onTap: () => _showSettingsSheet(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        children: [
          _StatCard(
            icon: Icons.auto_awesome_rounded,
            label: 'Effects',
            value: '110+',
            color: AppColors.accent,
          ),
          const SizedBox(width: 12),
          _StatCard(
            icon: Icons.folder_rounded,
            label: 'Categories',
            value: '14',
            color: AppColors.blue,
          ),
          const SizedBox(width: 12),
          _StatCard(
            icon: Icons.new_releases_rounded,
            label: 'New',
            value: '11',
            color: AppColors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildPresetSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.palette_rounded, size: 16, color: AppColors.textMuted),
              SizedBox(width: 8),
              Text(
                'TRANSITION PRESET',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: presets.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final (name, _, color) = presets[index];
                final isSelected = index == _selectedPresetIndex;
                return GestureDetector(
                  onTap: () => setState(() => _selectedPresetIndex = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? color.withValues(alpha: 0.15)
                          : AppColors.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected
                            ? color.withValues(alpha: 0.5)
                            : AppColors.border,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        name,
                        style: TextStyle(
                          color: isSelected ? color : AppColors.textSecondary,
                          fontSize: 13,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showSettingsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Settings',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            _SettingsTile(
              icon: Icons.speed_rounded,
              title: 'Performance Mode',
              subtitle: 'Enable RepaintBoundary wrappers',
            ),
            _SettingsTile(
              icon: Icons.accessibility_rounded,
              title: 'Reduce Motion',
              subtitle: 'Respect system accessibility settings',
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ============ Components ============

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, color: AppColors.textSecondary, size: 20),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 16),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    label,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 11,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final CategoryData category;
  final int index;
  final Animation<double> animation;

  const _CategoryCard({
    required this.category,
    required this.index,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final delay = index * 0.05;
        final progress = ((animation.value - delay) / (1 - delay)).clamp(
          0.0,
          1.0,
        );

        return Transform.translate(
          offset: Offset(0, 20 * (1 - progress)),
          child: Opacity(opacity: progress, child: child),
        );
      },
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          FadeScalePageTransition(
            page: CategoryDetailScreen(category: category),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: category.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(category.icon, color: category.color, size: 20),
                  ),
                  const Spacer(),
                  if (category.isNew)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.green.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'NEW',
                        style: TextStyle(
                          color: AppColors.green,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                ],
              ),
              const Spacer(),
              Text(
                category.title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                category.subtitle,
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: true,
            onChanged: (_) {},
            activeTrackColor: AppColors.accent,
            thumbColor: WidgetStateProperty.all(Colors.white),
          ),
        ],
      ),
    );
  }
}

// ============ Category Detail Screen ============
class CategoryDetailScreen extends StatelessWidget {
  final CategoryData category;

  const CategoryDetailScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.backgroundGradientStart,
              AppColors.backgroundGradientEnd,
            ],
          ),
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // App Bar
            SliverAppBar(
              expandedHeight: 120,
              floating: false,
              pinned: true,
              backgroundColor: AppColors.background.withValues(alpha: 0.9),
              leading: Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
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
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(60, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: category.color.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: category.color.withValues(alpha: 0.3),
                                ),
                              ),
                              child: Icon(
                                category.icon,
                                color: category.color,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${category.title} Transitions',
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${category.transitions.length} effects available',
                                  style: const TextStyle(
                                    color: AppColors.textMuted,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Transitions List
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _TransitionTile(
                    item: category.transitions[index],
                    index: index,
                    color: category.color,
                  ),
                  childCount: category.transitions.length,
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }
}

class _TransitionTile extends StatelessWidget {
  final TransitionItem item;
  final int index;
  final Color color;

  const _TransitionTile({
    required this.item,
    required this.index,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, item.route(const DemoScreen())),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          item.name,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (item.isNew) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.green.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'NEW',
                            style: TextStyle(
                              color: AppColors.green,
                              fontSize: 8,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.description,
                    style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
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

// ============ Demo Screen ============
class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.backgroundGradientStart,
              AppColors.backgroundGradientEnd,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
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

              // Content
              Expanded(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.border),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accentGlow.withValues(alpha: 0.1),
                          blurRadius: 40,
                          spreadRadius: -10,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Success icon
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.accent.withValues(alpha: 0.2),
                                AppColors.accentGlow.withValues(alpha: 0.1),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            color: AppColors.accent,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Transition Complete',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'The animation was executed successfully',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: AppColors.border,
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Go Back',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
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
      ),
    );
  }
}

// ============ Transition Data ============

// Hero Transitions (NEW)
final heroTransitions = [
  TransitionItem(
    name: 'Hero Slide',
    description: 'Slide with hero coordination',
    route: (page) => HeroSlidePageTransition(page: page),
    isNew: true,
  ),
  TransitionItem(
    name: 'Hero Fade',
    description: 'Fade with optional scale',
    route: (page) => HeroFadePageTransition(page: page),
    isNew: true,
  ),
  TransitionItem(
    name: 'Hero Scale',
    description: 'Scale from alignment point',
    route: (page) => HeroScalePageTransition(page: page),
    isNew: true,
  ),
  TransitionItem(
    name: 'Hero Zoom',
    description: 'Zoom with hero timing',
    route: (page) => HeroZoomPageTransition(page: page),
    isNew: true,
  ),
  TransitionItem(
    name: 'Hero Container',
    description: 'Material container transform',
    route: (page) =>
        HeroContainerTransformTransition(page: page, heroTag: 'demo'),
    isNew: true,
  ),
];

// 3D Transitions (with new additions)
final threeDTransitions = [
  TransitionItem(
    name: 'Cube Horizontal',
    description: '3D cube rotation on Y axis',
    route: (page) => CubeHorizontalPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Cube Vertical',
    description: '3D cube rotation on X axis',
    route: (page) => CubeVerticalPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Inside Cube',
    description: 'View from inside cube',
    route: (page) => InsideCubePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Card Flip',
    description: '3D card flip effect',
    route: (page) => CardFlipPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Carousel',
    description: 'Carousel rotation effect',
    route: (page) => CarouselPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Cover Flow',
    description: 'iTunes cover flow style',
    route: (page) => CoverFlowPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Cylinder Wrap',
    description: 'Cylindrical wrap effect',
    route: (page) => CylinderWrapPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Perspective Zoom',
    description: 'Perspective zoom with depth',
    route: (page) => PerspectiveZoomPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Parallax Depth',
    description: '3D parallax depth effect',
    route: (page) => ParallaxDepthPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Fold',
    description: 'Paper fold effect',
    route: (page) => FoldPageTransition(page: page),
  ),
  // New 3D effects
  TransitionItem(
    name: 'Origami',
    description: 'Paper folding effect',
    route: (page) => OrigamiPageTransition(page: page),
    isNew: true,
  ),
  TransitionItem(
    name: 'Prism',
    description: 'Triangular prism rotation',
    route: (page) => PrismPageTransition(page: page),
    isNew: true,
  ),
  TransitionItem(
    name: 'Sphere',
    description: 'Spherical mapping effect',
    route: (page) => SpherePageTransition(page: page),
    isNew: true,
  ),
  TransitionItem(
    name: 'Z-Stack',
    description: 'Depth stacking effect',
    route: (page) => ZStackPageTransition(page: page),
    isNew: true,
  ),
  TransitionItem(
    name: 'Layered Depth',
    description: 'Multi-layer parallax',
    route: (page) => LayeredDepthPageTransition(page: page),
    isNew: true,
  ),
  TransitionItem(
    name: 'Hologram',
    description: 'Futuristic hologram effect',
    route: (page) => HologramPageTransition(page: page),
    isNew: true,
  ),
];

// Slide Transitions
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
    description: 'Push with previous page moving',
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

// Fade Transitions
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

// Scale Transitions
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
    description: 'Zoom in with fade effect',
    route: (page) => ZoomInFadePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Zoom Out + Fade',
    description: 'Zoom out with fade effect',
    route: (page) => ZoomOutFadePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Pop Scale',
    description: 'Pop effect with elastic',
    route: (page) => PopScalePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Shrink & Grow',
    description: 'Old shrinks, new grows',
    route: (page) => ShrinkGrowPageTransition(page: page),
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

// Rotation Transitions
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
  TransitionItem(
    name: 'Rotation All',
    description: 'Rotation + Scale + Fade',
    route: (page) => RotationScaleFadePageTransition(page: page),
  ),
];

// Physics Transitions
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

// iOS Transitions
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
    description: 'App Store card expansion',
    route: (page) => AppStoreCardPageTransition(page: page),
  ),
];

// Material Transitions
final materialTransitions = [
  TransitionItem(
    name: 'Shared Axis',
    description: 'Material shared axis pattern',
    route: (page) => SharedAxisPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Fade Through Material',
    description: 'Material fade through',
    route: (page) => FadeThroughMaterialPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Container Transform',
    description: 'Container transform pattern',
    route: (page) => ContainerTransformPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Elevation Scale',
    description: 'Elevation with scale',
    route: (page) => ElevationScalePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Material',
    description: 'Standard Material transition',
    route: (page) => MaterialPageTransition(page: page),
  ),
];

// Modern UI Transitions
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
  TransitionItem(
    name: 'Wavy Edge',
    description: 'Wavy edge reveal',
    route: (page) => WavyEdgePageTransition(page: page),
  ),
];

// Size Transitions
final sizeTransitions = [
  TransitionItem(
    name: 'Expand Horizontal',
    description: 'Expands from center horizontally',
    route: (page) => ExpandHorizontalPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Expand Vertical',
    description: 'Expands from center vertically',
    route: (page) => ExpandVerticalPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Expand From Center',
    description: 'Expands from center both axes',
    route: (page) => ExpandFromCenterPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Clip Rect',
    description: 'Clip rect reveal effect',
    route: (page) => ClipRectPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Align Size',
    description: 'Align-based size transition',
    route: (page) => AlignSizePageTransition(page: page),
  ),
  TransitionItem(
    name: 'Split',
    description: 'Split in two and expand',
    route: (page) => SplitPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Unfold',
    description: 'Unfold from center',
    route: (page) => UnfoldPageTransition(page: page),
  ),
  TransitionItem(
    name: 'Size',
    description: 'Size from direction',
    route: (page) => SizePageTransition(page: page),
  ),
];

// Custom Transitions
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
    description: 'Book page flip animation',
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

// Social Transitions
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
    description: 'Spotify cross fade',
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

// Accessibility Transitions
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
