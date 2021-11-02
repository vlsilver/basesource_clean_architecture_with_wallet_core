import 'package:basesource/app/views/inital/initial_controller.dart';
import 'package:basesource/core/themes/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class InitialErrorPage extends GetView<InitialController> {
  const InitialErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Get data of Wallet failure'.tr,
              textAlign: TextAlign.center,
              style: AppTextStyle.title(context),
            ),
            IconButton(
              onPressed: controller.loadWalletData,
              icon: GetBuilder<InitialController>(
                id: UpdateInitialErrorPage.iconLoading,
                builder: (_) {
                  return _.error
                      ? const Icon(Icons.replay_rounded)
                      : const CupertinoActivityIndicator();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
