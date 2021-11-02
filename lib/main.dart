import 'package:basesource/app/views/inital/initial_controller.dart';
import 'package:basesource/core/themes/theme.dart';
import 'package:basesource/core/translations/app_translations.dart';
import 'package:basesource/core/utils/dependency.dart';
import 'package:basesource/routes/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);
  await Dependency.init();
  final _initialService = Get.find<InitialController>();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      defaultTransition: Transition.cupertino,
      getPages: AppPages.pages,
      initialRoute: _initialService.firstPage,
      theme: AppTheme.dark,
      locale: _initialService.locale,
    ),
  );
}
