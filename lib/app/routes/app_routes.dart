// lib/app/routes/app_routes.dart
import 'package:get/get.dart';

import '../../features/auth/ui/screens/login_screen.dart';
import '../../features/auth/ui/screens/signup_screen.dart';
import '../../features/auth/ui/screens/splash_screen.dart';
import '../blog/controllers/blog_controller.dart';
import '../blog/ui/screen/blog_screen.dart';
import '../../features/contact/ui/screens/contact_us_screen.dart';
import '../../features/home/ui/screens/home_screen.dart';
import '../../features/profile/ui/screens/profile_screen.dart';

import '../../features/recipe/ui/screens/all_recipes_screen.dart';
import '../../features/recipe/ui/screens/recipe_detail_screen.dart';

import '../blog/ui/screen/create_blog_post_screen.dart';
import '../blog/ui/screen/edit_blog_post_screen.dart';
import '../data/models/recipe.dart';
import '../middleware/auth_middleware.dart'; // AuthMiddleware is not a const class

import '../product/bindings/edit_recipe_binding.dart'; // Bindings are not const
import '../product/ui/screens/add_ingredients_steps_screen.dart';
import '../product/ui/screens/create_recipe_screen.dart';
import '../product/ui/screens/edit_recipe_screen.dart';
import '../../features/home/ui/screens/all_categories_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String blog = '/blog';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String profile = '/profile';
  static const String createRecipe = '/create-recipe';
  static const String createBlogPost = '/create-blog-post';
  static const String editRecipe = '/edit-recipe/:recipeId';
  static const String editBlogPost = '/edit-blog-post/:blogPostId';
  static const String allCategories = '/all-categories';
  static const String allRecipes = '/recipes';
  static const String contact = '/contact';
  static const String recipeDetail = '/recipe-detail';
  static const String addIngredientsSteps = '/add-ingredients-steps';


  static final routes = [
    // Remove 'const' from GetPage constructor itself if it has dynamic parts (middlewares, bindings, dynamic page lambdas)
    // Keep 'const' on the screen widget constructor if it's a const constructor.
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: signup, page: () => SignupScreen()),
    GetPage(name: home, page: () => const HomeScreen(), middlewares: [AuthMiddleware()]),
    GetPage(
      name: blog,
      page: () => const BlogScreen(),
      middlewares: [AuthMiddleware()],
      binding: BindingsBuilder(() {
        Get.lazyPut<BlogController>(() => BlogController(), fenix: true);
      }),
    ),

    GetPage(name: profile, page: () => ProfileScreen(), middlewares: [AuthMiddleware()]),
    GetPage(name: createRecipe, page: () => const CreateRecipeScreen(), middlewares: [AuthMiddleware()]),
    GetPage(name: createBlogPost, page: () => CreateBlogPostScreen(), middlewares: [AuthMiddleware()]),
    GetPage(name: editRecipe, page: () => const EditRecipeScreen(), binding: EditRecipeBinding(), middlewares: [AuthMiddleware()]),
    GetPage(name: editBlogPost, page: () => EditBlogPostScreen(), middlewares: [AuthMiddleware()]),
    GetPage(name: allCategories, page: () => const AllCategoriesScreen(), middlewares: [AuthMiddleware()]),
    GetPage(name: allRecipes, page: () => const AllRecipesScreen(), middlewares: [AuthMiddleware()]),
    GetPage(name: contact, page: () => const ContactUsScreen(), middlewares: [AuthMiddleware()]),
    GetPage(
      name: recipeDetail,
      page: () {
        final recipe = Get.arguments as Recipe;
        return RecipeDetailScreen(recipe: recipe); // Cannot be const because 'recipe' is a dynamic argument
      },
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: addIngredientsSteps,
      page: () {
        final recipeInitialData = Get.arguments as Map<String, dynamic>;
        return AddIngredientsStepsScreen(recipeInitialData: recipeInitialData); // Cannot be const because 'recipeInitialData' is a dynamic argument
      },
      middlewares: [AuthMiddleware()],
    ),
  ];
}