// lib/app/controllers/app_controller_binder.dart
import 'package:get/get.dart';

import '../../features/auth/controllers/auth_controller.dart';
import '../blog/controllers/blog_controller.dart';
import '../../features/home/controllers/home_controller.dart';
import '../../features/profile/controllers/profile_controller.dart';
import '../product/controllers/create_recipe_controller.dart'; // Import CreateRecipeController
import '../blog/controllers/create_blog_post_controller.dart'; // Import CreateBlogPostController

class AppControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => BlogController());

    // Make AuthController permanent
    Get.put<AuthController>(AuthController(), permanent: true);

    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => CreateRecipeController());
    Get.lazyPut(() => CreateBlogPostController());
  }
}
