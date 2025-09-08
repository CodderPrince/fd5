import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HotRecipesSection extends StatelessWidget {
  const HotRecipesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example local recipes
    final recipes = [
      {'name': 'Pizza', 'image': 'assets/images/recipes/pizza.png'},
      {'name': 'Burger', 'image': 'assets/images/recipes/burger.png'},
      {'name': 'Fried Chicken', 'image': 'assets/images/recipes/fried_chicken.png'},
    ];

    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Hot Recipes',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enlargeCenterPage: false,
                viewportFraction: 1.0,
              ),
              items: recipes.map((recipe) {
                return Builder(
                  builder: (context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        recipe['image']!,
                        width: double.infinity,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}