import 'package:get_storage/get_storage.dart';

class GetStorageProvider {
  final GetStorage _storage = GetStorage();

  String? getData({required String key}) {
    return _storage.read<String>(key);
  }

  Future<void> writeData({
    required String key,
    required String value,
  }) async {
    await _storage.write(key, value);
  }
}
