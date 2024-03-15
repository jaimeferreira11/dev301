import 'package:get/get.dart';
import 'package:test_mobile_itae/app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();

    _init();
  }

  Future<void> _init() async {
    await Future.delayed(
      const Duration(seconds: 2),
      () => Get.offAndToNamed(AppRoutes.home),
    );
  }
}
