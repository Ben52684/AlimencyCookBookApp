import 'dart:convert';
import 'package:alimency_cook_book/src/grok_api_service.dart';
import 'package:alimency_cook_book/src/view_models/ingredient_model.dart';
import 'package:alimency_cook_book/src/repositories/ingredient_repository.dart';
import 'package:alimency_cook_book/src/view_models/recipe_model.dart';
import 'package:flutter/material.dart';

class PantryViewModel with ChangeNotifier {
  final GrokApiService _grokApiService = GrokApiService();
  final IngredientRepository _ingredientRepository;

  PantryViewModel(this._ingredientRepository);

  List<IngredientModel>? _ingredients = [];
  IngredientModel? _selectedIngredient;
  List<String> grokGeneratedRecipes = [];
  List<RecipeModel>? finalGeneratedRecipes;

  List<IngredientModel> get ingredients => _ingredients!;
  IngredientModel? get selectedIngredient => _selectedIngredient;

  // Load ingredients from the repository
  Future<void> loadIngredients() async {
    await Future.delayed(Duration.zero);
    notifyListeners();
  }

  // Add a new ingredient
  Future<void> addIngredient(IngredientModel ingredient) async {
    await Future.delayed(Duration.zero);
    _ingredients?.add(ingredient);
    notifyListeners();
    print(ingredient.title);
  }

  // Update an existing ingredient
  Future<void> updateIngredient(IngredientModel ingredient) async {
    await Future.delayed(Duration.zero);
    _ingredients?.removeWhere((item) => item.id == ingredient.id);
    _ingredients?.add(ingredient);
    notifyListeners();
  }

  // Delete an ingredient by ID
  Future<void> deleteIngredient(int id) async {
    await Future.delayed(Duration.zero);
    _ingredients?.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  // Generate recipes based on the current pantry items
  Future<void> generateRecipesFromPantry() async {
    print("Loading Recipes");
    try {
      grokGeneratedRecipes = await _grokApiService.generateRecipes(ingredients);
      recipesToJson(grokGeneratedRecipes);
      notifyListeners();
    } catch (e) {
      print("Error generating recipes: $e");
    }
  }

  // Convert recipes to JSON format
  void recipesToJson(List<String> grokGeneratedRecipes) {
    // Combine all recipes into one large string
    String allRecipes = grokGeneratedRecipes.join("\n");

    // Split the recipes using '---' as a delimiter
    List<String> recipes =
        allRecipes.split(RegExp(r'---+')).map((e) => e.trim()).toList();

    // Parse each recipe into a RecipeModel and store it
    finalGeneratedRecipes = recipes
        .where((recipe) => recipe.isNotEmpty) // Exclude empty entries
        .map((recipe) => _parseRecipeToModel(recipe)) // Convert to RecipeModel
        .where((recipe) => recipe != null) // Exclude null values
        .cast<RecipeModel>()
        .toList();

    // Convert RecipeModel list to JSON
    String jsonRecipes = jsonEncode(
      finalGeneratedRecipes!.map((recipe) => recipe.toJson()).toList(),
    );

    // Debugging: Print the JSON representation
    print(finalGeneratedRecipes);
  }

  // Parse a single recipe string into a RecipeModel
  RecipeModel? _parseRecipeToModel(String recipe) {
    final titleRegex = RegExp(r'\*\*Title\*\*:\s*(.+)', multiLine: true);
    final ingredientsRegex =
        RegExp(r'\*\*Ingredients\*\*:\s*([\s\S]+?)\n\s*\*\*Instructions\*\*');
    final instructionsRegex =
        RegExp(r'\*\*Instructions\*\*:\s*([\s\S]+)');

    String title = _extractFirstMatch(recipe, titleRegex);
    String ingredients = _extractFirstMatch(recipe, ingredientsRegex);
    String instructions = _extractFirstMatch(recipe, instructionsRegex);

    if (title.isEmpty || ingredients.isEmpty || instructions.isEmpty) {
      print("Failed to parse recipe: $recipe");
      return null; // Skip invalid recipes
    }

    return RecipeModel(
      title: title,
      ingredients: ingredients,
      instructions: instructions,
    );
  }

  // Extract the first match from a string using a regex
  String _extractFirstMatch(String recipe, RegExp regex) {
    final match = regex.firstMatch(recipe);
    return match != null && match.group(1) != null
        ? match.group(1)!.trim()
        : '';
  }
}
