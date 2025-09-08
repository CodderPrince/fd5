// lib/features/home/ui/widgets/chef_promo_section.dart
import 'package:flutter/material.dart';

class ChefPromoSection extends StatelessWidget {
  const ChefPromoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10), // Optional: if the image itself should have rounded corners
            child: Image.asset(
              'assets/images/chef_promo.png', // Ensure this asset exists
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250, // Adjust height as needed
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Everyone can be a chef in their own kitchen',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Lorem ipsum dolor sit amet, consectetuipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua enim ad minim.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 180, // Fixed width for the button
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement "Learn More" action
                // debugPrint('Learn More tapped!');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Background color
                foregroundColor: Colors.white, // Text color
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
              ),
              child: const Text('Learn More', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}