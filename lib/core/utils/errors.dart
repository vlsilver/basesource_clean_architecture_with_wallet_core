import 'package:get/get_utils/src/extensions/internacionalization.dart';

abstract class AppException implements Exception {
  String message;
  int? code;

  AppException({
    required this.message,
    required this.code,
  });
}

class WalletStorageException extends AppException {
  WalletStorageException({
    required String message,
    int? code,
  }) : super(
          message: message,
          code: code,
        );
}

abstract class WalletCoreException extends AppException {
  WalletCoreException({
    required String message,
    int? code,
  }) : super(
          message: message,
          code: code,
        );

  factory WalletCoreException.error(int code) {
    switch (code) {
      case 400:
        return InputValueException('Input invalid'.tr, code);
      case 500:
        return PlatformException('Platform exception'.tr, code);
      default:
        return PlatformException('Platform exception'.tr, code);
    }
  }
}

class InputValueException extends WalletCoreException {
  InputValueException(String message, int code)
      : super(
          message: message,
          code: code,
        );
}

class PlatformException extends WalletCoreException {
  PlatformException(String message, int code)
      : super(
          message: message,
          code: code,
        );
}
