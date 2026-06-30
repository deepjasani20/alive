import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Typography scale built on Poppins, which closely matches the rounded,
/// friendly type used in the reference design.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle get heading => GoogleFonts.poppins(
        fontSize: 26,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
      );

  static TextStyle get subtitle => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  static TextStyle get fieldLabel => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      );

  static TextStyle get fieldHint => GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColors.hint,
      );

  static TextStyle get fieldInput => GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      );

  static TextStyle get buttonLarge => GoogleFonts.poppins(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get socialButton => GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get link => GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryDark,
      );

  // Home
  static TextStyle get tabActive => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryDark,
      );

  static TextStyle get tabInactive => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      );

  static TextStyle get chip => GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get cardName => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      );

  static TextStyle get viewerCount => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      );

  static TextStyle get followPill => GoogleFonts.poppins(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      );

  static TextStyle get navLabel => GoogleFonts.poppins(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      );
}
