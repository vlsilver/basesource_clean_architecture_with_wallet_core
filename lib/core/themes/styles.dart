import 'package:flutter/material.dart';

class AppTextStyle {
  static TextStyle button(BuildContext context) =>
      Theme.of(context).textTheme.button!;
  static TextStyle title(BuildContext context) =>
      Theme.of(context).textTheme.headline4!;
  static TextStyle info(BuildContext context) =>
      Theme.of(context).textTheme.bodyText1!;
}
