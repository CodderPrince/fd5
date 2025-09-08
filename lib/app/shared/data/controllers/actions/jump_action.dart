// lib/app/shared/data/controllers/actions/jump_action.dart
import 'package:get/get.dart';

class JumpAction {
  static void to(String routeName, {dynamic arguments}) {
    Get.toNamed(routeName, arguments: arguments);
  }

  static void toHome() {
    to('/home');
  }

  static void toBlog() {
    to('/blog');
  }

  static void toLogin() {
    to('/login');
  }

  static void toProfile() {
    to('/profile');
  }

  static void toCreateRecipe() {
    to('/create-recipe');
  }

  static void toCreateBlogPost() {
    to('/create-blog-post');
  }

  static void toAllCategories() {
    to('/all-categories');
  }

  static void toAllRecipes() {
    to('/recipes');
  }

  static void toContact() {
    to('/contact');
  }

  static void toAboutUs() {
    to('/about-us');
  }

  // New action to navigate to the add ingredients/steps screen
  static void toAddIngredientsSteps(Map<String, dynamic> recipeInitialData) {
    to('/add-ingredients-steps', arguments: recipeInitialData);
  }
}