import 'dart:io';

class ApiKeyProvider {
  // Adjust the file path as needed
  static Future<String> loadApiKey() async {
    try {
      final file = File('/home/benjamin/Documents/grok_api_key.txt'); // Use the correct path
      return await file.readAsString();
    } catch (e) {
      throw Exception("Error reading API key: $e");
    }
  }
}
