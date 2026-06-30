import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';

/// The large gradient call-to-action used for "Login".
///
/// Shows a spinner and disables taps while [isLoading] is true.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.height = 58,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: AppColors.buttonGradient,
          ),
          borderRadius: BorderRadius.circular(height / 2),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.45),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.textPrimary),
                ),
              )
            : Text(label, style: AppTextStyles.buttonLarge),
      ),
    );
  }
}
