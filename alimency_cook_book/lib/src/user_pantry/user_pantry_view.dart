import 'package:alimency_cook_book/src/view_models/ingredient_model.dart';
import 'package:alimency_cook_book/src/view_models/pantry_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPantry extends StatefulWidget {
  static const routeName = '/user_pantry';

  @override
  _UserPantryState createState() => _UserPantryState();
}

class _UserPantryState extends State<UserPantry> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

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
      body: Consumer<PantryViewModel>(
        builder: (context, pantryViewModel, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: pantryViewModel.ingredients.length,
                  itemBuilder: (context, index) {
                    final ingredient = pantryViewModel.ingredients[index];
                    return InkWell(
                      onTap: () {
                        ShowItemDetails(context, ingredient, pantryViewModel,
                            titleController, quantityController);
                      },
                      child: ListTile(
                        tileColor: Colors.white70,
                        title: Text(ingredient.title),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      child: const Icon(Icons.add),
                      onPressed: () =>
                          Navigator.pushNamed(context, '/new_ingredient'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void ShowItemDetails(
  BuildContext context,
  IngredientModel ingredient,
  PantryViewModel pantryViewModel,
  TextEditingController quantityController,
  TextEditingController titleController,
) {
  // Initialize the controllers with the ingredient's current values
  titleController.text = ingredient.title;
  quantityController.text = ingredient.quantity.toString();

  IngredientModel updatedIngredient = IngredientModel(
    id: ingredient.id,
    title: ingredient.title,
    quantity: ingredient.quantity,
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(ingredient.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration:
                  InputDecoration(hintText: "Ingredient: ${ingredient.title}"),
            ),
            TextField(
              controller: quantityController,
              decoration:
                  InputDecoration(hintText: "Quantity: ${ingredient.quantity}"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              pantryViewModel.deleteIngredient(ingredient.id);
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          ),
          TextButton(
            onPressed: () {
              // Check if the text has changed, and if so, update the ingredient
              String? newTitle = titleController.text;
              String? newQuantity = quantityController.text;

              // Only update if there's a change
              if (newTitle != ingredient.title ||
                  newQuantity != ingredient.quantity) {
                updatedIngredient = updatedIngredient.copyWith(
                  title: newTitle,
                  quantity: newQuantity,
                );

                // Save the updated ingredient
                pantryViewModel.updateIngredient(updatedIngredient);
              }

              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      );
    },
  );
}
