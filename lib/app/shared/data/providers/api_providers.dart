// lib/app/shared/data/providers/api_providers.dart
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path; // Import path package

import '../../../blog/data/models/blog_post_model.dart';
import '../../../product/data/models/category_model.dart';
import '../../../data/models/recipe.dart'; // Import the correct Recipe Model

class ApiProvider {
  final SupabaseClient client = Supabase.instance.client;

  Future<List<Recipe>> getRecipes() async {
    final response = await client.from('recipes').select();
    final List<dynamic> data = response as List<dynamic>;
    return data.map((e) => Recipe.fromMap(e as Map<String, dynamic>)).toList();
  }

  Future<List<Category>> getCategories() async {
    final response = await client.from('categories').select();
    final List<dynamic> data = response as List<dynamic>;
    return data.map((e) => Category.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<BlogPost>> getBlogPosts() async {
    final response = await client.from('blog_posts').select();
    final List<dynamic> data = response as List<dynamic>;
    return data.map((e) => BlogPost.fromJson(e as Map<String, dynamic>)).toList();
  }

  // Get single recipe
  Future<Recipe> getRecipe(String id) async {
    final response = await client.from('recipes').select().eq('id', id).single();
    return Recipe.fromMap(response);
  }

  // Get single blog post
  Future<BlogPost> getBlogPost(int id) async {
    final response = await client.from('blog_posts').select().eq('id', id).single();
    return BlogPost.fromJson(response);
  }

  // Upload image to Supabase Storage
  // FIX: Ensure 'folder' is used as the parameter name in the filePath construction
  Future<String> uploadImage(File image, String folderName) async { // Renamed parameter to folderName for clarity
    final userId = client.auth.currentUser!.id;
    // FIX: Use folderName here
    final filePath = '$folderName/$userId/${DateTime.now().millisecondsSinceEpoch}${path.extension(image.path)}';

    try {
      final bytes = await image.readAsBytes();
      // FIX: Use bucketName parameter here as well (which should be 'recipe_images' when called)
      await client.storage.from(folderName).uploadBinary( // Changed from 'foodieland-storage' to folderName
        filePath,
        bytes,
        fileOptions: const FileOptions(contentType: 'image/jpeg'),
      );
      // Return public image url from the specified bucket (folderName)
      return client.storage.from(folderName).getPublicUrl(filePath);
    } catch (error) {
      print('Error uploading image: $error');
      throw Exception('Failed to upload image: $error');
    }
  }

  // Create a recipe
  Future<void> createRecipe({
    required String name,
    required String description,
    required String imageUrl,
    required int? categoryId,
    required String categoryName,
    required String cookingTime,
    required String servingSize,
    required String authorName,
    String? authorAvatarUrl,
    String? shortDescription,
    required List<Map<String, dynamic>> ingredients,
    required List<String> directions,
  }) async {
    final currentUserId = client.auth.currentUser!.id;

    await client.from('recipes').insert({
      'user_id': currentUserId,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'category_id': categoryId,
      'category': categoryName,
      'cooking_time': cookingTime,
      'serving_size': servingSize,
      'author_name': authorName,
      'author_avatar_url': authorAvatarUrl,
      'short_description': shortDescription,
      'ingredients': ingredients,
      'directions': directions,
    });
  }

  // Update a recipe
  Future<void> updateRecipe({
    required String id,
    required String name,
    required String description,
    required String imageUrl,
    required int? categoryId,
    required String categoryName,
    required String cookingTime,
    required String servingSize,
    String? shortDescription,
    required List<Map<String, dynamic>> ingredients,
    required List<String> directions,
  }) async {
    await client.from('recipes').update({
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'category_id': categoryId,
      'category': categoryName,
      'cooking_time': cookingTime,
      'serving_size': servingSize,
      'short_description': shortDescription,
      'ingredients': ingredients,
      'directions': directions,
    }).eq('id', id);
  }

  // Delete a recipe
  Future<void> deleteRecipe(String id) async {
    await client.from('recipes').delete().eq('id', id);
  }

  // Create a blog post
  Future<void> createBlogPost({
    required String title,
    required String content,
    required String imageUrl,
    required int categoryId,
  }) async {
    await client.from('blog_posts').insert({
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'category_id': categoryId,
      'user_id': client.auth.currentUser!.id,
      'author_name': client.auth.currentUser!.email,
      'author_avatar_url': 'URL to default avatar',
    });
  }

  // Update a blog post
  Future<void> updateBlogPost({
    required int id,
    required String title,
    required String content,
    required String imageUrl,
    required int categoryId,
  }) async {
    await client.from('blog_posts').update({
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'category_id': categoryId,
    }).eq('id', id);
  }

  // Delete a blog post
  Future<void> deleteBlogPost(int id) async {
    await client.from('blog_posts').delete().eq('id', id);
  }
}