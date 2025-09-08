// lib/features/home/ui/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/shared/data/controllers/actions/jump_action.dart'; // Ensure JumpAction is imported
import '../../../auth/controllers/auth_controller.dart'; // Still potentially needed for drawer logout if re-added
import '../../controllers/home_controller.dart';
import '../widgets/home_drawer.dart';
import '../widgets/hot_recipes_section.dart';
import '../widgets/categories_section.dart';
import '../widgets/recipe_list_section.dart';
import '../widgets/chef_promo_section.dart';
import '../widgets/instagram_feed_section.dart';
import '../widgets/newsletter_signup_section.dart';
import '../widgets/app_footer.dart';


class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Foodieland'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          // Replaced the simple IconButton with a PopupMenuButton
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'create_recipe') {
                JumpAction.toCreateRecipe();
              } else if (value == 'create_blog') {
                JumpAction.toCreateBlogPost();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'create_recipe',
                child: Row(
                  children: const [
                    Icon(Icons.add_circle_outline, color: Colors.black), // Icon for Create Recipe
                    SizedBox(width: 8),
                    Text('Create Recipe'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'create_blog',
                child: Row(
                  children: const [
                    Icon(Icons.edit_note, color: Colors.black), // Icon for Create Blog Post
                    SizedBox(width: 8),
                    Text('Create Blog'), // Text as seen in the image
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: const HomeDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HotRecipesSection(),
            const CategoriesSection(),
            // Simple and tasty recipes section
            RecipeListSection(
              title: 'Simple and tasty recipes',
              description: 'Lorem ipsum dolor sit amet, consectetuipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua enim ad minim.',
              recipes: [
                {'title': 'Big and Juicy Wagyu Beef Cheeseburger', 'time': '30 Minutes', 'tag': 'Snack', 'image': 'assets/images/recipes/burger.png'},
                {'title': 'Fresh Lime Roasted Salmon with Ginger Sauce', 'time': '30 Minutes', 'tag': 'Fish', 'image': 'assets/images/recipes/salmon.png'},
                {'title': 'Strawberry Oatmeal Pancake with Honey Syrup', 'time': '30 Minutes', 'tag': 'Breakfast', 'image': 'assets/images/recipes/pancakes.png'},
              ],
              onViewAllPressed: () {
                // TODO: Implement navigation to a "View All Simple and Tasty Recipes" screen
                // debugPrint('View All Simple and Tasty Recipes tapped!');
              },
            ),
            const SizedBox(height: 20),
            // Chef promo section
            const ChefPromoSection(),
            const SizedBox(height: 20),
            // Instagram feed section
            const InstagramFeedSection(),
            const SizedBox(height: 20),
            // Try this delicious recipe section (reusing RecipeListSection)
            RecipeListSection(
              title: 'Try this delicious recipe',
              description: null, // No description for this section
              recipes: [
                {'title': 'Mixed Tropical Fruit Salad with Superfood Boosts', 'time': '30 Minutes', 'tag': 'Healthy', 'image': 'assets/images/recipes/fruit_salad.png'},
                {'title': 'Big and Juicy Wagyu Beef Cheeseburger', 'time': '30 Minutes', 'tag': 'Western', 'image': 'assets/images/recipes/burger_dark.png'},
              ],
              onViewAllPressed: () {
                // TODO: Implement navigation to a "View All Delicious Recipes" screen
                // debugPrint('View All Delicious Recipes tapped!');
              },
            ),
            const SizedBox(height: 20),
            // Newsletter signup section
            const NewsletterSignupSection(),
            const SizedBox(height: 20),
            // Footer
            const AppFooter(),
            const SizedBox(height: 50), // Final spacing
          ],
        ),
      ),
    );
  }
}