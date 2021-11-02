import 'package:basesource/app/views/home/home_binding.dart';
import 'package:basesource/app/views/home/home_page.dart';
import 'package:basesource/app/views/inital/initial_error_page.dart';
import 'package:basesource/app/views/splash/splash_binding.dart';
import 'package:basesource/app/views/splash/splash_page.dart';
import 'package:basesource/routes/routes.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.error,
      page: () => const InitialErrorPage(),
    ),
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}

class _AppGetMiddleware<T extends GetxController> extends GetMiddleware {}
