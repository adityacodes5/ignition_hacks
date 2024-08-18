import 'package:flutter/material.dart';
import 'package:ignition_hacks/gemini_service.dart';
import 'package:ignition_hacks/widgets/custom_loading_animation.dart'; // Adjust the path if necessary
import 'dart:convert'; // For json decoding

class AiEvaluateModal extends StatefulWidget {
  @override
  _AiEvaluateModalState createState() => _AiEvaluateModalState();
}

class _AiEvaluateModalState extends State<AiEvaluateModal> {
  bool isLoading = true;
  int? score;
  List<String> tips = [];

  @override
  void initState() {
    super.initState();
    fetchEvaluationData();
  }

  Future<void> fetchEvaluationData() async {
    String jsonData =
        await runGemini(context); // Assume this returns a JSON string
    final data = jsonDecode(jsonData);

    setState(() {
      score = int.parse(data[0] as String); // Parse the score as an integer
      tips = [
        data[1] as String,
        data[2] as String,
        data[3] as String
      ]; // Ensure tips are strings
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          MediaQuery.of(context).size.height * 0.7, // Adjust height as needed
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
      child: isLoading
          ? CustomLoadingAnimation() // Use the custom loading animation
          : SingleChildScrollView(
              // Make the modal scrollable
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (score != null) FinancialScaleWidget(score: score!),
                  if (tips.isNotEmpty) TipsWidget(tips: tips),
                ],
              ),
            ),
    );
  }
}

class TipsWidget extends StatelessWidget {
  final List<String> tips;

  TipsWidget({required this.tips});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tips',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ...tips.map((tip) => Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                tip,
                style: TextStyle(fontSize: 16),
              ),
            )),
      ],
    );
  }
}

class FinancialScaleWidget extends StatelessWidget {
  final int score;

  FinancialScaleWidget({required this.score});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Your Financial Score',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(10, (index) {
            int scaleValue = index + 1;
            return Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 2),
                height: 20,
                decoration: BoxDecoration(
                  color: getColorForScore(scaleValue),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: scaleValue == score
                    ? Center(
                        child: Text(
                          '$scaleValue',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : null,
              ),
            );
          }),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Color getColorForScore(int value) {
    // Calculate the color based on the score
    if (value <= 3) {
      return Colors.red;
    } else if (value <= 6) {
      return Colors.orange;
    } else if (value <= 8) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }
}
