// lib/app/blog/controllers/create_blog_post_controller.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/product/data/models/category_model.dart';
import '../data/models/blog_post_model.dart';
import 'blog_controller.dart'; // Category model

class CreateBlogPostController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text Controllers for all BlogPost fields
  final TextEditingController titleController = TextEditingController();
  final TextEditingController shortDescriptionController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController(); // Can be used for direct URL input or for display after picking
  final TextEditingController articleUrlController = TextEditingController();
  final TextEditingController authorNameController = TextEditingController();
  final TextEditingController authorAvatarUrlController = TextEditingController();

  final RxInt selectedCategoryId = 0.obs;
  final RxString imagePath = ''.obs; // To store the path of the picked image

  final ImagePicker _picker = ImagePicker();
  late BlogController _blogController; // Reference to the main BlogController

  @override
  void onInit() {
    super.onInit();
    _blogController = Get.find<BlogController>(); // Get the instance of BlogController

    // Load categories from the main BlogController
    // Ensure 'All' category (id: 0) is excluded from selectable categories
    if (_blogController.categories.isNotEmpty && _blogController.categories.any((cat) => cat.id != 0)) {
      selectedCategoryId.value = _blogController.categories.firstWhere((cat) => cat.id != 0).id;
    }
  }

  // Get categories from the main BlogController, excluding 'All'
  List<Category> get categoriesForDropdown => _blogController.categories.where((cat) => cat.id != 0).toList();


  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
      // If you want the imageUrlController to show the local path for display
      imageUrlController.text = pickedFile.path;
    }
  }

  Future<void> createBlogPost() async {
    if (formKey.currentState?.validate() ?? false) {
      // Basic validation for image path if no direct URL is provided
      if (imagePath.value.isEmpty && imageUrlController.text.isEmpty) {
        Get.snackbar('Error', 'Please pick an image or enter an image URL');
        return;
      }
      if (selectedCategoryId.value == 0) {
        Get.snackbar('Error', 'Please select a valid category');
        return;
      }

      // In a real app, if imagePath.value is a local file, you'd upload it to a server
      // and get back a public URL, which would then be assigned to blogPost.imageUrl.
      // For this example, we'll just use the provided imageUrlController.text or a placeholder.
      String finalImageUrl = imageUrlController.text.isNotEmpty
          ? imageUrlController.text
          : 'https://via.placeholder.com/150'; // Fallback if local path and no URL entered

      // If imagePath is a local file, we might assume it's a temp file and need to upload it
      // For now, let's treat imageUrlController.text as the definitive URL or path.
      if (imagePath.value.isNotEmpty && finalImageUrl.startsWith('/data')) { // Simple check for local path
        // This is where you'd call an upload service
        // For now, just use a generic placeholder or the raw github image for demo
        finalImageUrl = 'https://raw.githubusercontent.com/CodderPrince/CodderPrince/main/GithubCover.png';
        Get.snackbar('Notice', 'Image upload simulated. Using default image for demo.');
      }


      final newPost = BlogPost(
        id: 0, // ID will be assigned by BlogController/API
        title: titleController.text,
        shortDescription: shortDescriptionController.text,
        content: contentController.text,
        imageUrl: finalImageUrl, // Use the resolved image URL
        articleUrl: articleUrlController.text,
        authorName: authorNameController.text,
        authorAvatarUrl: authorAvatarUrlController.text,
        createdAt: DateTime.now(),
        categoryId: selectedCategoryId.value,
      );

      await _blogController.addBlogPost(newPost);
      Get.back(); // Go back after adding
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    shortDescriptionController.dispose();
    contentController.dispose();
    imageUrlController.dispose();
    articleUrlController.dispose();
    authorNameController.dispose();
    authorAvatarUrlController.dispose();
    super.onClose();
  }
}