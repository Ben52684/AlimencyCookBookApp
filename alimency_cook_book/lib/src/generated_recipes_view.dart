import 'package:flutter/material.dart';
import 'package:alimency_cook_book/src/view_models/recipe_model.dart';

class GeneratedRecipesView extends StatelessWidget {
  static const routeName = '/generated_recipes';

  // Accept the list of recipes as a parameter
  final List<RecipeModel>? recipes;

  const GeneratedRecipesView({Key? key, required this.recipes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 197, 223, 50),
      appBar: AppBar(
        title: const Text("Alimency"),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: recipes?.length,
          itemBuilder: (context, index) {
            final recipe = recipes?[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Recipe Title
                    Text(
                      recipe!.title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    // Ingredients
                    const Text(
                      'Ingredients:',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      recipe.ingredients,
                      style: const TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
