import 'package:get/get.dart';
import '../../../../app/blog/data/models/blog_post_model.dart';
import '../../../../app/product/data/models/category_model.dart';
import '../../../../app/shared/data/providers/api_providers.dart';

class BlogController extends GetxController {
  var isLoading = false.obs;
  var blogPosts = <BlogPost>[].obs;
  var selectedCategoryId = 0.obs;
  var categories = <Category>[].obs;
  var searchQuery = ''.obs;

  final ApiProvider apiProvider = ApiProvider();

  @override
  void onInit() {
    super.onInit();
    fetchData();
    loadCategories();
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      List<BlogPost> fetchedPosts = await apiProvider.getBlogPosts();
      if (fetchedPosts.isEmpty) {
        _addMockBlogPosts();
      } else {
        blogPosts.value = fetchedPosts;
      }
    } catch (e) {
      print('Error fetching blog posts: $e');
      Get.snackbar('Error', 'Failed to load blog posts: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _addMockBlogPosts() {
    blogPosts.addAll([
      BlogPost(
        id: 1,
        title: 'Crochet Projects for Noodle Lovers',
        shortDescription: 'Discover fun and creative crochet projects inspired by your favorite pasta shapes!',
        content: 'This is the full content for crochet projects. It contains more detailed information and images related to various noodle-themed crafts. Perfect for a cozy afternoon!',
        imageUrl: 'https://kabutonoodles.com/cdn/shop/articles/untitled-design-15_1080x.webp?v=1660135660',
        authorName: 'Wade Warren',
        authorAvatarUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
        createdAt: DateTime(2021, 11, 12),
        categoryId: 1,
        articleUrl: 'https://kabutonoodles.com/blogs/articles/inspiration-crochet-projects-for-noodle-lovers', // Placeholder news link
      ),
      BlogPost(
        id: 2,
        title: '50 Vegetarian Recipes To Eat This Month',
        shortDescription: 'Explore delicious and easy-to-make vegetarian dishes perfect for any day of the week.',
        content: 'Dive into a collection of healthy and flavorful vegetarian recipes, from hearty stews to light salads. Each recipe includes step-by-step instructions and nutritional information.',
        imageUrl: 'https://cdn.loveandlemons.com/wp-content/uploads/2023/12/vegetarian-dinner-recipes.jpg',
        authorName: 'Robert Fox',
        authorAvatarUrl: 'https://randomuser.me/api/portraits/men/2.jpg',
        createdAt: DateTime(2021, 11, 12),
        categoryId: 2,
        articleUrl: 'https://www.loveandlemons.com/vegetarian-recipes/', // Placeholder news link
      ),
      BlogPost(
        id: 3,
        title: 'Full Guide to Becoming a Professional Chef',
        shortDescription: 'An in-depth look at the journey from home cook to a culinary professional.',
        content: 'This comprehensive guide covers everything from culinary school options to practical kitchen skills, career paths, and tips from experienced chefs. Start your culinary adventure today!',
        imageUrl: 'https://affirmcollege.com/wp-content/uploads/2023/04/How-to-become-a-chef-a-complete-guide-2-768x768.webp',
        authorName: 'Dianne Russell',
        authorAvatarUrl: 'https://randomuser.me/api/portraits/women/3.jpg',
        createdAt: DateTime(2021, 11, 12),
        categoryId: 1,
        articleUrl: 'https://affirmcollege.com/how-to-become-a-chef-a-complete-guide/', // Placeholder news link
      ),
      BlogPost(
        id: 4,
        title: 'Simple & Delicious Vegetarian Lasagna',
        shortDescription: 'A classic comfort food made easy for vegetarian diets, bursting with flavor.',
        content: 'Learn how to make a creamy, rich, and satisfying vegetarian lasagna with fresh ingredients. This recipe is perfect for family dinners and meal prepping.',
        imageUrl: 'https://www.recipetineats.com/tachyon/2018/02/Vegetable-Lasagna_6.jpg?resize=964%2C1350&zoom=0.67',
        authorName: 'Leslie Alexander',
        authorAvatarUrl: 'https://randomuser.me/api/portraits/men/4.jpg',
        createdAt: DateTime(2021, 11, 12),
        categoryId: 2,
        articleUrl: 'https://www.recipetineats.com/vegetarian-lasagna/', // Placeholder news link
      ),
    ]);
  }

  Future<void> loadCategories() async {
    try {
      categories.value = await apiProvider.getCategories();
      if (categories.isEmpty) {
        categories.add(Category(id: 0, name: 'All', imageUrl: 'https://raw.githubusercontent.com/CodderPrince/CodderPrince/main/GithubCover.png'));
        categories.add(Category(id: 1, name: 'Cooking', imageUrl: 'https://example.com/cooking.png'));
        categories.add(Category(id: 2, name: 'Vegetarian', imageUrl: 'https://example.com/vegetarian.png'));
        categories.add(Category(id: 3, name: 'Desserts', imageUrl: 'https://example.com/desserts.png'));
      } else {
        if (!categories.any((cat) => cat.id == 0 && cat.name == 'All')) {
          categories.insert(0, Category(id: 0, name: 'All', imageUrl: 'https://raw.githubusercontent.com/CodderPrince/CodderPrince/main/GithubCover.png'));
        }
      }
    } catch (e) {
      print('Error fetching categories: $e');
      Get.snackbar('Error', 'Failed to load categories: $e');
    }
  }

  Future<void> deleteBlogPost(int blogPostId) async {
    try {
      await apiProvider.deleteBlogPost(blogPostId);
      blogPosts.removeWhere((post) => post.id == blogPostId);
      Get.snackbar('Success', 'Blog post deleted successfully!');
    } catch (e) {
      print('Error deleting blog post: $e');
      Get.snackbar('Error', 'Failed to delete blog posts: $e');
    }
  }

  Future<void> addBlogPost(BlogPost newPost) async {
    isLoading.value = true;
    try {
      int newId = (blogPosts.isEmpty ? 0 : blogPosts.map((e) => e.id).reduce((a, b) => a > b ? a : b)) + 1;
      final postWithId = BlogPost(
        id: newId,
        title: newPost.title,
        shortDescription: newPost.shortDescription,
        content: newPost.content,
        imageUrl: newPost.imageUrl,
        authorName: newPost.authorName,
        authorAvatarUrl: newPost.authorAvatarUrl,
        createdAt: DateTime.now(),
        categoryId: newPost.categoryId,
        articleUrl: newPost.articleUrl, // Include new field
      );
      blogPosts.add(postWithId);
      Get.snackbar('Success', 'Blog post added successfully!');
      Get.back();
    } catch (e) {
      print('Error adding blog post: $e');
      Get.snackbar('Error', 'Failed to add blog post: $e');
    } finally {
      isLoading.value = false;
    }
  }

  List<BlogPost> get filteredBlogPosts {
    List<BlogPost> currentPosts = blogPosts.toList();

    if (selectedCategoryId.value != 0) {
      currentPosts = currentPosts
          .where((blogPost) => blogPost.categoryId == selectedCategoryId.value)
          .toList();
    }

    if (searchQuery.value.isNotEmpty) {
      currentPosts = currentPosts
          .where((blogPost) => blogPost.title
          .toLowerCase()
          .contains(searchQuery.value.toLowerCase()) ||
          blogPost.shortDescription
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }

    return currentPosts;
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
  }

  void onCategorySelected(int categoryId) {
    selectedCategoryId.value = categoryId;
  }
}