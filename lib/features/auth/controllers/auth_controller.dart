// lib/app/features/auth/controllers/auth_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final signupEmailController = TextEditingController(); // Signup
  final signupPasswordController = TextEditingController(); // Signup
  final confirmPasswordController = TextEditingController(); // Signup
  final supabase = Supabase.instance.client;
  var isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Check if the user is already logged in
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    final session = supabase.auth.currentSession;
    print('AuthController.checkAuthStatus - isLoggedIn: ${isLoggedIn.value}');
    if (session != null) {
      print('AuthController.checkAuthStatus - Session found');
      isLoggedIn.value = true;
    } else {
      isLoggedIn.value = false;
    }
  }


  Future<void> login() async {
    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      if (email.isEmpty || password.isEmpty) {
        Get.snackbar('Error', 'Please enter email and password');
        return;
      }

      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.session != null) {
        isLoggedIn.value = true;
        Get.offAllNamed('/home');
      } else {
        Get.snackbar('Login Failed', 'Invalid credentials');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred during login: $e');
    }
  }

  Future<void> signup() async {
    try {
      final email = signupEmailController.text.trim();
      final password = signupPasswordController.text.trim();
      final confirmPassword = confirmPasswordController.text.trim();

      if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
        Get.snackbar('Error', 'Please fill all fields');
        return;
      }

      if (password != confirmPassword) {
        Get.snackbar('Error', 'Passwords do not match');
        return;
      }

      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.session != null) {
        isLoggedIn.value = true;
        Get.offAllNamed('/home');
      } else {
        Get.snackbar('Signup Failed', 'Could not create account');
      }
    } catch (e) {
      if (e is AuthException) {
        Get.snackbar('Error', 'An error occurred during signup: ${e.message}');
      } else {
        Get.snackbar('Error', 'An unexpected error occurred during signup');
      }
    }
  }

  Future<void> logout() async {
    try {
      await supabase.auth.signOut();
      isLoggedIn.value = false;
      Get.offAllNamed('/login');
    } catch (error) {
      Get.snackbar('Error', 'An error occurred during logout: $error');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    signupEmailController.dispose(); // Signup
    signupPasswordController.dispose(); // Signup
    confirmPasswordController.dispose(); // Signup
    super.onClose();
  }
}