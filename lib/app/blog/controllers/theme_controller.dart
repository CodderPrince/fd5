// lib/app/controllers/theme_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var themeMode = ThemeMode.system.obs; // Start with system theme

  void changeTheme(ThemeMode theme) {
    themeMode.value = theme;
    Get.changeThemeMode(theme); // Update the app's theme
  }

  bool isDarkMode() {
    return themeMode.value == ThemeMode.dark;
  }
}