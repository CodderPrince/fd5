// lib/features/recipe/ui/screens/recipe_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// REMOVED: import '../../../../app/product/data/models/product_size_model.dart'; // Assuming this is not used here
import '../../../../app/data/models/recipe.dart';
import '../../../../app/routes/app_routes.dart';
import '../../../../app/data/recipe_repository.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe; // Type is now 'Recipe'

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Ingredient> _ingredients;
  late List<Recipe> _otherRecipes; // Type is now 'List<Recipe>'

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Accessing fields that *should* be on the Recipe class now
    _ingredients = widget.recipe.ingredients.map((item) => item.copyWith()).toList();
    _otherRecipes = RecipeRepository.getOtherRecipes(widget.recipe.id, count: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Accessing fields that *should* be on the Recipe class now
    final double estimatedIngredientsHeight = _ingredients.length * kMinInteractiveDimension;
    final double estimatedDirectionsHeight = widget.recipe.directions.length * kMinInteractiveDimension * 1.5;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Recipe',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {
              // TODO: Implement more options
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: Image.asset(
                    widget.recipe.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    // FIX: 'withOpacity' is deprecated. Using withAlpha for clarity.
                    color: Colors.white.withAlpha((255 * 0.8).round()),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.play_arrow, size: 40, color: Colors.black),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.recipe.name, // Use widget.recipe.name
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'By ${widget.recipe.authorName}', // Use widget.recipe.authorName
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInfoChip(Icons.timer, widget.recipe.cookingTime),
                      _buildInfoChip(Icons.local_fire_department, widget.recipe.calories),
                      _buildInfoChip(Icons.restaurant_menu, widget.recipe.categoryName), // Use widget.recipe.categoryName
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[300]!, width: 1),
                      ),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      labelColor: Colors.green,
                      unselectedLabelColor: Colors.black,
                      indicatorColor: Colors.green,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      tabs: const [
                        Tab(text: 'Ingredients'),
                        Tab(text: 'Directions'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: estimatedIngredientsHeight > estimatedDirectionsHeight
                        ? estimatedIngredientsHeight + 20
                        : estimatedDirectionsHeight + 20,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        ListView.builder(
                          itemCount: _ingredients.length,
                          itemBuilder: (context, index) {
                            final ingredient = _ingredients[index];
                            return ListTile(
                              leading: Checkbox(
                                value: ingredient.checked,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    ingredient.checked = newValue!;
                                  });
                                },
                                activeColor: Colors.green,
                                shape: const CircleBorder(),
                              ),
                              title: Text(
                                ingredient.name,
                                style: TextStyle(
                                  decoration: ingredient.checked ? TextDecoration.lineThrough : TextDecoration.none,
                                  color: ingredient.checked ? Colors.grey : Colors.black,
                                ),
                              ),
                              trailing: Text(ingredient.quantity),
                            );
                          },
                        ),
                        ListView.builder(
                          itemCount: widget.recipe.directions.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.green,
                                    child: Text(
                                      '${index + 1}',
                                      style: const TextStyle(color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      widget.recipe.directions[index],
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Other Recipes',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _otherRecipes.length,
                      itemBuilder: (context, index) {
                        final otherRecipe = _otherRecipes[index];
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.recipeDetail, arguments: otherRecipe, preventDuplicates: false);
                          },
                          child: Container(
                            width: 150,
                            margin: const EdgeInsets.only(right: 15),
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                                    child: Image.asset(
                                      otherRecipe.imageUrl,
                                      height: 100,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          otherRecipe.name,
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'By ${otherRecipe.authorName}',
                                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(color: Colors.black, fontSize: 14)),
      ],
    );
  }
}