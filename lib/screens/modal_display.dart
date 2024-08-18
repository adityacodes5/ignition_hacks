import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ignition_hacks/finance_data.dart'; // Adjust this import to your file structure

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  IncomeCategory _selectedCategory = IncomeCategory.expenseOther;
  String _selectedType = 'Expense';

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

  List<IncomeCategory> incomeOptions = [
    IncomeCategory.savings,
    IncomeCategory.workIncome,
    IncomeCategory.scholarship,
    IncomeCategory.incomeOther,
  ];

  List<IncomeCategory> currentOptions = [];

  @override
  void initState() {
    super.initState();
    _filterCategories();
  }

  void _filterCategories() {
    if (_selectedType == 'Income') {
      currentOptions = incomeOptions;
      _selectedCategory = IncomeCategory.savings;
    } else {
      currentOptions = expenseOptions;
      _selectedCategory = IncomeCategory.expenseOther;
    }
  }

  String getCategoryDisplayName(IncomeCategory category) {
    switch (category) {
      case IncomeCategory.savings:
        return "Savings";
      case IncomeCategory.workIncome:
        return "Work Income";
      case IncomeCategory.studentLoans:
        return "Student Loans";
      case IncomeCategory.scholarship:
        return "Scholarship";
      case IncomeCategory.incomeOther:
        return "Other Income";
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

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: Text('Invalid Input'),
                content: const Text(
                    'Please make sure a valid amount, date, and category were entered'),
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

    // Access the FinancialData from Provider
    final financialData = Provider.of<FinancialData>(context, listen: false);

    if (_selectedType == 'Income') {
      financialData.addIncomeEntry(
        enteredAmount,
        _selectedDate!,
        _selectedCategory,
        _titleController.text,
      );
    } else {
      financialData.addExpenseEntry(
        enteredAmount,
        _selectedDate!,
        _selectedCategory,
        _titleController.text,
      );
    }

    // Close the screen after saving the transaction
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text("Note"),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  width: 140,
                  child: DropdownButton<String>(
                    value: _selectedType,
                    items: ['Income', 'Expense']
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value!;
                        _filterCategories();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButton<IncomeCategory>(
                    value: _selectedCategory,
                    isExpanded: true,
                    items: currentOptions
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
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              maxLength: 50,
              decoration: const InputDecoration(
                prefixText: '\$ ',
                label: Text("Amount"),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No Date Chosen'
                        : "${_selectedDate!.month}/${_selectedDate!.day}/${_selectedDate!.year}",
                  ),
                ),
                IconButton(
                  onPressed: _presentDatePicker,
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
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
                  onPressed: _submitExpenseData,
                  child: const Text("Save Transaction"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
