// lib/app/middleware/auth_middleware.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../features/auth/controllers/auth_controller.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();

    print('AuthMiddleware - Route: $route, isLoggedIn: ${authController.isLoggedIn.value}');

    if (!authController.isLoggedIn.value) {
      // Allow signup and login without redirect
      if (route == '/login' || route == '/signup') {
        return null;
      }
      return const RouteSettings(name: '/login');
    }

    // If logged in, prevent going back to login/signup
    if (authController.isLoggedIn.value && (route == '/login' || route == '/signup')) {
      return const RouteSettings(name: '/home');
    }

    return null; // Continue normally
  }
}
