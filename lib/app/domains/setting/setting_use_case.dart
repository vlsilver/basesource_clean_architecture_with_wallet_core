import 'package:basesource/app/domains/setting/setting_entity.dart';
import 'package:basesource/app/domains/setting/setting_repo.dart';

class SettingUseCase {
  SettingUseCase(this._settingRepo);

  final SettingRepository _settingRepo;

  late final SettingEntity _settingEntity;

  bool get isLightMode => _settingEntity.isLightTheme;
  String get languageCode => _settingEntity.languageCode;
  bool get isFirstTime => _settingEntity.isFirstTime;
  bool get isVietnamese => languageCode == 'vi';

  void getSettingApp() {
    _settingEntity = _settingRepo.getSettingApp(key: SettingEntity.keyStorage);
  }

  Future<void> updateFirtTimeApp() async {
    _settingEntity.isFirstTime = false;
    await _settingRepo.updateSettingApp(
      key: SettingEntity.keyStorage,
      entity: _settingEntity,
    );
  }

  Future<void> updateThemeApp() async {
    _settingEntity.isLightTheme = !_settingEntity.isLightTheme;
    await _settingRepo.updateSettingApp(
      key: SettingEntity.keyStorage,
      entity: _settingEntity,
    );
  }

  Future<void> updateLanguageApp({required String languageCode}) async {
    _settingEntity.languageCode = languageCode;
    await _settingRepo.updateSettingApp(
      key: SettingEntity.keyStorage,
      entity: _settingEntity,
    );
  }
}
