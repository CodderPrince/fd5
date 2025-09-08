import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:foodieland/app/routes/app_routes.dart';
import 'package:foodieland/app/theme/app_theme.dart';
import 'blog/controllers/theme_controller.dart';
import 'controllers/app_controller_binder.dart';
// Import ThemeController

class EBuy extends StatelessWidget {
  const EBuy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // Use static theme properties
      darkTheme: AppTheme.darkTheme,
      themeMode: Get.find<ThemeController>().themeMode.value, // Access themeMode from controller
      getPages: AppRoutes.routes,
      initialBinding: AppControllerBinder(),
    );
  }
}