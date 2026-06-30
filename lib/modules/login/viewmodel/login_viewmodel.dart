import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';

/// Presentation logic for the Login screen.
/// Holds the form controllers and exposes reactive flags the view binds to,
/// keeping the widget tree free of business logic (MVVM).
class LoginViewModel extends GetxController {
  LoginViewModel(this._authRepository);

  final AuthRepository _authRepository;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  /// `true` while the Google credential exchange is in flight.
  final RxBool isGoogleLoading = false.obs;

  /// Whether the password field is currently obscured.
  final RxBool obscurePassword = true.obs;

  void togglePasswordVisibility() =>
      obscurePassword.value = !obscurePassword.value;

  /// Runs the Google sign-in flow and, on success, replaces the stack with Home.
  Future<void> signInWithGoogle() async {
    if (isGoogleLoading.value) return;
    isGoogleLoading.value = true;
    try {
      final UserModel? user = await _authRepository.signInWithGoogle();
      if (user == null) {
        // User cancelled the Google account picker.
        return;
      }
      await Get.offAllNamed<void>(AppRoutes.home, arguments: user);
    } catch (_) {
      _showError('Sign in failed. Please try again.');
    } finally {
      isGoogleLoading.value = false;
    }
  }

  /// Facebook is shown for UI parity with the design but is intentionally not
  /// wired to a provider (the assignment only requires Google auth).
  void signInWithFacebook() {
    Get.snackbar(
      'Coming soon',
      'Facebook login is not part of this assessment.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  void _showError(String message) {
    Get.snackbar(
      'Oops',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.badgeRed,
      colorText: AppColors.white,
      margin: const EdgeInsets.all(16),
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
