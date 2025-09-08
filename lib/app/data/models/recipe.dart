// lib/app/data/models/recipe.dart
class Ingredient {
  final String name;
  final String quantity;
  bool checked;

  Ingredient({required this.name, required this.quantity, this.checked = false});

  Ingredient copyWith({
    String? name,
    String? quantity,
    bool? checked,
  }) {
    return Ingredient(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      checked: checked ?? this.checked,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'checked': checked,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      name: map['name'] as String,
      quantity: map['quantity'] as String,
      checked: map['checked'] as bool? ?? false,
    );
  }
}

class Recipe { // Renamed from RecipeModel to Recipe
  final String id; // Changed to String for UUID compatibility with Supabase
  final String name; // Renamed from 'title' to 'name'
  final String description;
  final String imageUrl;
  final int? categoryId; // New: optional category ID
  final String categoryName; // Existing: descriptive category name (from old 'category')
  final String authorName; // Renamed from 'author' to 'authorName'
  final String? authorAvatarUrl; // New: optional author avatar URL
  final DateTime? createdAt; // New: optional, often defaults from DB

  // Existing fields from old RecipeModel, crucial for detail screen
  final String cookingTime;
  final String calories;
  final String? shortDescription;
  final List<Ingredient> ingredients;
  final List<String> directions;

  Recipe({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.categoryId,
    required this.categoryName, // Renamed
    required this.authorName, // Renamed
    this.authorAvatarUrl,
    this.createdAt,
    required this.cookingTime,
    required this.calories,
    this.shortDescription,
    required this.ingredients,
    required this.directions,
  });

  factory Recipe.fromMap(Map<String, dynamic> map) { // Use fromMap for Supabase data
    return Recipe(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      imageUrl: map['image_url'] as String, // Matches Supabase column
      categoryId: map['category_id'] as int?, // Matches Supabase column
      categoryName: map['category'] as String, // Matches Supabase column (old 'category')
      authorName: map['author_name'] as String, // Matches Supabase column
      authorAvatarUrl: map['author_avatar_url'] as String?, // Matches Supabase column
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at'] as String) : null, // Matches Supabase column

      cookingTime: map['cooking_time'] as String, // Matches Supabase column
      calories: map['calories'] as String, // Matches Supabase column
      shortDescription: map['short_description'] as String?, // Assuming short_description column
      ingredients: (map['ingredients'] as List)
          .map((i) => Ingredient.fromMap(i as Map<String, dynamic>))
          .toList(),
      directions: (map['directions'] as List).map((d) => d as String).toList(),
    );
  }

  Map<String, dynamic> toMap() { // Use toMap for Supabase insertion
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'category_id': categoryId,
      'category': categoryName,
      'author_name': authorName,
      'author_avatar_url': authorAvatarUrl,
      'created_at': createdAt?.toIso8601String(), // Send as ISO string
      'cooking_time': cookingTime,
      'calories': calories,
      'short_description': shortDescription,
      'ingredients': ingredients.map((i) => i.toMap()).toList(),
      'directions': directions,
    };
  }
}