import 'package:get/get.dart';
import 'package:test_mobile_itae/app/modules/home/home_binding.dart';
import 'package:test_mobile_itae/app/modules/home/home_page.dart';

import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_page.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.splash,
        page: () => const SplashPage(),
        binding: SplashBinding()),
    GetPage(
        name: AppRoutes.home,
        page: () => const HomePage(),
        binding: HomeBinding()),
    // GetPage(
    //     name: AppRoutes.form,
    //     page: () => const RegisterPage(),
    //     binding: RegisterBinding()),
  ];
}
