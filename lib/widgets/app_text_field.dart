import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';

/// Labelled, rounded, filled text field matching the login design.
///
/// Supports an optional trailing widget (used for the password visibility eye).
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.suffix,
  });

  final String label;
  final String hint;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: AppTextStyles.fieldLabel),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: AppTextStyles.fieldInput,
          cursorColor: AppColors.primaryDark,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.fieldHint,
            filled: true,
            fillColor: AppColors.fieldFill,
            suffixIcon: suffix,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            border: _border(),
            enabledBorder: _border(),
            focusedBorder: _border(focused: true),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border({bool focused = false}) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: focused
            ? const BorderSide(color: AppColors.primaryDark, width: 1.4)
            : BorderSide.none,
      );
}
