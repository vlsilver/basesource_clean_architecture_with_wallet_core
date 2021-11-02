import 'package:basesource/app/data/model/wallet/wallet_manager_model.dart';
import 'package:basesource/app/data/model/wallet/wallet_model.dart';
import 'package:basesource/app/data/provider/bsc_provider.dart';
import 'package:basesource/app/data/provider/wallet_core_provider.dart';
import 'package:basesource/app/data/provider/wallet_storage_provider.dart';
import 'package:basesource/app/domains/wallet/wallet_repo.dart';
import 'package:basesource/core/utils/errors.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class WalletRepositoryImpl implements WalletRepository {
  WalletRepositoryImpl(
    this._walletCoreProvider,
    this._walletStorageProvider,
    this._bscProvider,
  );

  final WalletCoreProvider _walletCoreProvider;
  final WalletStorageProvider _walletStorageProvider;
  final BscProvider _bscProvider;

  @override
  Future<WalletManagerModel> getWalletData({required String key}) async {
    try {
      final data = await _walletStorageProvider.getData(key: key);
      if (data != null) {
        return WalletManagerModel.fromJson(data);
      } else {
        return WalletManagerModel(
          wallets: [],
          active: '',
          password: '',
        );
      }
    } catch (exp) {
      throw WalletStorageException(message: 'Get data of Wallet failure'.tr);
    }
  }

  @override
  Future<WalletModel> genNewWallet({required String passphrase}) async {
    try {
      final data =
          await _walletCoreProvider.genNewWallet(passphrase: passphrase);
      return WalletModel.fromMap(data);
    } catch (exp) {
      throw WalletCoreException.error(exp as int);
    }
  }

  @override
  Future<WalletModel> importNewWallet({
    required String value,
    required isMnemonic,
  }) async {
    try {
      late final Map<dynamic, dynamic> data;
      if (isMnemonic) {
        data = await _walletCoreProvider.importNewWalletByMnemonic(
            mnemonic: value);
      } else {
        data = await _walletCoreProvider.imporNewWalletByPrivateKey(
            privateKey: value);
      }
      return WalletModel.fromMap(data);
    } catch (exp) {
      throw WalletCoreException.error(exp as int);
    }
  }
}
