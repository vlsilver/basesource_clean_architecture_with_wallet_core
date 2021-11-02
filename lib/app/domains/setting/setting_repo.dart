import 'package:basesource/app/domains/setting/setting_entity.dart';

abstract class SettingRepository {
  SettingEntity getSettingApp({required String key});
  Future<void> updateSettingApp({
    required String key,
    required SettingEntity entity,
  });
}
