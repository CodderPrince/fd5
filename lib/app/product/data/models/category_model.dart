// lib/app/product/data/models/category_model.dart
class Category {
  final int id;
  final String name;
  final String? imageUrl; // Added imageUrl field, made nullable

  Category({
    required this.id,
    required this.name,
    this.imageUrl, // Optional
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?, // Parse as nullable String
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }
}