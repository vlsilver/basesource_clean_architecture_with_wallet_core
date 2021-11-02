import 'package:basesource/app/data/model/setting_model.dart';
import 'package:basesource/app/data/provider/get_storage_provider.dart';
import 'package:basesource/app/domains/setting/setting_entity.dart';
import 'package:basesource/app/domains/setting/setting_repo.dart';

class SettingRepositoryImpl implements SettingRepository {
  SettingRepositoryImpl(this._provider);

  final GetStorageProvider _provider;

  @override
  SettingModel getSettingApp({required String key}) {
    try {
      final data = _provider.getData(key: key);
      if (data != null) {
        return SettingModel.fromJson(data);
      } else {
        return SettingModel.init();
      }
    } catch (exp) {
      return SettingModel.init();
    }
  }

  @override
  Future<void> updateSettingApp({
    required String key,
    required SettingEntity entity,
  }) async {
    final settingModel = SettingModel.fromEntity(entity);
    _provider.writeData(key: key, value: settingModel.toJson());
  }
}
