import 'package:get/get.dart';

import '../../../data/repositories/auth_repository.dart';
import '../viewmodel/splash_viewmodel.dart';

/// Wires up the dependencies needed by the Splash screen.
class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // Shared across the app's auth flow.
    Get.lazyPut<AuthRepository>(() => AuthRepository(), fenix: true);
    Get.lazyPut<SplashViewModel>(() => SplashViewModel(Get.find()));
  }
}
