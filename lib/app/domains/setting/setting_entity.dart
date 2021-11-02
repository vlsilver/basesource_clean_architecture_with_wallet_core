class SettingEntity {
  String languageCode;
  bool isLightTheme;
  bool isFirstTime;
  String biometricType;

  SettingEntity({
    required this.languageCode,
    required this.isLightTheme,
    required this.isFirstTime,
    required this.biometricType,
  });

  static const keyStorage = 'setting app';
}
