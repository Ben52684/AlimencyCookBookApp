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
                        ShowItemDetails(context, ingredient);
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
                      onPressed: () => Navigator.pushNamed(context, '/new_ingredient'),
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

void ShowItemDetails(BuildContext context, IngredientModel ingredientModel) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(ingredientModel.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Description: ${ingredientModel.title}"),
            SizedBox(height: 4),
            Text("Quantity: ${ingredientModel.quantity}"),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Okay'),
          ),
        ],
      );
    },
  );
}
