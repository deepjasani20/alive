import 'package:flutter/material.dart';

/// Centralized color palette for the Alive app.
///
/// Keeping every color in one place guarantees a consistent look across
/// screens and makes future theming / white-labelling trivial.
class AppColors {
  AppColors._();

  // ----- Brand greens -----
  static const Color primary = Color(0xFF7ED321); // vivid lime-green
  static const Color primaryDark = Color(0xFF34A853); // deep grass green
  static const Color primaryLight = Color(0xFFB6F24A); // bright highlight

  /// Gradient used on the brand logo and primary CTAs.
  static const List<Color> primaryGradient = <Color>[
    Color(0xFFB7F33C), // top-left lime
    Color(0xFF36B23E), // bottom-right green
  ];

  /// Gradient used for the login button (left → right).
  static const List<Color> buttonGradient = <Color>[
    Color(0xFFAEE938),
    Color(0xFF2FAE3E),
  ];

  /// Soft green wave that anchors the bottom of the login screen.
  static const List<Color> waveGradient = <Color>[
    Color(0xFF8FE04C),
    Color(0xFF4FC04A),
  ];

  // ----- Neutrals -----
  static const Color background = Color(0xFFFFFFFF);
  static const Color scaffold = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF8A8A8A);
  static const Color hint = Color(0xFFB0B0B0);
  static const Color fieldFill = Color(0xFFF4F5F7);
  static const Color divider = Color(0xFFE6E6E6);

  // ----- Accents -----
  static const Color accentYellow = Color(0xFFF4E400); // "+ Follow" pill
  static const Color badgeRed = Color(0xFFFF3B30);
  static const Color facebookBlue = Color(0xFF1877F2);
  static const Color overlayDark = Color(0x99000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
}
