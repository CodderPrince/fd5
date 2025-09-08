// lib/features/home/ui/widgets/app_footer.dart
import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: Colors.white, // Assuming a white background for the footer area
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Foodieland',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Lorem ipsum dolor sit amet, consectetuipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua enim ad minim.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 20),
          // Navigation links
          Wrap(
            spacing: 20, // Horizontal space between links
            runSpacing: 10, // Vertical space between wrapped links
            alignment: WrapAlignment.center,
            children: [
              TextButton(onPressed: () {}, child: const Text('Home', style: TextStyle(color: Colors.black))),
              TextButton(onPressed: () {}, child: const Text('Recipes', style: TextStyle(color: Colors.black))),
              TextButton(onPressed: () {}, child: const Text('Blog', style: TextStyle(color: Colors.black))),
              TextButton(onPressed: () {}, child: const Text('Contact', style: TextStyle(color: Colors.black))),
              TextButton(onPressed: () {}, child: const Text('About Us', style: TextStyle(color: Colors.black))),
            ],
          ),
          const Divider(height: 40, thickness: 1, color: Colors.grey), // Separator line
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '© 2020 Flowbase. Powered by ',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text('Webflow',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black),)
            ],
          ),
        ],
      ),
    );
  }
}