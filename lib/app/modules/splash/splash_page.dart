import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:test_mobile_itae/app/core/values/spaces.dart';
import 'package:test_mobile_itae/app/core/values/text_styles.dart';

import '../../theme/app_colors.dart';
import 'splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        builder: (_) => SafeArea(
              child: Scaffold(
                body: SafeArea(
                    child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          AppColors.primaryColor,
                          AppColors.darkPrimaryColor
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.3, 0.7],
                      )),
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(),
                          SizedBox(height: MySpaces.marginVertical2(context)),
                          Text(
                            '!Hola!',
                            style: MyTextStyles.bigText(context)
                                .copyWith(color: Colors.white),
                          )
                        ],
                      ),
                    )
                  ],
                )),
              ),
            ));
  }
}
