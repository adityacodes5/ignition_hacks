import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ignition_hacks/finance_data.dart'; // Adjust this import to your file structure

class NewBudget extends StatefulWidget {
  const NewBudget({super.key});

  @override
  State<NewBudget> createState() {
    return _NewBudgetState();
  }
}

class _NewBudgetState extends State<NewBudget> {
  final _amountController = TextEditingController();
  IncomeCategory _selectedCategory = IncomeCategory.expenseOther;

  List<IncomeCategory> expenseOptions = [
    IncomeCategory.studentLoans,
    IncomeCategory.housing,
    IncomeCategory.tuition,
    IncomeCategory.transportation,
    IncomeCategory.food,
    IncomeCategory.cellPhone,
    IncomeCategory.clothingLaundry,
    IncomeCategory.entertainment,
    IncomeCategory.expenseOther,
  ];

  String getCategoryDisplayName(IncomeCategory category) {
    switch (category) {
      case IncomeCategory.studentLoans:
        return "Student Loans";
      case IncomeCategory.housing:
        return "Housing";
      case IncomeCategory.tuition:
        return "Tuition";
      case IncomeCategory.transportation:
        return "Transportation";
      case IncomeCategory.food:
        return "Food";
      case IncomeCategory.cellPhone:
        return "Cell Phone";
      case IncomeCategory.clothingLaundry:
        return "Clothing & Laundry";
      case IncomeCategory.entertainment:
        return "Entertainment";
      case IncomeCategory.expenseOther:
        return "Other Expenses";
      default:
        return category.name;
    }
  }

  void _submitBudgetData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (amountIsInvalid) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: Text('Invalid Input'),
                content:
                    const Text('Please make sure a valid amount was entered'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text("Okay"))
                ],
              ));
      return;
    }

    // Access the FinancialData from Provider to save the budget
    final financialData = Provider.of<FinancialData>(context, listen: false);

    financialData.addBudget(
      enteredAmount,
      _selectedCategory,
    );

    // Close the screen after saving the budget
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Budget'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<IncomeCategory>(
              value: _selectedCategory,
              isExpanded: true,
              items: expenseOptions
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(getCategoryDisplayName(category)),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              maxLength: 50,
              decoration: const InputDecoration(
                prefixText: '\$ ',
                label: Text("Budget Amount"),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: _submitBudgetData,
                  child: const Text("Save Budget"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
