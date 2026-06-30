import 'dart:async';

import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../../data/repositories/auth_repository.dart';

/// Drives the Splash screen: waits for the intro animation to play, then
/// routes the user to Home (if a session already exists) or Login.
class SplashViewModel extends GetxController {
  SplashViewModel(this._authRepository);

  final AuthRepository _authRepository;

  /// How long the splash stays on screen before navigating.
  static const Duration _displayDuration = Duration(milliseconds: 2600);

  @override
  void onReady() {
    super.onReady();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await Future<void>.delayed(_displayDuration);
    await _authRepository.signOut();

    final String target = _authRepository.isLoggedIn
        ? AppRoutes.home
        : AppRoutes.login;
    await Get.offAllNamed<void>(target);
  }
}
