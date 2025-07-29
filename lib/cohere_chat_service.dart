import 'dart:convert';
import 'package:http/http.dart' as http;

class CohereChatService {
  final String _apiKey =
      '3ZJTTu2uXiGroNkGR1UGA3LiZiBvzvRnK4jQIRbP'; // Replace with your actual key
  final String _endpoint = 'https://api.cohere.ai/v1/chat';

  Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse(_endpoint),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'message': message,
          'chat_history': [], // Optionally maintain context
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['text'] ?? "No response from Cohere.";
      } else {
        return "❌ Cohere API error: ${response.statusCode}\n${response.body}";
      }
    } catch (e) {
      return "⚠️ Failed to connect to Cohere: $e";
    }
  }
}
