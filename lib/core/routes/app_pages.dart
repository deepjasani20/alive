import 'package:get/get.dart';

import '../../modules/home/binding/home_binding.dart';
import '../../modules/home/view/home_view.dart';
import '../../modules/login/binding/login_binding.dart';
import '../../modules/login/view/login_view.dart';
import '../../modules/splash/binding/splash_binding.dart';
import '../../modules/splash/view/splash_view.dart';
import 'app_routes.dart';

/// GetX page registry. Each page is paired with its binding so the
/// corresponding ViewModel is created lazily only when the route is opened.
class AppPages {
  AppPages._();

  static const String initial = AppRoutes.splash;

  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.fade,
    ),
    GetPage<dynamic>(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 450),
    ),
    GetPage<dynamic>(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 450),
    ),
  ];
}
