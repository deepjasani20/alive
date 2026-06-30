import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../data/models/country_model.dart';
import '../../../data/models/stream_model.dart';
import '../../../widgets/alive_logo.dart';
import '../../../widgets/app_bottom_nav.dart';
import '../../../widgets/stream_card.dart';
import '../viewmodel/home_viewmodel.dart';

/// Pixel-matched Home screen: brand header, Stream/Hot/Follow tabs, region
/// chips, an animated 2-column live-stream grid, and the custom bottom nav.
class HomeView extends GetView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: Obx(
        () => AppBottomNav(
          currentIndex: controller.navIndex.value,
          onTap: controller.selectNav,
          onGoLive: () => _toast('Go Live', 'Start your live stream here.'),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            const _Header(),
            const SizedBox(height: 6),
            _TabBar(controller: controller),
            const SizedBox(height: 14),
            _CountryChips(controller: controller),
            const SizedBox(height: 14),
            Expanded(child: _StreamGridSection(controller: controller)),
          ],
        ),
      ),
    );
  }

  void _toast(String title, String message) => Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
}

/// Brand logo on the left, notification bell + gift on the right.
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Row(
        children: <Widget>[
          const AliveLogo(size: 46),
          const Spacer(),
          const _NotificationBell(count: 3),
          const SizedBox(width: 14),
          _RoundIconButton(
            gradient: const <Color>[
              AppColors.primaryLight,
              AppColors.primaryDark,
            ],
            icon: Icons.shopping_bag_outlined,
            iconColor: AppColors.white,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _NotificationBell extends StatelessWidget {
  const _NotificationBell({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 46,
      height: 46,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.12),
            ),
            child: const Icon(Icons.notifications_none_rounded,
                color: AppColors.primaryDark, size: 24),
          ),
          Positioned(
            right: -2,
            top: -2,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: AppColors.badgeRed,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              child: Text(
                '$count',
                textAlign: TextAlign.center,
                style: AppTextStyles.viewerCount.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.gradient,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  final List<Color> gradient;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.primaryDark.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
    );
  }
}

/// Stream / Hot / Follow segmented text tabs.
class _TabBar extends StatelessWidget {
  const _TabBar({required this.controller});

  final HomeViewModel controller;

  static const List<String> _tabs = <String>[
    AppStrings.tabStream,
    AppStrings.tabHot,
    AppStrings.tabFollow,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Obx(
        () => Row(
          children: List<Widget>.generate(_tabs.length, (int i) {
            final bool active = controller.selectedTab.value == i;
            return Padding(
              padding: const EdgeInsets.only(right: 22),
              child: GestureDetector(
                onTap: () => controller.selectTab(i),
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 250),
                  style: active
                      ? AppTextStyles.tabActive
                      : AppTextStyles.tabInactive,
                  child: Text(_tabs[i]),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

/// Horizontally scrolling region filter chips.
class _CountryChips extends StatelessWidget {
  const _CountryChips({required this.controller});

  final HomeViewModel controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: Obx(
        () => ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: controller.countries.length,
          separatorBuilder: (BuildContext context, int i) =>
              const SizedBox(width: 10),
          itemBuilder: (BuildContext context, int index) {
            final CountryModel country = controller.countries[index];
            final bool selected = controller.selectedCountry.value == index;
            return _Chip(
              country: country,
              selected: selected,
              onTap: () => controller.selectCountry(index),
            );
          },
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.country,
    required this.selected,
    required this.onTap,
  });

  final CountryModel country;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.12)
              : AppColors.fieldFill,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: selected ? AppColors.primary : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(country.flag, style: const TextStyle(fontSize: 15)),
            const SizedBox(width: 6),
            Text(
              country.name,
              style: AppTextStyles.chip.copyWith(
                color: selected
                    ? AppColors.primaryDark
                    : AppColors.textPrimary,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Loading / loaded states for the stream grid, with pull-to-refresh.
class _StreamGridSection extends StatelessWidget {
  const _StreamGridSection({required this.controller});

  final HomeViewModel controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value && controller.streams.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        );
      }
      return RefreshIndicator(
        color: AppColors.primaryDark,
        onRefresh: controller.refreshData,
        child: _AnimatedGrid(streams: controller.streams),
      );
    });
  }
}

/// 2-column grid whose cards cascade in with a fade + slide on first build.
class _AnimatedGrid extends StatefulWidget {
  const _AnimatedGrid({required this.streams});

  final List<StreamModel> streams;

  @override
  State<_AnimatedGrid> createState() => _AnimatedGridState();
}

class _AnimatedGridState extends State<_AnimatedGrid>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Adapt the column count to the available width so cards stay a sensible
    // size from small phones (2 columns) up to tablets (3-5 columns).
    final double width = MediaQuery.sizeOf(context).width;
    final int crossAxisCount = (width / 210).floor().clamp(2, 5);

    return GridView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      itemCount: widget.streams.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (BuildContext context, int index) {
        // Stagger each card's entrance across the controller's timeline.
        final double start = (index * 0.12).clamp(0.0, 0.7);
        final Animation<double> anim = CurvedAnimation(
          parent: _controller,
          curve: Interval(start, (start + 0.4).clamp(0.0, 1.0),
              curve: Curves.easeOutCubic),
        );
        return AnimatedBuilder(
          animation: anim,
          builder: (BuildContext context, Widget? child) {
            return Opacity(
              opacity: anim.value,
              child: Transform.translate(
                offset: Offset(0, 24 * (1 - anim.value)),
                child: child,
              ),
            );
          },
          child: StreamCard(stream: widget.streams[index]),
        );
      },
    );
  }
}
