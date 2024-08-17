import 'dart:convert';
import 'package /http/http.dart' as http;
class GoogleGeminiService { 
  final String apiKey;
  final string apiUrl;
  GoogleGeminiService ({required this.apiKey, required this.apiUrl});
  Future <String> getBudgetAdvice (String budgetDetails) async { 
    final response = await http.post( 
      Uri.parse(apiUrl),
      headers: { 
        'Content-Type': 'application/jason',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'instances' : [ 
          {'budget_details' : budget Details},
          ],
           'parameters':
        {'maxOutputTokens'= 300},
      }),
      );
    if(response.statusCode ==200) {
      final data = jsonDecode(response.body);
      return data['predictions'][0]['putput'];
    } else {
      throw Exception('Failed to get response from GoogleGmini');
    }
  }
}
void main() {
   final GoogleGeminiService =       GoogleGeminiService(
     apiKey : 'AIzaSyAKp2_wCUOAET7HVFYghGriTtl60wrEnYw'
  );

  String userBudgetDetails = "I have $1000 income and $500 expenses";

  googleGeminiService.getBudgetAdvice(userBudgetDetails).then((advice) {
    print("AI's Budget Advice: $advice");
  }).catchError((error) {
    print("Error: $error");
  });
}