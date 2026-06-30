import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';

/// The "Alive" brand mark, rendered from the bundled app-icon asset
/// (`assets/images/logo.png`) and clipped to a rounded-square so it stays
/// crisp at any size with a soft brand-coloured shadow.
class AliveLogo extends StatelessWidget {
  const AliveLogo({super.key, this.size = 64});

  /// Side length of the rounded-square badge.
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.28),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.35),
            blurRadius: size * 0.18,
            offset: Offset(0, size * 0.08),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.28),
        child: Image.asset(
          'assets/images/logo.png',
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
