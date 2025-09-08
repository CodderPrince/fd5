// lib/features/home/ui/widgets/home_drawer.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/shared/data/controllers/actions/jump_action.dart';
import '../../../auth/controllers/auth_controller.dart'; // Still needed if logout is used elsewhere

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75, // Adjust drawer width if needed
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Custom Drawer Header Area
          Container(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20), // Adjusted padding
            decoration: const BoxDecoration(
              color: Colors.white, // White background for the header
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(), // Close the drawer
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                          'assets/images/elena_mayer.png'), // Add your user image asset here
                      backgroundColor: Colors.grey, // Fallback color
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Elena Mayer', // Dynamic user name
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => JumpAction.toProfile(), // Navigate to profile
                          child: const Text(
                            'View Profile',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Navigation Links
          const SizedBox(height: 20), // Space after header
          _buildDrawerItem(
            text: 'Home',
            onTap: () => JumpAction.toHome(),
          ),
          _buildDrawerItem(
            text: 'Recipes',
            onTap: () => JumpAction.toAllRecipes(), // Assuming a new route for all recipes
          ),
          _buildDrawerItem(
            text: 'Blog',
            onTap: () => JumpAction.toBlog(),
          ),
          _buildDrawerItem(
            text: 'Contact',
            onTap: () => JumpAction.toContact(), // New route for contact
          ),
          _buildDrawerItem(
            text: 'About Us',
            onTap: () => JumpAction.toAboutUs(), // New route for about us
          ),
          const SizedBox(height: 20), // Space before divider
          const Divider(height: 1, thickness: 1, indent: 20, endIndent: 20), // Divider
          const SizedBox(height: 20), // Space after divider
          // Action Items
          ListTile(
            leading: const Icon(Icons.add_circle_outline, color: Colors.black), // Proper icon for Create Recipe
            title: const Text('Create Recipe', style: TextStyle(fontSize: 16)),
            onTap: () => JumpAction.toCreateRecipe(),
          ),
          ListTile(
            leading: const Icon(Icons.edit_note, color: Colors.black), // Proper icon for Create Blog
            title: const Text('Create Blog', style: TextStyle(fontSize: 16)),
            onTap: () => JumpAction.toCreateBlogPost(),
          ),
          // Removed Logout based on the new image, but keep the AuthController import
          // in case it's used elsewhere or you want to add it back later.
          // ListTile(
          //   leading: const Icon(Icons.logout),
          //   title: const Text('Logout'),
          //   onTap: () => Get.find<AuthController>().logout(),
          // ),
        ],
      ),
    );
  }

  // Helper method to build simple text-only drawer items
  Widget _buildDrawerItem({required String text, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}