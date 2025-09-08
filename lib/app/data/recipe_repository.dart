// lib/app/data/recipe_repository.dart
import 'package:foodieland/app/data/models/recipe.dart'; // <<< This is the ONLY correct import for your Recipe model
import 'package:get/get.dart';

// DELETE THESE INCORRECT IMPORTS that are causing the conflict:
// import '../product/data/models/product_size_model.dart';
// import 'models/recipe.dart'; // This line is redundant and should be removed.


class RecipeRepository {
  static final List<Recipe> _allRecipes = [
    // --- Detailed Recipe: Health Japanese Fried Rice ---
    Recipe(
      id: 'japanese_fried_rice',
      name: 'Health Japanese Fried Rice',
      // ADDED description parameter:
      description: 'A comprehensive guide to preparing a healthy and delicious Japanese-style fried rice with chicken and a mix of fresh vegetables.',
      authorName: 'Angelia Joli',
      authorAvatarUrl: 'assets/images/elena_mayer.png',
      imageUrl: 'assets/images/recipe_detail/fried_rice.png',
      cookingTime: '15 min',
      calories: '210 Kcal',
      categoryName: 'Dinner',
      categoryId: 1,
      shortDescription: 'A light and savory Japanese-style fried rice with chicken and vegetables.',
      ingredients: [
        Ingredient(name: 'Cooked Rice', quantity: '2 cups', checked: true),
        Ingredient(name: 'Chicken Breast', quantity: '200 g'),
        Ingredient(name: 'Mixed Vegetables', quantity: '1 cup'),
        Ingredient(name: 'Egg', quantity: '1'),
        Ingredient(name: 'Soy Sauce', quantity: '2 tbsp'),
        Ingredient(name: 'Oyster Sauce', quantity: '1 tbsp'),
        Ingredient(name: 'Garlic', quantity: '2 cloves'),
        Ingredient(name: 'Ginger', quantity: '2 slices'),
      ],
      directions: [
        'Step 1: Prepare all ingredients. Heat oil in a pan over medium heat.',
        'Step 2: Add garlic and ginger, cook until fragrant.',
        'Step 3: Add chicken and cook until no longer pink. Add vegetables and stir-fry for 3-5 minutes.',
        'Step 4: Push ingredients to one side, pour beaten egg into the empty side. Scramble and mix with other ingredients.',
        'Step 5: Add cooked rice, soy sauce, and oyster sauce. Stir-fry until everything is well combined and heated through.',
        'Step 6: Serve hot, garnished with green onions.'
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),

    // --- Detailed Recipe: The Creamiest Creamy Chicken and Pasta ---
    Recipe(
      id: 'creamy_chicken_pasta',
      name: 'The Creamiest Creamy Chicken and Pasta',
      // ADDED description parameter:
      description: 'Indulge in this rich and decadent chicken pasta, featuring tender chicken pieces in a creamy, cheesy sauce, perfect for a cozy evening meal.',
      authorName: 'Andreas Paula',
      authorAvatarUrl: 'assets/images/elena_mayer.png',
      imageUrl: 'assets/images/recipe_detail/creamy_chicken.png',
      cookingTime: '45 min',
      calories: '500 Kcal',
      categoryName: 'Dinner',
      categoryId: 2,
      shortDescription: 'Rich and decadent chicken pasta that\'s perfect for a cozy evening.',
      ingredients: [
        Ingredient(name: 'Chicken Fillet', quantity: '2'),
        Ingredient(name: 'Heavy Cream', quantity: '1 cup'),
        Ingredient(name: 'Parmesan Cheese', quantity: '1/2 cup'),
        Ingredient(name: 'Fettuccine Pasta', quantity: '300g'),
        Ingredient(name: 'Garlic', quantity: '3 cloves'),
        Ingredient(name: 'Spinach', quantity: '1 cup'),
        Ingredient(name: 'Olive Oil', quantity: '2 tbsp'),
      ],
      directions: [
        'Step 1: Cook pasta according to package directions. Drain and set aside.',
        'Step 2: Slice chicken fillets into bite-sized pieces. Season with salt and pepper.',
        'Step 3: Heat olive oil in a large skillet over medium-high heat. Add chicken and cook until browned and cooked through. Remove chicken and set aside.',
        'Step 4: Add minced garlic to the skillet and sauté for 1 minute until fragrant.',
        'Step 5: Pour in heavy cream and bring to a simmer. Stir in Parmesan cheese until melted and smooth.',
        'Step 6: Return chicken to the skillet. Add spinach and cook until wilted. Toss with cooked pasta.',
        'Step 7: Serve immediately, garnished with extra Parmesan if desired.'
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),

    // --- Detailed Recipe: Avocado Toast ---
    Recipe(
      id: 'avocado_toast',
      name: 'Avocado Toast',
      // ADDED description parameter:
      description: 'A classic healthy breakfast or snack. Enjoy perfectly mashed avocado on toasted bread, seasoned to perfection.',
      authorName: 'Chef Foodie',
      authorAvatarUrl: 'assets/images/elena_mayer.png',
      imageUrl: 'assets/images/recipes_list/avocado_toast.png',
      cookingTime: '5 min',
      calories: '250 Kcal',
      categoryName: 'Breakfast',
      categoryId: 3,
      shortDescription: 'A simple yet delicious and healthy breakfast option.',
      ingredients: [
        Ingredient(name: 'Bread Slice', quantity: '1'),
        Ingredient(name: 'Avocado', quantity: '1/2'),
        Ingredient(name: 'Salt', quantity: 'pinch'),
        Ingredient(name: 'Black Pepper', quantity: 'pinch'),
        Ingredient(name: 'Chili Flakes', quantity: 'optional'),
      ],
      directions: [
        'Step 1: Toast the bread slice to your liking.',
        'Step 2: Mash the avocado with a fork in a small bowl. Season with salt and pepper.',
        'Step 3: Spread the mashed avocado evenly over the toasted bread.',
        'Step 4: Sprinkle with chili flakes if desired. Serve immediately.'
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),

    // --- Detailed Recipe: Scrambled Eggs ---
    Recipe(
      id: 'scrambled_eggs',
      name: 'Scrambled Eggs',
      // ADDED description parameter:
      description: 'Learn how to make perfect, fluffy scrambled eggs every time with this quick and easy recipe.',
      authorName: 'Chef Foodie',
      authorAvatarUrl: 'assets/images/elena_mayer.png',
      imageUrl: 'assets/images/recipes_list/scrambled_eggs.png',
      cookingTime: '10 min',
      calories: '200 Kcal',
      categoryName: 'Breakfast',
      categoryId: 3,
      shortDescription: 'Classic fluffy scrambled eggs for a quick meal.',
      ingredients: [
        Ingredient(name: 'Eggs', quantity: '2'),
        Ingredient(name: 'Milk or Cream', quantity: '1 tbsp'),
        Ingredient(name: 'Butter', quantity: '1 tsp'),
        Ingredient(name: 'Salt', quantity: 'to taste'),
        Ingredient(name: 'Pepper', quantity: 'to taste'),
      ],
      directions: [
        'Step 1: Crack eggs into a bowl, add milk/cream, salt, and pepper. Whisk gently until just combined (don\'t over-whisk).',
        'Step 2: Melt butter in a non-stick skillet over medium-low heat.',
        'Step 3: Pour in the egg mixture. Let it sit for about 30 seconds without stirring until the edges start to set.',
        'Step 4: Gently push the cooked edges towards the center with a spatula, tilting the pan to allow uncooked egg to flow underneath.',
        'Step 5: Continue cooking and folding until the eggs are mostly set but still slightly moist. Do not overcook.',
        'Step 6: Serve immediately.'
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),

    // --- Detailed Recipe: Fluffy Pancakes ---
    Recipe(
      id: 'pancakes',
      name: 'Fluffy Pancakes',
      // ADDED description parameter:
      description: 'Master the art of making light and airy fluffy pancakes, a delightful treat for breakfast or brunch, served with your favorite toppings.',
      authorName: 'Chef Foodie',
      authorAvatarUrl: 'assets/images/elena_mayer.png',
      imageUrl: 'assets/images/recipes_list/pancakes_list.png',
      cookingTime: '20 min',
      calories: '300 Kcal',
      categoryName: 'Breakfast',
      categoryId: 3,
      shortDescription: 'Perfectly fluffy pancakes, great for a weekend treat.',
      ingredients: [
        Ingredient(name: 'All-Purpose Flour', quantity: '1 cup'),
        Ingredient(name: 'Baking Powder', quantity: '2 tsp'),
        Ingredient(name: 'Sugar', quantity: '2 tbsp'),
        Ingredient(name: 'Salt', quantity: '1/2 tsp'),
        Ingredient(name: 'Egg', quantity: '1'),
        Ingredient(name: 'Milk', quantity: '1 cup'),
        Ingredient(name: 'Melted Butter', quantity: '2 tbsp'),
      ],
      directions: [
        'Step 1: In a large bowl, whisk together flour, baking powder, sugar, and salt.',
        'Step 2: In a separate bowl, whisk together egg, milk, and melted butter.',
        'Step 3: Pour the wet ingredients into the dry ingredients and mix until just combined. Don\'t overmix; a few lumps are fine.',
        'Step 4: Heat a lightly oiled griddle or frying pan over medium heat. Pour about 1/4 cup of batter per pancake.',
        'Step 5: Cook for 2-3 minutes per side, or until golden brown and bubbles appear on the surface.',
        'Step 6: Serve hot with your favorite toppings like syrup and berries.'
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),

    // --- Detailed Recipe: Big and Juicy Wagyu Beef Cheeseburger (for home screen list) ---
    Recipe(
      id: 'cheeseburger_big',
      name: 'Big and Juicy Wagyu Beef Cheeseburger',
      // ADDED description parameter:
      description: 'Experience the ultimate gourmet burger with a succulent Wagyu beef patty, melted cheese, and fresh toppings all nestled in a brioche bun.',
      authorName: 'Chef Foodie',
      authorAvatarUrl: 'assets/images/elena_mayer.png',
      imageUrl: 'assets/images/recipes/burger_dark.png',
      cookingTime: '30 Minutes',
      calories: '750 Kcal',
      categoryName: 'Western',
      categoryId: 4,
      shortDescription: 'An ultimate classic with premium wagyu beef.',
      ingredients: [
        Ingredient(name: 'Wagyu Beef Patty', quantity: '1'),
        Ingredient(name: 'Brioche Bun', quantity: '1'),
        Ingredient(name: 'Cheddar Cheese', quantity: '1 slice'),
        Ingredient(name: 'Lettuce', quantity: '2 leaves'),
        Ingredient(name: 'Tomato', quantity: '2 slices'),
        Ingredient(name: 'Red Onion', quantity: 'thinly sliced'),
        Ingredient(name: 'Pickles', quantity: '3 slices'),
        Ingredient(name: 'Burger Sauce', quantity: '2 tbsp'),
      ],
      directions: [
        'Step 1: Toast the brioche bun lightly.',
        'Step 2: Cook the wagyu beef patty to your desired doneness, topping with cheese in the last minute to melt.',
        'Step 3: Assemble the burger: bottom bun, sauce, lettuce, tomato, patty with cheese, red onion, pickles, top bun.'
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
    ),

    // --- Detailed Recipe: Fresh Lime Roasted Salmon with Ginger Sauce ---
    Recipe(
      id: 'roasted_salmon',
      name: 'Fresh Lime Roasted Salmon with Ginger Sauce',
      // ADDED description parameter:
      description: 'A light and flavorful dish featuring perfectly roasted salmon fillets infused with zesty lime and a savory ginger sauce.',
      authorName: 'Chef Foodie',
      authorAvatarUrl: 'assets/images/elena_mayer.png',
      imageUrl: 'assets/images/recipes/salmon.png',
      cookingTime: '30 Minutes',
      calories: '420 Kcal',
      categoryName: 'Fish',
      categoryId: 5,
      shortDescription: 'Light and flavorful roasted salmon with a zesty ginger-lime sauce.',
      ingredients: [
        Ingredient(name: 'Salmon Fillet', quantity: '1 (6oz)'),
        Ingredient(name: 'Lime', quantity: '1'),
        Ingredient(name: 'Ginger', quantity: '1 inch piece'),
        Ingredient(name: 'Soy Sauce', quantity: '1 tbsp'),
        Ingredient(name: 'Honey', quantity: '1 tsp'),
        Ingredient(name: 'Olive Oil', quantity: '1 tbsp'),
        Ingredient(name: 'Cilantro', quantity: 'for garnish'),
      ],
      directions: [
        'Step 1: Preheat oven to 400°F (200°C).',
        'Step 2: Place salmon on a baking sheet. Squeeze half a lime over it, season with salt and pepper.',
        'Step 3: In a small bowl, whisk together grated ginger, soy sauce, honey, and olive oil for the sauce.',
        'Step 4: Pour half of the sauce over the salmon. Roast for 12-15 minutes, or until cooked through.',
        'Step 5: Drizzle remaining sauce over cooked salmon. Garnish with fresh cilantro and lime wedges.'
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
    ),

    // --- Detailed Recipe: Mixed Tropical Fruit Salad with Superfood Boosts ---
    Recipe(
      id: 'fruit_salad',
      name: 'Mixed Tropical Fruit Salad with Superfood Boosts',
      // ADDED description parameter:
      description: 'A vibrant and nutrient-packed fruit salad combining a variety of tropical fruits with superfood boosts for a healthy and refreshing treat.',
      authorName: 'Chef Foodie',
      authorAvatarUrl: 'assets/images/elena_mayer.png',
      imageUrl: 'assets/images/recipes/fruit_salad.png',
      cookingTime: '15 Minutes',
      calories: '180 Kcal',
      categoryName: 'Healthy',
      categoryId: 6,
      shortDescription: 'A vibrant and nutrient-packed fruit salad to boost your energy.',
      ingredients: [
        Ingredient(name: 'Mango', quantity: '1, diced'),
        Ingredient(name: 'Pineapple', quantity: '1 cup, diced'),
        Ingredient(name: 'Kiwi', quantity: '2, sliced'),
        Ingredient(name: 'Strawberries', quantity: '1 cup, halved'),
        Ingredient(name: 'Blueberries', quantity: '1/2 cup'),
        Ingredient(name: 'Chia Seeds', quantity: '1 tbsp'),
        Ingredient(name: 'Honey-Lime Dressing', quantity: '2 tbsp'),
      ],
      directions: [
        'Step 1: Gently combine all diced and sliced fruits in a large bowl.',
        'Step 2: Drizzle with honey-lime dressing (mix honey and lime juice).',
        'Step 3: Sprinkle chia seeds over the top for an extra boost.',
        'Step 4: Serve chilled and enjoy!'
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
    ),

    // Other simplified recipes (from AllRecipesScreen)
    Recipe(
      id: 'smoothie_bowl',
      name: 'Smoothie Bowl',
      // ADDED description parameter:
      description: 'Start your day with a refreshing and healthy smoothie bowl, topped with fresh fruits and granola for extra crunch.',
      authorName: 'Chef Foodie',
      authorAvatarUrl: 'assets/images/elena_mayer.png',
      imageUrl: 'assets/images/recipes_list/smoothie_bowl.png',
      cookingTime: '15 min', calories: '300 Kcal', categoryName: 'Breakfast', categoryId: 3,
      shortDescription: 'A vibrant and healthy smoothie bowl.',
      ingredients: [Ingredient(name: 'Frozen Berries', quantity: '1 cup')], directions: ['Blend', 'Top with fruit'],
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    Recipe(
      id: 'oatmeal',
      name: 'Oatmeal',
      // ADDED description parameter:
      description: 'A comforting and hearty bowl of classic oatmeal, perfect for a warming breakfast on a cold morning.',
      authorName: 'Chef Foodie',
      authorAvatarUrl: 'assets/images/elena_mayer.png',
      imageUrl: 'assets/images/recipes_list/oatmeal.png',
      cookingTime: '10 min', calories: '180 Kcal', categoryName: 'Breakfast', categoryId: 3,
      shortDescription: 'Classic warm oatmeal for a hearty breakfast.',
      ingredients: [Ingredient(name: 'Rolled Oats', quantity: '1/2 cup')], directions: ['Boil water', 'Cook oats'],
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    Recipe(
      id: 'breakfast_burrito',
      name: 'Breakfast Burrito',
      // ADDED description parameter:
      description: 'A satisfying and portable breakfast burrito packed with eggs, cheese, and your favorite fillings, perfect for on-the-go.',
      authorName: 'Chef Foodie',
      authorAvatarUrl: 'assets/images/elena_mayer.png',
      imageUrl: 'assets/images/recipes_list/breakfast_burrito.png',
      cookingTime: '25 min', calories: '450 Kcal', categoryName: 'Breakfast', categoryId: 3,
      shortDescription: 'A satisfying and portable breakfast.',
      ingredients: [Ingredient(name: 'Tortillas', quantity: '2')], directions: ['Cook filling', 'Wrap'],
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    ),
    Recipe(
      id: 'chicken_salad',
      name: 'Chicken Salad',
      // ADDED description parameter:
      description: 'A light and refreshing chicken salad, ideal for lunch. Made with tender chicken, crisp vegetables, and a creamy dressing.',
      authorName: 'Chef Foodie',
      authorAvatarUrl: 'assets/images/elena_mayer.png',
      imageUrl: 'assets/images/recipes_list/chicken_salad.png',
      cookingTime: '15 min', calories: '320 Kcal', categoryName: 'Lunch', categoryId: 7,
      shortDescription: 'Fresh and light chicken salad.',
      ingredients: [Ingredient(name: 'Cooked Chicken', quantity: '1 cup')], directions: ['Mix ingredients', 'Chill'],
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Recipe(
      id: 'pasta_primavera',
      name: 'Pasta Primavera',
      // ADDED description parameter:
      description: 'A vibrant and flavorful pasta primavera featuring a medley of fresh seasonal vegetables tossed with pasta in a light sauce.',
      authorName: 'Chef Foodie',
      authorAvatarUrl: 'assets/images/elena_mayer.png',
      imageUrl: 'assets/images/recipes_list/pasta_primavera.png',
      cookingTime: '30 min', calories: '380 Kcal', categoryName: 'Lunch', categoryId: 7,
      shortDescription: 'Colorful pasta with seasonal vegetables.',
      ingredients: [Ingredient(name: 'Pasta', quantity: '200g')], directions: ['Cook pasta', 'Sauté veggies'],
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Recipe(
      id: 'steak_asparagus',
      name: 'Steak with Asparagus',
      // ADDED description parameter:
      description: 'A elegant and satisfying meal of perfectly cooked steak paired with tender, roasted asparagus.',
      authorName: 'Chef Foodie',
      authorAvatarUrl: 'assets/images/elena_mayer.png',
      imageUrl: 'assets/images/recipes_list/steak.png',
      cookingTime: '35 min', calories: '550 Kcal', categoryName: 'Dinner', categoryId: 2,
      shortDescription: 'Grilled steak with tender asparagus.',
      ingredients: [Ingredient(name: 'Steak', quantity: '200g')], directions: ['Cook steak', 'Roast asparagus'],
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Recipe(
      id: 'salmon_roasted_veggies',
      name: 'Salmon with Roasted Veggies',
      // ADDED description parameter:
      description: 'A healthy and delicious meal featuring baked salmon fillets served alongside a colorful medley of roasted vegetables.',
      authorName: 'Chef Foodie',
      authorAvatarUrl: 'assets/images/elena_mayer.png',
      imageUrl: 'assets/images/recipes_list/salmon_dinner.png',
      cookingTime: '40 min', calories: '480 Kcal', categoryName: 'Dinner', categoryId: 2,
      shortDescription: 'Healthy baked salmon with a medley of roasted vegetables.',
      ingredients: [Ingredient(name: 'Salmon Fillet', quantity: '1')], directions: ['Roast veggies', 'Bake salmon'],
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
    ),
  ];

  static List<Recipe> get allRecipes => _allRecipes;

  static Recipe? getRecipeById(String id) {
    return _allRecipes.firstWhereOrNull((recipe) => recipe.id == id);
  }

  static List<Recipe> getOtherRecipes(String currentRecipeId, {int count = 3}) {
    return _allRecipes
        .where((recipe) => recipe.id != currentRecipeId)
        .take(count)
        .toList();
  }
}