// lib/app/product/controllers/edit_recipe_controller.dart

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class Ingredient {
  final String name;
  final String quantity;

  Ingredient({required this.name, required this.quantity});

  // Add this method to create a copy with updated fields
  Ingredient copyWith({String? name, String? quantity}) {
    return Ingredient(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
    );
  }
}

class EditRecipeController extends GetxController {
  final String recipeId;

  EditRecipeController({required this.recipeId});

  final formKey = GlobalKey<FormState>();

  // Text controllers
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final cookingTimeController = TextEditingController();
  final servingSizeController = TextEditingController();
  final shortDescriptionController = TextEditingController();

  // Reactive states
  var isLoading = false.obs;
  var selectedCategoryId = Rx<int?>(null);
  var imagePath = ''.obs;
  var initialImageUrl = ''.obs;

  // Ingredients
  var ingredients = <Ingredient>[].obs;

  void addIngredient() {
    ingredients.add(Ingredient(name: '', quantity: ''));
  }

  void removeIngredient(int index) {
    ingredients.removeAt(index);
  }

  // Directions
  var directions = <String>[].obs;

  void addDirection() {
    directions.add('');
  }

  void removeDirection(int index) {
    directions.removeAt(index);
  }

  // Pick image (stub for now)
  Future<void> pickImage() async {
    // TODO: implement image picker
  }

  // Load recipe details (simulate API)
  Future<void> loadRecipe() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1)); // fake API delay

    // Mock data — replace with real API call
    nameController.text = "Spaghetti Bolognese";
    descriptionController.text = "A delicious Italian pasta dish.";
    cookingTimeController.text = "30 min";
    servingSizeController.text = "2 servings";
    shortDescriptionController.text = "Classic Italian pasta";
    selectedCategoryId.value = 1;
    initialImageUrl.value = "https://via.placeholder.com/150";

    ingredients.assignAll([
      Ingredient(name: "Spaghetti", quantity: "200g"),
      Ingredient(name: "Ground beef", quantity: "300g"),
    ]);

    directions.assignAll([
      "Boil pasta until al dente.",
      "Cook beef with sauce.",
      "Mix and serve.",
    ]);

    isLoading.value = false;
  }

  // Update recipe (stub)
  Future<void> updateRecipe() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2)); // fake API
    isLoading.value = false;
    Get.snackbar("Success", "Recipe updated!");
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    loadRecipe();
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    cookingTimeController.dispose();
    servingSizeController.dispose();
    shortDescriptionController.dispose();
    super.onClose();
  }
}