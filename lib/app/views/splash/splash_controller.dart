import 'package:basesource/app/domains/setting/setting_use_case.dart';
import 'package:basesource/routes/routes.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class SplashController extends GetxController {
  SplashController(this._settingUseCase);
  final SettingUseCase _settingUseCase;

  void toHomePage() async {
    await _settingUseCase.updateFirtTimeApp();
    Get.offAllNamed(AppRoutes.home);
  }
}
