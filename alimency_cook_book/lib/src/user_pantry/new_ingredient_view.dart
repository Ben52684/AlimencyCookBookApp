import 'dart:math';

import 'package:alimency_cook_book/src/user_pantry/ingredient_model.dart';
import 'package:alimency_cook_book/src/view_models/pantry_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewIngredientView extends StatefulWidget {
  NewIngredientView({super.key});

  static const routeName = '/new_ingredient';

  @override
  State<NewIngredientView> createState() => _NewIngredientViewState();
}

class _NewIngredientViewState extends State<NewIngredientView> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<PantryViewModel>(
      builder: (context, pantryViewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text("Add Ingredient"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Title",
                      ),
                      controller: titleController,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Content",
                      ),
                      controller: contentController,
                      maxLines: 5,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                FloatingActionButton(
                  onPressed: () {
                    pantryViewModel.addIngredient(
                      IngredientModel(
                        id: Random().nextInt(1000),
                        title: titleController.text,
                        content: contentController.text,
                      ),
                    );
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Ingredient added!"))
                    );
                  },
                  child: Icon(Icons.save),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
