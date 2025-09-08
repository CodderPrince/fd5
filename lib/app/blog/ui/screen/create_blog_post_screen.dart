// lib/app/blog/ui/screen/create_blog_post_screen.dart
import 'dart:io'; // Required for File
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/create_blog_post_controller.dart'; // Use the new controller
import '../../../../app/extension/text_style_extension.dart';

class CreateBlogPostScreen extends GetView<CreateBlogPostController> {
  const CreateBlogPostScreen({super.key}); // Use super.key

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // Define robust default TextStyles for safety
    const TextStyle defaultTitleLarge = TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black);
    const TextStyle defaultTitleMedium = TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Blog Post',
          style: (textTheme.titleLarge ?? defaultTitleLarge).bold(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
                controller: controller.titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Short Description', border: OutlineInputBorder()),
                controller: controller.shortDescriptionController,
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a short description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Content', border: OutlineInputBorder()),
                controller: controller.contentController,
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some content';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Article URL (e.g., https://example.com/news)', border: OutlineInputBorder()),
                controller: controller.articleUrlController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the article URL';
                  }
                  // Basic URL validation
                  if (!GetUtils.isURL(value)) {
                    return 'Please enter a valid URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Author Name', border: OutlineInputBorder()),
                controller: controller.authorNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter author\'s name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Author Avatar URL (e.g., https://randomuser.me/...)', border: OutlineInputBorder()),
                controller: controller.authorAvatarUrlController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter author\'s avatar URL';
                  }
                  if (!GetUtils.isURL(value)) {
                    return 'Please enter a valid URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Obx(() => DropdownButtonFormField<int>( // Category Dropdown
                decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
                value: controller.selectedCategoryId.value == 0 ? null : controller.selectedCategoryId.value,
                items: controller.categoriesForDropdown.map((category) { // Use categoriesForDropdown
                  return DropdownMenuItem<int>(
                    value: category.id,
                    child: Text(category.name),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.selectedCategoryId.value = value;
                  }
                },
                validator: (value) {
                  if (value == null || value == 0) { // Check for null or 'All' if it somehow slips in
                    return 'Please select a category';
                  }
                  return null;
                },
              )),
              const SizedBox(height: 16.0),
              // Option 1: Pick Image from Gallery/Camera
              ElevatedButton.icon(
                onPressed: () {
                  controller.pickImage();
                },
                icon: const Icon(Icons.image),
                label: const Text('Pick Image (Local File)'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
              // Option 2: Directly input Image URL (if no local pick)
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Or enter Image URL (e.g., https://picsum.photos/...)',
                  border: OutlineInputBorder(),
                ),
                controller: controller.imageUrlController,
                validator: (value) {
                  // Only validate if no local image is picked AND an URL is provided
                  if (controller.imagePath.value.isEmpty && (value == null || value.isEmpty)) {
                    return 'Please pick an image or enter an image URL';
                  }
                  if (value != null && value.isNotEmpty && !GetUtils.isURL(value)) {
                    return 'Please enter a valid URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Display picked image preview or entered URL if any
              Obx(() {
                if (controller.imagePath.value.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.file(
                      File(controller.imagePath.value),
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  );
                } else if (controller.imageUrlController.text.isNotEmpty && GetUtils.isURL(controller.imageUrlController.text)) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.network(
                      controller.imageUrlController.text,
                      height: 150,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 150,
                        color: Colors.grey[200],
                        child: const Center(child: Text('Invalid URL or failed to load')),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  controller.createBlogPost();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Using direct color
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Create Blog Post',
                  style: Get.textTheme.titleMedium?.bold() ?? const TextStyle(fontWeight: FontWeight.bold),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}