import 'package:basesource/app/domains/setting/setting_use_case.dart';
import 'package:basesource/app/views/splash/splash_controller.dart';
import 'package:get/instance_manager.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController(Get.find<SettingUseCase>()));
  }
}
