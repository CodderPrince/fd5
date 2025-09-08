// lib/app/product/controllers/create_recipe_controller.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../routes/app_routes.dart';
import '../../shared/data/providers/api_providers.dart';
import '../data/models/category_model.dart';

class CreateRecipeController extends GetxController {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final servingSizeController = TextEditingController();
  final cookingTimeController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final ApiProvider apiProvider = ApiProvider();

  var imagePath = ''.obs;
  var selectedCategoryId = 0.obs;
  var categoryName = ''.obs;
  var authorName = ''.obs; // optional: from profile
  var categories = <Category>[].obs;
  var isLoading = false.obs;

  // Ingredients and directions
  var ingredientList = <String>[].obs; // e.g., ["200g Chicken", "1 tbsp Salt"]
  var directionList = <String>[].obs;  // e.g., ["Cut the chicken", "Boil water"]

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  Future<void> loadCategories() async {
    isLoading.value = true;
    try {
      categories.value = await apiProvider.getCategories();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load categories: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) imagePath.value = image.path;
  }

  void addIngredient(String ingredient) {
    ingredientList.add(ingredient);
  }

  void removeIngredient(int index) {
    ingredientList.removeAt(index);
  }

  void addDirection(String step) {
    directionList.add(step);
  }

  void removeDirection(int index) {
    directionList.removeAt(index);
  }

  void createRecipe() async {
    if (!formKey.currentState!.validate()) return;

    if (imagePath.value.isEmpty) {
      Get.snackbar('Error', 'Please select an image');
      return;
    }

    if (ingredientList.isEmpty) {
      Get.snackbar('Error', 'Please add at least one ingredient');
      return;
    }

    if (directionList.isEmpty) {
      Get.snackbar('Error', 'Please add at least one direction');
      return;
    }

    isLoading.value = true;
    try {
      // Upload the image and get the URL
      final imageUrl = await apiProvider.uploadImage(File(imagePath.value), 'recipes');

      await apiProvider.createRecipe(
        name: nameController.text,
        description: descriptionController.text,
        imageUrl: imageUrl,
        categoryId: selectedCategoryId.value,
        categoryName: categoryName.value.isNotEmpty ? categoryName.value : "Unknown",
        servingSize: servingSizeController.text,
        cookingTime: cookingTimeController.text,
        ingredients: ingredientList.map((i) => {'name': i}).toList(), // FIX: convert to List<Map<String, dynamic>>
        directions: directionList.toList(), // Already List<String>
        authorName: authorName.value.isNotEmpty ? authorName.value : "Unknown",
      );

      Get.snackbar('Success', 'Recipe created successfully!');
      clearFields();
      Get.toNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar('Error', 'Failed to create recipe: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void clearFields() {
    nameController.clear();
    descriptionController.clear();
    servingSizeController.clear();
    cookingTimeController.clear();
    imagePath.value = '';
    selectedCategoryId.value = 0;
    categoryName.value = '';
    ingredientList.clear();
    directionList.clear();
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    servingSizeController.dispose();
    cookingTimeController.dispose();
    super.onClose();
  }
}
