import 'package:basesource/app/domains/wallet/entities/wallet_entity.dart';
import 'package:basesource/app/domains/wallet/entities/wallet_manager_entity.dart';

abstract class WalletRepository {
  Future<WalletManagerEntity> getWalletData({required String key});
  Future<WalletEntity> genNewWallet({required String passphrase});
  Future<WalletEntity> importNewWallet({
    required String value,
    required bool isMnemonic,
  });
}
