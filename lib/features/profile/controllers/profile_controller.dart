// lib/app/features/profile/controllers/profile_controller.dart
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../app/shared/data/providers/api_providers.dart';
import '../../auth/controllers/auth_controller.dart'; // For logout
import '../data/models/user_model.dart'; // Import UserModel

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var user = Rxn<UserModel>(); // Nullable UserModel
  final ApiProvider apiProvider = ApiProvider();
  final AuthController authController = Get.find<AuthController>(); // Get auth controller

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    isLoading.value = true;
    try {
      // Assuming you have user data in a 'users' table related by user ID.
      final userId = Supabase.instance.client.auth.currentUser!.id;

      final response = await Supabase.instance.client
          .from('users')
          .select()
          .eq('id', userId) // Fetch user data based on user id
          .single();

      // convert response to UserModel
      user.value = UserModel.fromJson(response);

    } catch (e) {
      print('Error loading profile: $e');
      user.value = null;
      Get.snackbar('Error', 'Failed to load profile.');
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    authController.logout(); // Use auth controller's logout
  }
}