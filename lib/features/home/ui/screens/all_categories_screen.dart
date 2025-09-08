// lib/features/home/ui/screens/all_categories_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define categories specifically for this screen,
    // matching the images and names from the new design.
    // Ensure these image assets exist in your project, e.g., assets/images/all_categories/pasta.png
    final List<Map<String, String>> allCategories = [
      {'name': 'Pasta', 'image': 'assets/images/all_categories/pasta.png'},
      {'name': 'Salads', 'image': 'assets/images/all_categories/salads.png'},
      {'name': 'Soups', 'image': 'assets/images/all_categories/soups.png'},
      {'name': 'Desserts', 'image': 'assets/images/all_categories/desserts.png'},
      {'name': 'Breakfast', 'image': 'assets/images/all_categories/breakfast.png'},
      {'name': 'Drinks', 'image': 'assets/images/all_categories/drinks.png'},
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(), // Go back to the previous screen
        ),
        title: const Text('Categories'),
        centerTitle: true, // Center the title as per the image
        backgroundColor: Colors.white, // White AppBar background
        foregroundColor: Colors.black, // Black icon and text color
        elevation: 0, // No shadow for AppBar
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0), // Padding around the grid
        itemCount: allCategories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two columns as per the image
          crossAxisSpacing: 16.0, // Horizontal space between cards
          mainAxisSpacing: 16.0, // Vertical space between cards
          childAspectRatio: 1.8, // Adjust aspect ratio to fit image and text side-by-side
        ),
        itemBuilder: (context, index) {
          final category = allCategories[index];
          return Card(
            elevation: 2, // Slight shadow for the card
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners for the card
            ),
            child: InkWell( // Use InkWell for tap effect
              onTap: () {
                // TODO: Implement action when a category card is tapped
                // debugPrint('Tapped on ${category['name']}');
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8), // Slightly rounded image corners
                      child: Image.asset(
                        category['image']!,
                        width: 60, // Fixed width for the image
                        height: 60, // Fixed height for the image
                        fit: BoxFit.cover, // Fill the image container
                      ),
                    ),
                    const SizedBox(width: 10), // Space between image and text
                    Expanded(
                      child: Text(
                        category['name']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1, // Prevent text from wrapping too much
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}