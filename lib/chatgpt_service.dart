import 'dart:convert';
import 'package /http/http.dart' as http;
class ChatGPTService { 
  final String apiKey;
  final string apiUrl = "https://api.openai.com/v1/chat/completion";
  ChatGPTService ({required this.apiKey});
  Future <String> getBudgetAdvice (String budgetDetails) async { 
    final response = await http.post( 
      Uri.parse(apiUrl),
      headers: { 
        'Content-Type': 'application/jason',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model' : 'gpt-3.5-turbo',
        'messages' : [ 
          {'role': 'system', 'content': 'You are a helpful financial and budgeting assistant and your name is CoinCabin.'},
          {'role': 'user', 'content': budgetDetails},
          ],
        'max_tokens': 500,
      }),
      );
    if(response.statusCode ==200) {
      final data = jsonDecode(response.body);
      return data['choice'][0]['message']['content'];
    } else {
      throw Exception('Failed to get response from Chatgpt API');
    }
  }
}
