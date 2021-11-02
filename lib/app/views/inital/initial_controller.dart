import 'package:basesource/app/domains/setting/setting_use_case.dart';
import 'package:basesource/app/domains/wallet/wallet_use_case.dart';
import 'package:basesource/core/themes/theme.dart';
import 'package:basesource/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

enum UpdateInitialErrorPage {
  iconLoading,
}

class InitialController extends GetxController {
  InitialController(
    this._settingUseCase,
    this._walletUseCase,
  );
  final SettingUseCase _settingUseCase;
  final WalletUseCase _walletUseCase;
  late String firstPage;
  late bool error;

  Locale get locale => Locale(_settingUseCase.languageCode);

  Future<InitialController> init() async {
    try {
      _settingUseCase.getSettingApp();
      await _walletUseCase.getWalletData();
      firstPage = _settingUseCase.isFirstTime || !_walletUseCase.haveWallet
          ? AppRoutes.splash
          : AppRoutes.home;
      return this;
    } catch (exp) {
      error = true;
      firstPage = AppRoutes.error;
      return this;
    }
  }

  ThemeData theme() {
    return _settingUseCase.isLightMode ? AppTheme.light : AppTheme.dark;
  }

  Future<void> loadWalletData() async {
    try {
      error = false;
      update([UpdateInitialErrorPage.iconLoading]);
      await _walletUseCase.getWalletData();
      firstPage =
          _settingUseCase.isFirstTime ? AppRoutes.splash : AppRoutes.home;
      Get.offAllNamed(firstPage);
    } catch (exp) {
      error = true;
      update(([UpdateInitialErrorPage.iconLoading]));
    }
  }
}
