

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
    print("Notes Loaded");
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
      notifyListeners();
    } catch (e) {
      print("Error generating recipes: $e");
    }
  }
}