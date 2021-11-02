import 'package:basesource/app/domains/setting/setting_entity.dart';
import 'dart:convert';

class SettingModel extends SettingEntity {
  SettingModel({
    required String languageCode,
    required String biometricType,
    required bool isLightTheme,
    required bool isFirstTime,
  }) : super(
          isLightTheme: isLightTheme,
          isFirstTime: isFirstTime,
          biometricType: biometricType,
          languageCode: languageCode,
        );

  factory SettingModel.fromEntity(SettingEntity entity) {
    return SettingModel(
      languageCode: entity.languageCode,
      biometricType: entity.biometricType,
      isLightTheme: entity.isLightTheme,
      isFirstTime: entity.isFirstTime,
    );
  }

  factory SettingModel.init() {
    return SettingModel(
      languageCode: 'en',
      biometricType: '',
      isLightTheme: true,
      isFirstTime: true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'language': languageCode,
      'isLightTheme': isLightTheme,
      'isFirstTime': isFirstTime,
      'biometricType': biometricType,
    };
  }

  factory SettingModel.fromMap(Map<String, dynamic> map) {
    return SettingModel(
      languageCode: map['language'],
      isLightTheme: map['isLightTheme'],
      isFirstTime: map['isFirstTime'],
      biometricType: map['biometricType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingModel.fromJson(String source) =>
      SettingModel.fromMap(json.decode(source));
}
