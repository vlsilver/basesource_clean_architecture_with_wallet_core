import 'package:basesource/app/domains/wallet/entities/wallet_entity.dart';

class WalletManagerEntity {
  List<WalletEntity> wallets;
  String active;
  String password;
  WalletManagerEntity({
    required this.wallets,
    required this.active,
    required this.password,
  });

  static const keyStorage = 'wallet data';
}
