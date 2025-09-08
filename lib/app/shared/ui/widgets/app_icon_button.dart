// lib/app/shared/ui/widgets/app_icon_button.dart
import 'package:flutter/material.dart';

import '../../../colors/app_colors.dart';


class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const AppIconButton({Key? key, required this.icon, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: AppColors.primaryColor),
      onPressed: onPressed,
    );
  }
}