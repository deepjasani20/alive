import 'package:get/get.dart';

import '../../../data/repositories/auth_repository.dart';
import '../viewmodel/login_viewmodel.dart';

/// Provides the [LoginViewModel] (and ensures an [AuthRepository] exists) when
/// the Login route is opened.
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<AuthRepository>()) {
      Get.lazyPut<AuthRepository>(() => AuthRepository(), fenix: true);
    }
    Get.lazyPut<LoginViewModel>(() => LoginViewModel(Get.find()));
  }
}
