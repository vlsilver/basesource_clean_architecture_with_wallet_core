import 'dart:async';

import 'package:flutter/services.dart';

class WalletCore {
  final MethodChannel _channel = const MethodChannel('wallet_core');

  Future<Map<dynamic, dynamic>> _channelMethod(
      Future<dynamic> Function() method) async {
    try {
      final data = await method() as Map<dynamic, dynamic>;
      final result = _ResultModel.fromMap(data);
      if (result.isSuccess) {
        return result.body;
      } else {
        throw result.code;
      }
    } catch (exp) {
      throw 500;
    }
  }

  Future<Map<dynamic, dynamic>> genNewWallet({
    int strength = 128,
    required String passphrase,
  }) async {
    return await _channelMethod(
        () => _channel.invokeMethod('genNewWallet', [strength, passphrase]));
  }

  Future<Map<dynamic, dynamic>> importNewWalletByMnemonic(
      {required String mnemonic}) async {
    return await _channelMethod(
        () => _channel.invokeMethod('importNewWalletByMnemonic', [mnemonic]));
  }

  Future<Map<dynamic, dynamic>> imporNewWalletByPrivateKey(
      {required String privateKey}) async {
    return await _channelMethod(() =>
        _channel.invokeMethod('imporNewWalletByPrivateKey', [privateKey]));
  }
}

class _ResultModel {
  final int code;
  final dynamic body;
  _ResultModel({
    required this.code,
    required this.body,
  });

  factory _ResultModel.fromMap(Map<dynamic, dynamic> map) {
    return _ResultModel(
      code: map['code'],
      body: map['body'],
    );
  }

  bool get isSuccess => code == 200;
}
