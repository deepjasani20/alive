import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_text_styles.dart';

/// White rounded "Continue with …" button used for the social providers.
///
/// [icon] is supplied by the caller so the same widget renders the Google and
/// Facebook variants. Shows an inline spinner while [isLoading] is true.
class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.isLoading = false,
    this.height = 56,
  });

  final String label;
  final Widget icon;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(height / 2),
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(height / 2),
        child: Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(height / 2),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.08),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.4,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.primaryDark),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    icon,
                    const SizedBox(width: 12),
                    Text(label, style: AppTextStyles.socialButton),
                  ],
                ),
        ),
      ),
    );
  }
}
