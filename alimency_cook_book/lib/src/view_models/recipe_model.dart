class RecipeModel {
  final String title;
  final String ingredients;
  final String instructions;

  RecipeModel({
    required this.title,
    required this.ingredients,
    required this.instructions,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'ingredients': ingredients,
      'instructions': instructions
    };
  }

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
        title: json['title'],
        ingredients: json['ingredients'],
        instructions: json['instructions']);
  }

  RecipeModel copyWith({int? id, String? title, String? quantity}) {
    return RecipeModel(
      title: title ?? this.title,
      ingredients: ingredients,
      instructions: instructions,
    );
  }
}
