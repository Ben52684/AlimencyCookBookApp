
class IngredientModel {
  late final int id;
  late final String title;
  late final String quantity;

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
   
  IngredientModel copyWith({int? id, String? title, String? quantity}) {
    return IngredientModel(
      id: id ?? this.id,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
    );
  }
}