import 'package:basesource/app/domains/wallet/entities/wallet_entity.dart';
import 'package:basesource/app/domains/wallet/entities/wallet_manager_entity.dart';
import 'package:basesource/app/domains/wallet/wallet_repo.dart';

class WalletUseCase {
  WalletUseCase(this._repoWallet);
  final WalletRepository _repoWallet;
  late final WalletManagerEntity _walletManagerEntity;

  bool get haveWallet => _walletManagerEntity.wallets.isNotEmpty;

  Future<void> getWalletData() async {
    _walletManagerEntity =
        await _repoWallet.getWalletData(key: WalletManagerEntity.keyStorage);
  }

  Future<WalletEntity> genNewWallet() async {
    return await _repoWallet.genNewWallet(passphrase: "");
  }

  Future<WalletEntity> importNewWallet({
    required bool isMnemonic,
    required String value,
  }) async {
    return await _repoWallet.importNewWallet(
      isMnemonic: isMnemonic,
      value: value,
    );
  }
}
