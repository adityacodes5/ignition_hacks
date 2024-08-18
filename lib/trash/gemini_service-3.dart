import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import from chatgpt

import 'dart:ffi';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:ignition_hacks/finance_data.dart';
//
//class GeminiService {
//  Future<String> getContent(String input) async {
//    // Access your API key as an environment variable (see "Set up your API key" above)
//    final apiKey = 'AIzaSyAKp2_wCUOAET7HVFYghGriTtl60wrEnYw';
//    if (apiKey == null) {
//      print('No \$API_KEY environment variable');
//      //exit(1);
//    }
//    // The Gemini 1.5 models are versatile and work with both text-only and multimodal prompts
//    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
//    final content = [Content.text(input)];
//    final response = await model.generateContent(content);
//    print(response.text);
//    return Future.value(response.text);
//  }
//
//  Future<String> evaluateFinancialData(
//      String inputContext, List<double> expenses) {
//    final Map<String, dynamic> incomeData = {
//      'total_income': {
//        'Savings': '',
//        'Work Income': '',
//        'Student Loans': '',
//        'Scholarship/Bursary/Grants': '',
//        'Other': '',
//      },
//      'total_expenses': {
//        'Housing': '',
//        'Tuition': '',
//        'Transportation': '',
//        'Food': '',
//        'Cell Phone': '',
//        'Clothing/laundry': '',
//        'Entertainment': '',
//        'Other': '',
//      }
//    };
//
//    // Convert to JSON string
//    String jsonString = jsonEncode(incomeData);
//    return Future.value();
//  }
//}

// GenerativeAIModel class simulates a generative AI model that can respond to financial queries.
class GenerativeAIModel {
  final String apiKey;

  GenerativeAIModel({required this.apiKey});

  // Simulating a response from a generative AI model based on input
  // You can replace this with actual API call if integrating with Google Generative AI
  Future<String> generateContent(String input) async {
    final responses = {
      all fina:
          "Based on your monthly income of \$5000, you're spending \$2600 on essentials. You can consider setting aside \$1000 for savings each month and reducing your entertainment budget slightly to save more.",
      "can you look at my acount and tell me how i can save up 400\$ in 6 months":
          "Based on your average monthly income of \$250, you're spending 100 on essentials and 50\$ on entertainment per month. You can consider setting aside \$70 for savings each month and reducing your entertainment budget to 30\$ each month",
      "I have \$2000 saved up, and I’m considering investing in either stocks or a high-yield savings account. What should I do?":
          "If you're seeking higher returns and are comfortable with some risk, consider investing in stocks. For more stable, low-risk growth, a high-yield savings account could be a better option."
    };

    return responses[input] ??
        "I'm sorry, maybe refrase that for me so I can better understand and help you better.";
  }
}

// GeminiService class to handle generative AI and financial data evaluation
class GeminiService {
  final GenerativeAIModel generativeAIModel;

  GeminiService(this.generativeAIModel);

  // Function to get content from GenerativeAIModel
  Future<String> getContent(String input) async {
    final response = await generativeAIModel.generateContent(input);
    print(response);
    return Future.value(response);
  }

  // Function to evaluate financial data based on input context and expenses
  Future<String> evaluateFinancialData(
      String inputContext, List<double> expenses) async {
    final dynamic financialData = {
      'total_income': {
        'Savings': '',
        'Work Income': '',
        'Student Loans': '',
        'Scholarship/Bursary/Grants': '',
        'Other': '',
      },
      'total_expenses': {
        'Housing': '',
        'Tuition': '',
        'Transportation': '',
        'Food': '',
        'Cell Phone': '',
        'Clothing/laundry': '',
        'Entertainment': '',
        'Other': '',
      },
    };

    // Process the inputContext and expenses as needed
    return Future.value(
        'Financial data evaluated based on input: $inputContext with expenses: $expenses.');
  }
}

// Main function to demonstrate the usage
void main() async {
  final generativeAIModel =
      GenerativeAIModel(apiKey: 'your_google_generative_ai_api_key');
  final geminiService = GeminiService(generativeAIModel);

  // Example 1: Get content using Google Generative AI (simulated)
  final content = await geminiService.getContent(
      'Evaluate my monthly expenses and provide suggestions for savings. My income is \$5000, and my monthly expenses include rent (\$1500), groceries (\$600), utilities (\$200), and entertainment (\$300).');
  print(content);

  // Example 2: Evaluate financial data
  final evaluation = await geminiService.evaluateFinancialData(
      'Analyze my financial data', [1000.0, 2000.0, 1500.0]);
  print(evaluation);
}
