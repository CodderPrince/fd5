// lib/app/features/profile/ui/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile_controller.dart'; // Assumed location

class ProfileScreen extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.user.value == null) {
          return Center(child: Text('Could not load profile.'));
        } else {
          final user = controller.user.value!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.avatarUrl),
                  ),
                ),
                SizedBox(height: 16.0),
                Text('Name: ${user.name}'),
                SizedBox(height: 8.0),
                Text('Email: ${user.email}'),
                SizedBox(height: 24.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.logout();
                    },
                    child: Text('Logout'),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}