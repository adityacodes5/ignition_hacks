import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

enum IncomeCategory {
  savings,
  workIncome,
  studentLoans,
  scholarship,
  incomeOther,
  housing,
  tuition,
  transportation,
  food,
  cellPhone,
  clothingLaundry,
  entertainment,
  expenseOther
}

class FinancialItem {
  String id = const Uuid().v4();
  IncomeCategory category;
  double value;
  DateTime timestamp;
  String note;

  FinancialItem(this.category, this.value,
      {required this.timestamp, this.note = ''});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FinancialItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class FinancialData extends ChangeNotifier {
  List<FinancialItem> IncomeItems = [];
  List<FinancialItem> ExpenseItems = [];
  List<FinancialItem> BudgetItems = [];

  FinancialData() {
    // Automatically add test data when FinancialData is initialized
    testData();
  }

  void addBudget(double amount, IncomeCategory category) {
    // Check if a budget item already exists for the category
    final existingBudgetItem = BudgetItems.firstWhere(
      (item) => item.category == category,
      orElse: () => FinancialItem(category, 0, timestamp: DateTime.now()),
    );

    if (existingBudgetItem.value == 0) {
      // If no existing budget, add a new one
      BudgetItems.add(FinancialItem(
        category,
        amount,
        timestamp: DateTime.now(),
        note: 'Budget for ${category.name}',
      ));
    } else {
      // Update the existing budget value
      existingBudgetItem.value = amount;
    }

    notifyListeners();
  }

  double getBudget(IncomeCategory category) {
    final budgetItem = BudgetItems.firstWhere(
      (item) => item.category == category,
      orElse: () => FinancialItem(category, 0, timestamp: DateTime.now()),
    );

    return budgetItem.value;
  }

  List<FinancialItem> getBudgetItems() {
    return BudgetItems;
  }

  void testData() {
    addIncomeEntry(
        5000, DateTime.now(), IncomeCategory.savings, 'Saving my money');
    addIncomeEntry(100.00, DateTime.now(), IncomeCategory.workIncome,
        "Part-time job income");
    addIncomeEntry(
        50.00, DateTime.now(), IncomeCategory.incomeOther, "Gift from family");
    addIncomeEntry(100.00, DateTime.now(), IncomeCategory.workIncome,
        "Part-time job income");
    addIncomeEntry(200.00, DateTime.now(), IncomeCategory.scholarship,
        "Scholarship award");

    addExpenseEntry(
        120.00, DateTime.now(), IncomeCategory.housing, "Rent payment");
    addExpenseEntry(
        200.00, DateTime.now(), IncomeCategory.tuition, "Tuition payment");
    addExpenseEntry(
        30.00, DateTime.now(), IncomeCategory.transportation, "Gas Station");
    addExpenseEntry(15.00, DateTime.now(), IncomeCategory.food, "McDonald's");
    addExpenseEntry(50.00, DateTime.now(), IncomeCategory.entertainment,
        "Spotify subscription");
    addExpenseEntry(80.00, DateTime.now(), IncomeCategory.clothingLaundry,
        "Clothing store");
    addExpenseEntry(
        30.00, DateTime.now(), IncomeCategory.cellPhone, "Phone bill");
    addExpenseEntry(
        40.00, DateTime.now(), IncomeCategory.transportation, "Uber ride");
    addExpenseEntry(25.00, DateTime.now(), IncomeCategory.food, "Groceries");
    addExpenseEntry(
        20.00, DateTime.now(), IncomeCategory.entertainment, "Movie theater");
  }

  void addIncomeEntry(
      double amount, DateTime timestamp, IncomeCategory category, String note) {
    IncomeItems.add(
        FinancialItem(category, amount, timestamp: timestamp, note: note));
    notifyListeners();
  }

  void addExpenseEntry(
      double amount, DateTime timestamp, IncomeCategory category, String note) {
    ExpenseItems.add(
        FinancialItem(category, amount, timestamp: timestamp, note: note));
    notifyListeners();
  }

  double reportIncome() {
    double returnValue = 0.0;
    for (FinancialItem item in IncomeItems) {
      returnValue += item.value;
    }
    return returnValue;
  }

  double reportExpenses() {
    double returnValue = 0.0;
    for (FinancialItem item in ExpenseItems) {
      returnValue += item.value;
    }
    return returnValue;
  }

  void removeItemById(String id) {
    IncomeItems.removeWhere((item) => item.id == id);
    ExpenseItems.removeWhere((item) => item.id == id);
    BudgetItems.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  double reportCategory(IncomeCategory? category) {
    double returnValue = 0.0;
    for (FinancialItem item in ExpenseItems) {
      if (item.category == category) {
        returnValue += item.value;
      }
    }
    return returnValue;
  }

  String filterAi() {
    String items = '';
    List<String> finalItems = [];
    for (FinancialItem item in IncomeItems) {
      items =
          ("Financial Item (Income): category: ${item.category}, value: ${item.value}, timestamp: ${item.timestamp}, note: ${item.note}");
      finalItems.add(items);
    }
    for (FinancialItem item in ExpenseItems) {
      items =
          ("Financial Item (Expense): category: ${item.category}, value: ${item.value}, timestamp: ${item.timestamp}, note: ${item.note}");
      finalItems.add(items);
    }
    for (var item in BudgetItems) {
      items =
          ("Budget Item: category: ${item.category}, value: ${item.value}, timestamp: ${item.timestamp}, note: '${item.note}'");
      finalItems.add(items);
    }

    finalItems.add('Total Expenses: ${reportExpenses().toString()}');

    finalItems.add('Total Income: ${reportIncome().toString()}');

    print(finalItems);
    return finalItems.join('\n');
  }
}
