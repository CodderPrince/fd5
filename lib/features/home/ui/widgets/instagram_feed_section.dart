// lib/features/home/ui/widgets/instagram_feed_section.dart
import 'package:flutter/material.dart';

class InstagramFeedSection extends StatelessWidget {
  const InstagramFeedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> instagramImages = [
      'assets/images/instagram/insta1.png', // Ensure these assets exist
      'assets/images/instagram/insta2.png',
      'assets/images/instagram/insta3.png',
      'assets/images/instagram/insta4.png',
    ];

    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Check out @foodieland on Instagram',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: instagramImages.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 columns as per the image
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8, // Adjust aspect ratio to fit the vertical images
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  instagramImages[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: 220, // Fixed width for the button
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement action to open Instagram profile
                  // debugPrint('Visit Our Instagram tapped!');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Background color
                  foregroundColor: Colors.white, // Text color
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.arrow_forward), // Right arrow icon
                label: const Text('Visit Our Instagram', style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}