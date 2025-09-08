// lib/app/blog/ui/screens/edit_blog_post_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../product/data/models/category_model.dart';
import '../../controllers/edit_blog_post_controller.dart';
import '../../data/models/blog_post_model.dart'; // Make sure BlogPost is imported if needed for dropdown items


class EditBlogPostScreen extends GetView<EditBlogPostController> {
   EditBlogPostScreen({super.key}); // Added const constructor

  // TODO: You'll likely need a list of categories to populate the dropdown
  // This would usually come from a service or be loaded in the controller.
  final List<Category> _blogCategories = [
    Category(id: 1, name: 'Technology', imageUrl: 'https://github.com/CodderPrince/CodderPrince/blob/main/GithubCover.png'),
    Category(id: 2, name: 'Food', imageUrl: 'https://github.com/CodderPrince/CodderPrince/blob/main/GithubCover.png'),
    Category(id: 3, name: 'Travel', imageUrl: 'https://github.com/CodderPrince/CodderPrince/blob/main/GithubCover.png'),
    // ... more categories
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Blog Post'), // Added const
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Added const
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, // Ensures icon and text are black
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator()); // Added const
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.formKey,
              child: ListView(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Title'), // Added const
                    controller: controller.titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0), // Added const
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Content'), // Added const
                    controller: controller.contentController,
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some content';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0), // Added const
                  // Category Dropdown
                  // Use Obx to react to changes in selectedCategoryId
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
                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                        onChanged: (int? newValue) {
                          controller.selectedCategoryId.value = newValue;
                          // You might also want to update a selectedCategoryName if you have one
                        },
                        items: _blogCategories.map<DropdownMenuItem<int>>((Category category) {
                          return DropdownMenuItem<int>(
                            value: category.id,
                            child: Text(category.name),
                          );
                        }).toList(),
                      ),
                    ),
                  )),
                  const SizedBox(height: 16.0), // Added const
                  ElevatedButton(
                    onPressed: () {
                      controller.pickImage();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200], // Example style
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Pick Image'), // Added const
                  ),
                  Obx(() => controller.imagePath.value.isNotEmpty
                      ? Padding(
                    padding: const EdgeInsets.only(top: 8.0), // Added const
                    child: Image.file(
                      File(controller.imagePath.value),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  )
                      : controller.initialImageUrl.value.isNotEmpty
                      ? Padding(
                    padding: const EdgeInsets.only(top: 8.0), // Added const
                    child: Image.network(
                      controller.initialImageUrl.value,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  )
                      : const SizedBox.shrink()), // Added const
                  const SizedBox(height: 24.0), // Added const
                  ElevatedButton(
                    onPressed: () {
                      controller.updateBlogPost();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6B4EEF), // Example brand color
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text('Update Blog Post'), // Added const
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}