import 'package:basesource/app/domains/setting/setting_use_case.dart';
import 'package:basesource/app/domains/wallet/entities/wallet_entity.dart';
import 'package:basesource/app/domains/wallet/wallet_use_case.dart';
import 'package:basesource/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

enum UpdateHomePage {
  switchButtonTheme,
  switchButtonLanguage,
  walletInfo,
}

class HomeController extends GetxController {
  HomeController(this._settingUseCase, this._walletUseCase);
  final SettingUseCase _settingUseCase;
  final WalletUseCase _walletUseCase;
  late WalletEntity newWallet;
  bool isCreateNewWallet = false;

  void changeThemeData() async {
    await _settingUseCase.updateThemeApp();
    update([UpdateHomePage.switchButtonTheme]);
    Get.changeTheme(isLightMode ? AppTheme.light : AppTheme.dark);
  }

  void changeLanguageApp() async {
    final _languageCode = _settingUseCase.isVietnamese ? 'en' : 'vi';
    await _settingUseCase.updateLanguageApp(languageCode: _languageCode);
    update([UpdateHomePage.switchButtonLanguage]);
    Get.updateLocale(Locale(languageCode));
  }

  void createNewWallet() async {
    isCreateNewWallet = true;
    update([UpdateHomePage.walletInfo]);
    newWallet = await _walletUseCase.genNewWallet();
    isCreateNewWallet = false;
    update([UpdateHomePage.walletInfo]);
  }

  bool get isLightMode => _settingUseCase.isLightMode;
  String get languageCode => _settingUseCase.languageCode;
  bool get isVietNamese => _settingUseCase.isVietnamese;
}
