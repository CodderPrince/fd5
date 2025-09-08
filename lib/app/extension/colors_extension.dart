// lib/app/extension/colors_extension.dart
import 'package:flutter/material.dart';

import '../colors/app_colors.dart';


extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return AppColors.primaryColor; // Return a default color if parsing fails
  }
}