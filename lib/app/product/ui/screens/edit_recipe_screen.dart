// lib/app/product/ui/screens/edit_recipe_screen.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/edit_recipe_controller.dart';


class EditRecipeScreen extends GetView<EditRecipeController> {
  const EditRecipeScreen({super.key});

  // Helper widget functions are part of the screen class to access controller
  // Or, they can be top-level functions that take controller as parameter
  // For now, let's keep them here as before

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Edit Recipe',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Obx(
            () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFormLabel('Recipe Name'),
                  _buildTextField(
                    controller: controller.nameController,
                    hintText: 'Enter recipe name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a recipe name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  _buildFormLabel('Description'),
                  _buildTextField(
                    controller: controller.descriptionController,
                    hintText: 'Describe your recipe',
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please describe your recipe';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  _buildFormLabel('Cooking Time (minutes)'),
                  _buildTextField(
                    controller: controller.cookingTimeController,
                    hintText: 'e.g., 30 min',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter cooking time';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  _buildFormLabel('Serving Size'),
                  _buildTextField(
                    controller: controller.servingSizeController,
                    hintText: 'e.g., 4 servings',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter serving size';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  _buildFormLabel('Short Description'),
                  _buildTextField(
                    controller: controller.shortDescriptionController,
                    hintText: 'A short summary for lists',
                    maxLines: 2,
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  _buildFormLabel('Category'),
                  Obx(() => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        isExpanded: true,
                        value: controller.selectedCategoryId.value,
                        hint: const Text('Select category'),
                        icon: const Icon(Icons.unfold_more, color: Colors.grey),
                        onChanged: (int? newValue) {
                          if (newValue != null) {
                            controller.selectedCategoryId.value = newValue;
                            // You might need to update selectedCategoryName here if you display it
                          }
                        },
                        items: const [
                          // TODO: Dynamically load categories from API
                          DropdownMenuItem(value: 1, child: Text('Dinner')),
                          DropdownMenuItem(value: 2, child: Text('Breakfast')),
                        ],
                      ),
                    ),
                  )),
                  const SizedBox(height: 20),

                  GestureDetector(
                    onTap: controller.isLoading.value ? null : controller.pickImage,
                    child: Obx(() => Container(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            controller.imagePath.isNotEmpty ? Icons.check_circle : Icons.photo_library_outlined,
                            color: controller.imagePath.isNotEmpty ? Colors.green : Colors.grey,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            controller.imagePath.isNotEmpty ? 'New Image Selected' : 'Upload New Dish Photo',
                            style: TextStyle(
                              color: controller.imagePath.isNotEmpty ? Colors.green : Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          if (controller.imagePath.value.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.file(
                                File(controller.imagePath.value),
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                            )
                          else if (controller.initialImageUrl.value.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                controller.initialImageUrl.value,
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                        ],
                      ),
                    )),
                  ),
                  const SizedBox(height: 20),

                  _buildFormLabel('Ingredients'),
                  Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.ingredients.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: _buildTextField(
                                initialValue: controller.ingredients[index].name,
                                onChanged: (value) => controller.ingredients[index] = controller.ingredients[index].copyWith(name: value), // Update RxList item immutably
                                hintText: 'e.g., Chicken Breast',
                                labelText: 'Ingredient Name',
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'Required';
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 2,
                              child: _buildTextField(
                                initialValue: controller.ingredients[index].quantity,
                                onChanged: (value) => controller.ingredients[index] = controller.ingredients[index].copyWith(quantity: value), // Update RxList item immutably
                                hintText: 'e.g., 200 g',
                                labelText: 'Quantity',
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'Required';
                                  return null;
                                },
                              ),
                            ),
                            if (controller.ingredients.length > 1)
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                                onPressed: () => controller.removeIngredient(index),
                              ),
                          ],
                        ),
                      );
                    },
                  )),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: controller.addIngredient,
                      icon: const Icon(Icons.add_circle_outline, color: Colors.black),
                      label: const Text('Add Ingredient', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(height: 30),

                  _buildFormLabel('Directions'),
                  Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.directions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.grey[300],
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(color: Colors.black, fontSize: 12),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _buildTextField(
                                initialValue: controller.directions[index],
                                onChanged: (value) => controller.directions[index] = value, // Update RxList item directly (since String is immutable)
                                hintText: 'Describe this step',
                                labelText: 'Step ${index + 1}',
                                maxLines: 3,
                                validator: (value) {
                                  if (value == null || value.isEmpty) return 'Required';
                                  return null;
                                },
                              ),
                            ),
                            if (controller.directions.length > 1)
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                                onPressed: () => controller.removeDirection(index),
                              ),
                          ],
                        ),
                      );
                    },
                  )),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: controller.addDirection,
                      icon: const Icon(Icons.add_circle_outline, color: Colors.black),
                      label: const Text('Add Step', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value ? null : controller.updateRecipe,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6B4EEF),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: controller.isLoading.value
                          ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Text('Update Recipe', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Helper Widgets (moved inside the class or made top-level if needed elsewhere)
  Widget _buildFormLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildTextField({
    TextEditingController? controller,
    String? initialValue,
    required String hintText,
    String? labelText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}