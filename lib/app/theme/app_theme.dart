// lib/app/theme/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    primaryColor: Colors.blue,
    brightness: Brightness.light, // Set overall brightness to light
    // Add other light theme properties
  );

  static ThemeData get darkTheme => ThemeData(
    primaryColor: Colors.deepPurple,
    brightness: Brightness.dark, // Set overall brightness to dark
    // Add other dark theme properties
  );
}