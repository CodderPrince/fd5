import 'package:flutter/material.dart';

class SimpleTastyRecipesSection extends StatelessWidget {
  const SimpleTastyRecipesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Simple and Tasty Recipes',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          // Add your Simple and Tasty Recipes list here
          // For example:
          // ListView.builder(
          //   shrinkWrap: true,
          //   physics: NeverScrollableScrollPhysics(),
          //   itemCount: 3, // example count
          //   itemBuilder: (context, index) {
          //     return ListTile(
          //       leading: Icon(Icons.food_bank),
          //       title: Text('Recipe ${index + 1}'),
          //       subtitle: Text('A delicious and easy recipe.'),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}