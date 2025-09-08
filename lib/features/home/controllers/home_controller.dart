// lib/app/features/home/controllers/home_controller.dart
import 'package:get/get.dart';
import '../../../app/product/data/models/category_model.dart';
import '../../../app/data/models/recipe.dart';
import '../../../app/shared/data/providers/api_providers.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var categories = <Category>[].obs;
  var recipes = <Recipe>[].obs;
  var selectedCategoryId = 0.obs; // Track selected category
  final ApiProvider apiProvider = ApiProvider();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  /// Fetch categories and recipes
  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      categories.value = await apiProvider.getCategories();
      recipes.value = await apiProvider.getRecipes();
    } catch (e) {
      print('Error fetching data: $e');
      Get.snackbar('Error', 'Failed to load data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Delete a recipe by its string ID
  Future<void> deleteRecipe(String recipeId) async {
    try {
      await apiProvider.deleteRecipe(recipeId);
      recipes.removeWhere((recipe) => recipe.id == recipeId);
      Get.snackbar('Success', 'Recipe deleted successfully!');
    } catch (e) {
      print('Error deleting recipe: $e');
      Get.snackbar('Error', 'Failed to delete recipe: $e');
    }
  }

  /// Filter recipes based on selected category
  List<Recipe> get filteredRecipes {
    if (selectedCategoryId.value == 0) {
      return recipes;
    } else {
      return recipes
          .where((recipe) => recipe.categoryId == selectedCategoryId.value)
          .toList();
    }
  }

  /// Select a category (0 = All)
  void selectCategory(int categoryId) {
    selectedCategoryId.value = categoryId;
  }
}
