import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class WalletStorageProvider {
  WalletStorageProvider(this._storage);

  final FlutterSecureStorage _storage;

  Future<String?> getData({required String key}) async {
    return await _storage.read(key: key);
  }
}
