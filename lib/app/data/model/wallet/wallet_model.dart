import 'dart:convert';

import 'package:basesource/app/domains/wallet/entities/wallet_entity.dart';

class WalletModel extends WalletEntity {
  WalletModel({
    required String address,
    required String privateKey,
    required String mnemonic,
    required String name,
  }) : super(
          address: address,
          privateKey: privateKey,
          mnemonic: mnemonic,
          name: name,
        );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'privateKey': privateKey,
      'mnemonic': mnemonic,
    };
  }

  factory WalletModel.fromMap(Map<dynamic, dynamic> map) {
    return WalletModel(
      name: map['name'] ?? '',
      address: map['address'],
      privateKey: map['privateKey'],
      mnemonic: map['mnemonic'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletModel.fromJson(String source) =>
      WalletModel.fromMap(json.decode(source));
}
