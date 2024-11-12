import 'dart:convert';
import 'package:alimency_cook_book/src/api_key_provider.dart';
import 'package:alimency_cook_book/src/view_models/ingredient_model.dart';
import 'package:http/http.dart' as http;

class GrokApiService {
  final String baseUrl = 'https://api.x.ai/v1/chat/completions'; // Base URL for Grok API
  
  // Future to load the API key from a file
  final Future<String> apiKey = ApiKeyProvider.loadApiKey(); 

  // Function to generate recipes using ingredients and sending them to Grok API
  Future<List<String>> generateRecipes(List<IngredientModel> ingredients) async {
    // Map the list of ingredients to a list of ingredient titles
    final ingredientNames = ingredients.map((ingredient) => ingredient.title).toList();

    try {
      // Fetch the API key
      final key = 'xai-iIjCVZwRufAsKQBb0El9lY5iCsf5XT082ZSOmYuTH7CW8vz7xNoT0oMEjciniimApz9IWxfvCI9R6Ar2'
;

      // Prepare the message for the API, using the ingredients in the user request
      final requestBody = jsonEncode({
        "messages": [
          {
            "role": "system",
            "content": "You are Grok, a chatbot inspired by the Hitchhikers Guide to the Galaxy."
          },
          {
            "role": "user",
            "content": "Can you generate recipes with the following ingredients: ${ingredientNames.join(', ')}?"
          }
        ],
        "model": "grok-beta", // Model identifier
        "stream": false, // Whether to stream responses or not
        "temperature": 0, // Set a low temperature for more deterministic output
      });

      // Send POST request to the Grok API
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $key',
        },
        body: requestBody,
      );

      // Handle the response from the API
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        // Assuming the response contains a list of recipes or related content
        final List<String> recipes = responseBody['choices']
            .map<String>((choice) => choice['message']['content'].toString())
            .toList();
        return recipes;
      } else {
        throw Exception("Failed to generate recipes: ${response.reasonPhrase}");
      }
    } catch (e) {
      // Catch errors and rethrow them for further handling
      throw Exception("Error generating recipes: $e");
    }
  }
}
