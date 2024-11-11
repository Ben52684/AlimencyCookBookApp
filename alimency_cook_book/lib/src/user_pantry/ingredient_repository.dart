

import 'package:alimency_cook_book/src/user_pantry/ingredient_model.dart';

abstract class IngredientRepository {
  Future<List<IngredientModel>> getAllIngredients();
  Future<IngredientModel?> getIngredientById(int id);
  Future<void> addIngredient(IngredientModel note);
  Future<void> updateIngredient(IngredientModel note);
  Future<void> deleteIngredient(int id);
}