import 'package:basesource/app/views/splash/splash_controller.dart';
import 'package:basesource/core/themes/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This is SplashPage'.tr,
              style: AppTextStyle.title(context),
            ),
            CupertinoButton(
              child: Text(
                'Next'.tr,
                style: AppTextStyle.button(context),
              ),
              onPressed: controller.toHomePage,
            )
          ],
        ),
      ),
    );
  }
}
