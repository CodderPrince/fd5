// lib/features/home/ui/widgets/categories_section.dart
import 'package:flutter/material.dart';
import '../../../../app/shared/data/controllers/actions/jump_action.dart'; // Import JumpAction

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Keep the original category data for the home screen section
    // as its appearance is different from the "View All" screen.
    final List<Map<String, dynamic>> categories = [
      {'name': 'Breakfast', 'image': 'assets/images/categories/breakfast.png', 'bgColor': const Color(0xFFFCE4EC)}, // Pale pink
      {'name': 'Vegan', 'image': 'assets/images/categories/vegan.png', 'bgColor': const Color(0xFFE8F5E9)}, // Light green
      {'name': 'Meat', 'image': 'assets/images/categories/meat.png', 'bgColor': const Color(0xFFFFEBEE)}, // Pale red
      {'name': 'Dessert', 'image': 'assets/images/categories/dessert.png', 'bgColor': const Color(0xFFE3F2FD)}, // Light blue
      {'name': 'Lunch', 'image': 'assets/images/categories/lunch.png', 'bgColor': const Color(0xFFFFFDE7)}, // Light yellow
      {'name': 'Chocolate', 'image': 'assets/images/categories/chocolate.png', 'bgColor': const Color(0xFFF3E5F5)}, // Pale purple/pink
    ];

    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                TextButton(
                  onPressed: () {
                    JumpAction.toAllCategories(); // Navigate to the new screen
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 5,
              childAspectRatio: 1.1,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            itemBuilder: (context, index) {
              final category = categories[index];
              return GestureDetector(
                onTap: () {
                  // debugPrint('${category['name']} category tapped!');
                },
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: category['bgColor'] as Color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          category['image'],
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      category['name'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}