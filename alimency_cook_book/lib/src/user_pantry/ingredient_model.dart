
class IngredientModel {
  final int id;
  final String title;
  final String content;

  IngredientModel({
    required this.id,
    required this.title,
    required this.content,
  });

  Map <String, dynamic> toJson() {
    return {

      'id' : id,
      'title' : title,
      'content' : content
    };
  }

  factory IngredientModel.fromJson(Map<String, dynamic> json ) {

    return IngredientModel(
      id: json['id'], 
      title: json['title'], 
      content: json['content']
      );
  }
}