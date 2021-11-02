import 'package:basesource/core/values/strings.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    fontFamily: AppStrings.font,
    brightness: Brightness.light,
  );
  static final ThemeData dark = ThemeData(
    fontFamily: AppStrings.font,
    brightness: Brightness.dark,
  );
}
