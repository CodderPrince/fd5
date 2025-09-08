// lib/app/blog/controllers/edit_blog_post_controller.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// Ensure BlogPost is imported
import '../../shared/data/providers/api_providers.dart'; // Ensure ApiProvider is imported
import '../../routes/app_routes.dart';
import '../data/models/blog_post_model.dart';

class EditBlogPostController extends GetxController {
  final int blogPostId; // Expecting an int ID
  EditBlogPostController({required this.blogPostId});

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final ApiProvider apiProvider = ApiProvider(); // Instantiate ApiProvider

  var imagePath = ''.obs; // For newly picked image
  var initialImageUrl = ''.obs; // For existing image from DB
  var isLoading = true.obs;
  var selectedCategoryId = Rx<int?>(null); // For category selection

  @override
  void onInit() {
    super.onInit();
    loadBlogPost();
  }

  Future<void> loadBlogPost() async {
    isLoading.value = true;
    try {
      final BlogPost blogPost = await apiProvider.getBlogPost(blogPostId);
      titleController.text = blogPost.title;
      contentController.text = blogPost.content;
      initialImageUrl.value = blogPost.imageUrl;
      selectedCategoryId.value = blogPost.categoryId; // Populate category
    } catch (e) {
      Get.snackbar('Error', 'Failed to load blog post: $e',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imagePath.value = image.path;
    }
  }

  Future<void> updateBlogPost() async {
    if (formKey.currentState!.validate()) {
      if (selectedCategoryId.value == null) {
        Get.snackbar('Error', 'Please select a category.',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }

      isLoading.value = true; // Show loading while updating
      try {
        String imageUrl = initialImageUrl.value; // Use initial image URL by default

        if (imagePath.value.isNotEmpty) {
          // Upload the new image and get the URL
          imageUrl = await apiProvider.uploadImage(File(imagePath.value), 'blog_posts'); // Assuming 'blog_posts' bucket
        }

        await apiProvider.updateBlogPost(
          id: blogPostId,
          title: titleController.text,
          content: contentController.text,
          imageUrl: imageUrl,
          categoryId: selectedCategoryId.value!,
        );

        Get.snackbar('Success', 'Blog Post updated successfully!',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
        Get.offNamed(AppRoutes.blog); // Navigate back to blog list

      } catch (e) {
        Get.snackbar('Error', 'Failed to update blog post: $e',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    super.onClose();
  }
}