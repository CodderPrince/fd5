// lib/app/blog/bindings/edit_blog_post_binding.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/edit_blog_post_controller.dart';

class EditBlogPostBinding extends Bindings {
  @override
  void dependencies() {
    final blogPostId = Get.parameters['blogPostId']; // Assuming route is /edit-blog-post/:blogPostId

    if (blogPostId == null) {
      Get.back(); // Or navigate to an error page
      Get.snackbar('Error', 'Blog Post ID is missing for editing.',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Assuming blogPostId is an int in BlogPost model, parse it
    final int? parsedId = int.tryParse(blogPostId);
    if (parsedId == null) {
      Get.back(); // Or navigate to an error page
      Get.snackbar('Error', 'Invalid Blog Post ID for editing.',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    Get.lazyPut<EditBlogPostController>(
          () => EditBlogPostController(blogPostId: parsedId),
    );
  }
}