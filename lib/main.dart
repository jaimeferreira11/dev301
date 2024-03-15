import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_mobile_itae/app/modules/splash/splash_binding.dart';
import 'package:test_mobile_itae/app/modules/splash/splash_page.dart';
import 'package:test_mobile_itae/app/routes/app_pages.dart';
import 'package:test_mobile_itae/app/theme/theme.dart';

import 'app/core/config/bindings/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependecyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Lista de tareas - Itae',
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
      getPages: AppPages.pages,
      theme: MyTheme.buildDefaultTheme(),
      initialBinding: SplashBinding(),
    );
  }
}
