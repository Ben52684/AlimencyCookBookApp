import 'dart:convert';
import 'package:alimency_cook_book/src/view_models/ingredient_model.dart';
import 'package:http/http.dart' as http;


class GrokApiService {
  
  final String baseUrl = 'https://api.x.ai/v1/chat/completions';
  
  Future<List<String>> generateRecipes(List<IngredientModel> ingredients) async {

    final ingredientMap = {for (var ingredient in ingredients) ingredient.title: ingredient.quantity};
    var content = "Can you generate your top 3 most popular recipes, these are my ingredients that I have available and their quantities, try not to be too experimental with recipes. Can you also make sure that the format you return them in is as follows Title : xyz, Ingredients: xyz, Instructions: xyz, with no intro or closing statement";
      ingredientMap.forEach((key, value) {
        content += "$key: $value, ";
      });

    try {
      final apiKey = const String.fromEnvironment('API_KEY');


      final requestBody = jsonEncode({
        "messages": [
          {
            "role": "system",
            "content": "You are Grok, a chatbot inspired by the Hitchhikers Guide to the Galaxy."
          },
          {
            "role": "user",
            "content": "${content}"
          }
        ],
        "model": "grok-beta", 
        "stream": false, 
        "temperature": 0, 
      });

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);

        final List<String> recipes = responseBody['choices']
            .map<String>((choice) => choice['message']['content'].toString())
            .toList();
        return recipes;
      } else {
        throw Exception("Failed to generate recipes: ${response.reasonPhrase}");
      }
    } catch (e) {
      throw Exception("Error generating recipes: $e");
    }
  }
}
