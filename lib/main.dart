import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';

import 'app/routes/app_routes.dart';
import 'app/theme/app_theme.dart';
import 'app/controllers/app_controller_binder.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: 'https://thneabplfbyoawwnyarg.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRobmVhYnBsZmJ5b2F3d255YXJnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY2NDk5MTMsImV4cCI6MjA3MjIyNTkxM30.pzSBNVAcMHm9_xrZLAkqJLg40fH_bKlkMR3DSpIqVmM'
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Foodieland',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,

      // 👇 Don’t jump directly into /home
      //initialRoute: AppRoutes.login, // Start with login (or splash)
      initialRoute: '/home',
      getPages: AppRoutes.routes,
      initialBinding: AppControllerBinder(), // Controllers loaded once
    );
  }
}
