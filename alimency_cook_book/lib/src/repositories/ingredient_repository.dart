

import 'package:alimency_cook_book/src/view_models/ingredient_model.dart';

abstract class IngredientRepository {
  Future<List<IngredientModel>> getAllIngredients();
  Future<IngredientModel?> getIngredientById(int id);
  Future<void> addIngredient(IngredientModel ingredient);
  Future<void> updateIngredient(IngredientModel ingredient);
  Future<void> deleteIngredient(int id);
}