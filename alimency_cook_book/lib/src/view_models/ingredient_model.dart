
class IngredientModel {
  final int id;
  final String title;
  final String quantity;

  IngredientModel({
    required this.id,
    required this.title,
    required this.quantity,
  });

  Map <String, dynamic> toJson() {
    return {

      'id' : id,
      'title' : title,
      'quantity' : quantity
    };
  }

  factory IngredientModel.fromJson(Map<String, dynamic> json ) {

    return IngredientModel(
      id: json['id'], 
      title: json['title'], 
      quantity: json['content']
      );
  }
}