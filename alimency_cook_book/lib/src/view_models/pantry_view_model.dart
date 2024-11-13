import 'dart:convert';

import 'package:alimency_cook_book/src/grok_api_service.dart';
import 'package:alimency_cook_book/src/view_models/ingredient_model.dart';
import 'package:alimency_cook_book/src/repositories/ingredient_repository.dart';
import 'package:flutter/material.dart';

class PantryViewModel with ChangeNotifier {
  final GrokApiService _grokApiService = GrokApiService();
  final IngredientRepository _ingredientRepository;

  PantryViewModel(this._ingredientRepository);

  List<IngredientModel>? _ingredients = [];
  IngredientModel? _selectedIngredient;
  List<String> generatedRecipes = [];

  List<IngredientModel> get ingredients => _ingredients!;
  IngredientModel? get selectedNote => _selectedIngredient;

  Future<void> loadIngredients() async {
    await Future.delayed(Duration.zero);
    notifyListeners();
  }

  Future<void> addIngredient(IngredientModel ingredient) async {
    await Future.delayed(Duration.zero);
    _ingredients?.add(ingredient);
    notifyListeners();
    print(ingredient.title);
  }

  Future<void> updateIngredient(IngredientModel ingredient) async {
    await Future.delayed(Duration.zero);
    _ingredients?.removeWhere((item) => item.id == ingredient.id);
    _ingredients?.add(ingredient);
    notifyListeners();
  }

  Future<void> deleteIngredient(int id) async {
    await Future.delayed(Duration.zero);
    _ingredients?.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  Future<void> generateRecipesFromPantry() async {
    print("Loading Recipes");
    try {
      generatedRecipes = await _grokApiService.generateRecipes(ingredients);
      print(generatedRecipes);
      recipesToJson(generatedRecipes);
      notifyListeners();
    } catch (e) {
      print("Error generating recipes: $e");
    }
  }

  void recipesToJson(List<String> generatedRecipes) {
    // Combine all parts of the list into one large string
    String allRecipes = generatedRecipes.join("\n");

    // Split the long string into individual recipes by looking for '###' followed by a number and a dot
    List<String> recipes = allRecipes.split(RegExp(r'### \d+\.\s*'));

    if (recipes.isNotEmpty) recipes.removeAt(0);

    // List to hold the parsed recipes
    List<Map<String, String>> recipeData = [];

    // Process each recipe
    for (var recipe in recipes) {
      Map<String, String> parsedRecipe = _parseRecipe(recipe);
      recipeData.add(parsedRecipe);
    }

    // Convert the list of recipes into JSON
    String jsonRecipes = jsonEncode(recipeData);
    print(jsonRecipes);
  }

// Function to parse each recipe into a map with title, ingredients, and instructions
  Map<String, String> _parseRecipe(String recipe) {
    
    print(recipe);
    // Regular expressions to extract title, ingredients, and instructions
    final titleRegex = RegExp(r'^\s*(.*?)\s*\n\*\*Ingredients\:\*\*', multiLine: true);
    final ingredientsRegex = RegExp(r'\*\*Ingredients\:\*\*\n([\s\S]+?)\n\*\*Instructions\:\*\*');
    final instructionsRegex = RegExp(r'\*\*Instructions\:\*\*\n([\s\S]+)$');


    // Extract the title, ingredients, and instructions
    String title = _extractFirstMatch(recipe, titleRegex);
    String ingredients = _extractFirstMatch(recipe, ingredientsRegex);
    String instructions = _extractFirstMatch(recipe, instructionsRegex);

    return {
      'title': title,
      'ingredients': ingredients,
      'instructions': instructions,
    };
  }

// Helper function to extract the first match of the regex from the recipe text
  String _extractFirstMatch(String recipe, RegExp regex) {
    final match = regex.firstMatch(recipe);
    return match != null ? match.group(1) ?? '' : '';
  }
}
