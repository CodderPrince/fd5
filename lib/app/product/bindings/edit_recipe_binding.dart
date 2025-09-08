import 'dart:ui';

import 'package:get/get.dart';
import '../controllers/edit_recipe_controller.dart';

class EditRecipeBinding extends Bindings {
  @override
  void dependencies() {
    final recipeId = Get.parameters['recipeId'];

    if (recipeId == null) {
      Get.back();
      Get.snackbar('Error', 'Recipe ID is missing for editing.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFE53935),
          colorText: const Color(0xFFFFFFFF));
      return;
    }

    Get.lazyPut<EditRecipeController>(
          () => EditRecipeController(recipeId: recipeId),
    );
  }
}
