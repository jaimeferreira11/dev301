import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/app_colors.dart';

class CustomProgress extends StatelessWidget {
  final RxBool isLoading;

  const CustomProgress({Key? key, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (isLoading.value) {
          return Container(
            height: double.infinity,
            color: Colors.black26,
            child: const Center(
                child: CircularProgressIndicator(
              color: AppColors.accentColor,
            )),
          );
        }
        return Container();
      },
    );
  }
}
