import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/app_text_styles.dart';

/// Green gradient bottom navigation with an elevated circular "Go Live" button
/// floating above its centre — matching the Home reference.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.onGoLive,
  });

  /// Selected tab index in the range 0‥3 (centre Go-Live is excluded).
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onGoLive;

  static const List<_NavItem> _leftItems = <_NavItem>[
    _NavItem(Icons.home_rounded, AppStrings.navHome),
    _NavItem(Icons.celebration_outlined, AppStrings.navParty),
  ];

  static const List<_NavItem> _rightItems = <_NavItem>[
    _NavItem(Icons.send_rounded, AppStrings.navChats),
    _NavItem(Icons.person_outline_rounded, AppStrings.navProfile),
  ];

  @override
  Widget build(BuildContext context) {
    // Reserve room for the home-indicator inset so labels never clip.
    final double bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    const double barContentHeight = 64;
    final double barHeight = barContentHeight + bottomInset;

    return SizedBox(
      height: barHeight + 20, // extra space for the elevated Go-Live button
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          // The bar.
          Container(
            height: barHeight,
            padding: EdgeInsets.only(bottom: bottomInset),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xFF8FE04C), Color(0xFF3DB23F)],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
            ),
            child: Row(
              children: <Widget>[
                Expanded(child: _buildItem(0)),
                Expanded(child: _buildItem(1)),
                const Expanded(child: SizedBox()), // centre gap
                Expanded(child: _buildItem(2)),
                Expanded(child: _buildItem(3)),
              ],
            ),
          ),

          // Elevated Go-Live button.
          Positioned(
            top: 0,
            child: _GoLiveButton(onTap: onGoLive),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(int index) {
    final _NavItem item =
        index < 2 ? _leftItems[index] : _rightItems[index - 2];
    final bool selected = currentIndex == index;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            item.icon,
            color: AppColors.white.withValues(alpha: selected ? 1 : 0.85),
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            item.label,
            style: AppTextStyles.navLabel.copyWith(
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: AppColors.white.withValues(alpha: selected ? 1 : 0.85),
            ),
          ),
        ],
      ),
    );
  }
}

class _GoLiveButton extends StatelessWidget {
  const _GoLiveButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppColors.primaryDark.withValues(alpha: 0.35),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.sensors_rounded,
              color: AppColors.primaryDark,
              size: 30,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            AppStrings.navGoLive,
            style: AppTextStyles.navLabel.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.icon, this.label);
  final IconData icon;
  final String label;
}
