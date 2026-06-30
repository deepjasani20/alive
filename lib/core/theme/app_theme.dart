import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

/// Global Material theme. Most screens style themselves explicitly to match the
/// design, but this provides sensible defaults (colors, font, splash behaviour).
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primaryDark,
      primary: AppColors.primaryDark,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.scaffold,
      textTheme: GoogleFonts.poppinsTextTheme(),
      splashFactory: InkRipple.splashFactory,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
    );
  }
}
