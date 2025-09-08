// lib/features/home/ui/widgets/recipe_list_section.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/data/models/recipe.dart'; // <<< Updated import
import '../../../../app/routes/app_routes.dart';
import '../../../../app/data/recipe_repository.dart';

class RecipeListSection extends StatelessWidget {
  final String title;
  final String? description;
  final List<Map<String, String>> recipes;
  final VoidCallback? onViewAllPressed;

  const RecipeListSection({
    super.key,
    required this.title,
    this.description,
    required this.recipes,
    this.onViewAllPressed,
  });

  // Helper to map simplified titles from the local list to actual Recipe IDs in the repository
  String _getRecipeIdFromTitle(String title) {
    switch (title) {
      case 'Big and Juicy Wagyu Beef Cheeseburger':
        return 'cheeseburger_big';
      case 'Fresh Lime Roasted Salmon with Ginger Sauce':
        return 'roasted_salmon';
      case 'Strawberry Oatmeal Pancake with Honey Syrup':
        return 'pancakes';
      case 'Mixed Tropical Fruit Salad with Superfood Boosts':
        return 'fruit_salad';
      default:
        return 'japanese_fried_rice'; // Fallback or handle appropriately
    }
  }

  @override
  Widget build(BuildContext context) {
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
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                if (onViewAllPressed != null)
                  TextButton(
                    onPressed: onViewAllPressed,
                    child: const Text('View All', style: TextStyle(color: Colors.red)),
                  ),
              ],
            ),
          ),
          if (description != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                description!,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipeMap = recipes[index];
              final String recipeId = _getRecipeIdFromTitle(recipeMap['title']!);
              final Recipe? fullRecipe = RecipeRepository.getRecipeById(recipeId);

              return GestureDetector(
                onTap: () {
                  if (fullRecipe != null) {
                    Get.toNamed(AppRoutes.recipeDetail, arguments: fullRecipe);
                  } else {
                    Get.snackbar('Error', 'Recipe details not found for ${recipeMap['title']!}', snackPosition: SnackPosition.BOTTOM);
                  }
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              recipeMap['image']!,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Icon(Icons.bookmark_border, size: 20, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              recipeMap['title']!,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.timer, size: 16, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(recipeMap['time']!, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                                const SizedBox(width: 16),
                                const Icon(Icons.restaurant_menu, size: 16, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(recipeMap['tag']!, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}