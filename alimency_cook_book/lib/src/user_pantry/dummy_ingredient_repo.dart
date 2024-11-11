
import 'package:alimency_cook_book/src/user_pantry/ingredient_model.dart';
import 'package:alimency_cook_book/src/user_pantry/ingredient_repository.dart';


class DummyIngredientRepo extends IngredientRepository{

  late List<IngredientModel> dummyIngredients;

  @override
  Future<void> addIngredient(IngredientModel note) async {    
    dummyIngredients.add(note);
    throw UnimplementedError();
  }

  @override
  Future<void> deleteIngredient(int id) async {
    dummyIngredients.removeWhere((item) => item.id == id);    
    throw UnimplementedError();
  }

  @override
  Future<List<IngredientModel>> getAllIngredients() async {
    return dummyIngredients;
  }

  @override
  Future<IngredientModel?> getIngredientById(int id) async {
    try {
    return dummyIngredients.firstWhere((item) => item.id == id);
    } catch (e) {
    return null;
    }
  }

  @override
  Future<void> updateIngredient(IngredientModel note) async {
    await Future.delayed(Duration.zero);
    dummyIngredients.removeWhere((item) => item.id == note.id);
    dummyIngredients.add(note);
    throw UnimplementedError();
  }
}