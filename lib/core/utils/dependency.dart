import 'package:basesource/app/data/provider/bsc_provider.dart';
import 'package:basesource/app/data/provider/get_storage_provider.dart';
import 'package:basesource/app/data/provider/wallet_core_provider.dart';
import 'package:basesource/app/data/provider/wallet_storage_provider.dart';
import 'package:basesource/app/data/repository_impl/setting_repo_impl.dart';
import 'package:basesource/app/data/repository_impl/wallet_repo_impl.dart';
import 'package:basesource/app/domains/setting/setting_use_case.dart';
import 'package:basesource/app/domains/wallet/wallet_use_case.dart';

import 'package:basesource/app/views/inital/initial_controller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Dependency {
  static init() async {
    // wallet manager dependency
    Get.lazyPut(() => WalletStorageProvider(const FlutterSecureStorage()));
    Get.lazyPut(() => WalletCoreProvider());
    Get.lazyPut(() => BscProvider());
    Get.lazyPut(
      () => WalletRepositoryImpl(
        Get.find<WalletCoreProvider>(),
        Get.find<WalletStorageProvider>(),
        Get.find<BscProvider>(),
      ),
    );
    Get.lazyPut(() => WalletUseCase(Get.find<WalletRepositoryImpl>()));

    //setting App dependency
    await GetStorage.init();
    Get.lazyPut(() => GetStorageProvider());
    Get.lazyPut<SettingRepositoryImpl>(
        () => SettingRepositoryImpl(Get.find<GetStorageProvider>()));
    Get.lazyPut<SettingUseCase>(
        () => SettingUseCase(Get.find<SettingRepositoryImpl>()));
    await Get.putAsync<InitialController>(() => InitialController(
          Get.find<SettingUseCase>(),
          Get.find<WalletUseCase>(),
        ).init());
  }
}
