import 'package:get/get.dart';

import '../../../data/models/user_model.dart';
import '../../../data/repositories/stream_repository.dart';
import '../viewmodel/home_viewmodel.dart';

/// Provides the Home screen's dependencies. The signed-in [UserModel] arrives
/// via route arguments from the login flow.
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StreamRepository>(() => StreamRepository());
    final UserModel? user =
        Get.arguments is UserModel ? Get.arguments as UserModel : null;
    Get.lazyPut<HomeViewModel>(
      () => HomeViewModel(Get.find(), user: user),
    );
  }
}
