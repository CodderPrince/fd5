import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/extension/text_style_extension.dart';
import '../../controllers/blog_controller.dart';
import '../../data/models/blog_post_model.dart';

class BlogScreen extends GetView<BlogController> {
  const BlogScreen({super.key});

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Get.snackbar(
        'Error',
        'Could not launch $urlString',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final defaultTitleLarge =
    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black);
    final defaultTitleMedium =
    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black);
    final defaultBodyMedium = const TextStyle(fontSize: 14, color: Colors.black);
    final defaultBodySmall = const TextStyle(fontSize: 12, color: Colors.black);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Blog & Article',
          style: (textTheme.titleLarge ?? defaultTitleLarge).bold(),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onSelected: (String result) {
              if (result == 'create_recipe') {
                Get.toNamed('/createRecipe');
              } else if (result == 'create_blog') {
                Get.toNamed('/createBlogPost');
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'create_recipe',
                child: Row(
                  children: [
                    Icon(Icons.add, color: Colors.grey[700]),
                    const SizedBox(width: 8),
                    const Text('Create Recipe'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'create_blog',
                child: Row(
                  children: [
                    Icon(Icons.edit, color: Colors.grey[700]),
                    const SizedBox(width: 8),
                    const Text('Create Blog'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 8.0),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search article, news or recipe...',
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: Colors.grey[700]),
                      ),
                      onChanged: controller.onSearchChanged,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      _buildFilterBottomSheet(
                        textTheme,
                        defaultTitleLarge,
                      ),
                      backgroundColor: Colors.white,
                      isScrollControlled: true,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(Icons.filter_list, color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.blogPosts.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              final posts = controller.filteredBlogPosts.isEmpty
                  ? controller.blogPosts
                  : controller.filteredBlogPosts;

              if (posts.isEmpty) {
                return const Center(child: Text('No blog posts found.'));
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final blogPost = posts[index];
                  return _buildBlogPostCard(
                    blogPost,
                    textTheme,
                    defaultTitleMedium,
                    defaultBodyMedium,
                    defaultBodySmall,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBottomSheet(TextTheme textTheme, TextStyle defaultTitleLarge) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filter by Category',
                style: (textTheme.titleLarge ?? defaultTitleLarge).bold(),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8.0,
                children: controller.categories.map((category) {
                  final isSelected = controller.selectedCategoryId.value == category.id;
                  return ChoiceChip(
                    label: Text(category.name),
                    selected: isSelected,
                    selectedColor: Colors.blue,
                    onSelected: (selected) {
                      controller.onCategorySelected(
                          selected ? category.id : 0); // reset if unselected
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.onCategorySelected(0);
                  },
                  child: const Text('Reset Filter'),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildBlogPostCard(
      BlogPost blogPost,
      TextTheme textTheme,
      TextStyle defaultTitleMedium,
      TextStyle defaultBodyMedium,
      TextStyle defaultBodySmall,
      ) {
    return InkWell(
      onTap: () {
        _launchURL(blogPost.articleUrl);
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 55.0),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                blogPost.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(height: 180, color: Colors.grey[300], child: const Center(child: Icon(Icons.broken_image))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blogPost.title,
                    style: (textTheme.titleMedium ?? defaultTitleMedium).bold(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    blogPost.shortDescription,
                    style: Get.textTheme.titleMedium?.bold() ?? const TextStyle(fontWeight: FontWeight.bold),

                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(blogPost.authorAvatarUrl),
                        onBackgroundImageError: (exception, stackTrace) => const Icon(Icons.person, size: 18, color: Colors.grey),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        blogPost.authorName,
                        style: (textTheme.bodySmall ?? defaultBodySmall).bold(),
                      ),
                      const Spacer(),
                      Text(
                        DateFormat('dd MMM yyyy').format(blogPost.createdAt),
                        style: Get.textTheme.titleMedium?.bold() ?? const TextStyle(fontWeight: FontWeight.bold),

                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
