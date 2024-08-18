import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:ignition_hacks/finance_data.dart';
import 'package:provider/provider.dart';

Future<String> runGemini(BuildContext context) async {
  final financialData = Provider.of<FinancialData>(context, listen: false);

  final apiKey = 'GEMINI_API_KEY';

  String trainingData =
      "Analyze the following financial data for a teenager. Based on the percentage of net monthly income and expenses, rate their financial situation on a scale from 1 to 10, with 10 being the best (mostly income) and 1 being the worst (mostly expenses). Provide up to three tips to help them improve their finances.  Return a JSON array where: - Index 0 contains the score (1-10). - Index 1 contains the first tip. - Index 2 contains the second tip. - Index 3 contains the third tip. Please give JSON data in a string, regular response format with no ```json```. Data: ${financialData.filterAi()}";

  final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
  final content = [
    Content.text('$trainingData \n\n${financialData.filterAi()}')
  ];
  final response = await model.generateContent(content);
  print(response.text);
  return Future.value(response.text);
}
