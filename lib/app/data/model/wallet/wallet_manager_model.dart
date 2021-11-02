import 'dart:convert';

import 'package:basesource/app/domains/wallet/entities/wallet_manager_entity.dart';

import 'wallet_model.dart';

class WalletManagerModel extends WalletManagerEntity {
  WalletManagerModel({
    required List<WalletModel> wallets,
    required String active,
    required String password,
  }) : super(wallets: wallets, active: active, password: password);

  Map<String, dynamic> toMap() {
    return {
      'wallets': wallets.map((x) => (x as WalletModel).toMap()).toList(),
      'active': active,
      'password': password,
    };
  }

  factory WalletManagerModel.fromMap(Map<String, dynamic> map) {
    return WalletManagerModel(
      wallets: List<WalletModel>.from(
          map['wallets']?.map((x) => WalletModel.fromMap(x))),
      active: map['active'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletManagerModel.fromJson(String source) =>
      WalletManagerModel.fromMap(json.decode(source));
}
