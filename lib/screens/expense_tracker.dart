import 'package:flutter/material.dart';
import 'package:ignition_hacks/finance_data.dart';
import 'package:ignition_hacks/widgets/custom_circle.dart';
import 'package:provider/provider.dart';

class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({super.key});

  @override
  _ExpenseTrackerState createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  FinancialData? financialData;
  int selectedTabIndex = 0; // 0: Expenses, 1: Income, 2: Budget

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        financialData = Provider.of<FinancialData>(context, listen: false);
        financeTest();
      });
    });
  }

  void _sortData(List<FinancialItem> items) {
    items.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  void financeTest() {
    if (financialData != null) {
      financialData!.filterAi();
    }
  }

  void _removeItem(FinancialItem item) {
    setState(() {
      financialData?.removeItemById(item.id);
    });
  }

  double _calculateNetTotal(double income, double expenses) {
    return income - expenses;
  }

  double _calculateGreenPercentage(double income, double expenses) {
    return income / (income + expenses);
  }

  double _calculateRedPercentage(double income, double expenses) {
    return expenses / (income + expenses);
  }

  Map<IconData, String> iconPicker(FinancialItem item) {
    switch (item.category) {
      case IncomeCategory.savings:
        return {Icons.save: 'Savings'};
      case IncomeCategory.workIncome:
        return {Icons.work: 'Work Income'};
      case IncomeCategory.studentLoans:
        return {Icons.school: 'Student Loans'};
      case IncomeCategory.scholarship:
        return {Icons.school: 'Scholarship'};
      case IncomeCategory.incomeOther:
        return {Icons.monetization_on: 'Other Income'};
      case IncomeCategory.housing:
        return {Icons.house: 'Housing'};
      case IncomeCategory.tuition:
        return {Icons.school: 'Tuition'};
      case IncomeCategory.transportation:
        return {Icons.directions_car: 'Transportation'};
      case IncomeCategory.food:
        return {Icons.fastfood: 'Food'};
      case IncomeCategory.cellPhone:
        return {Icons.phone: 'Cell Phone'};
      case IncomeCategory.clothingLaundry:
        return {Icons.shopping_bag: 'Clothing/Laundry'};
      case IncomeCategory.entertainment:
        return {Icons.movie: 'Entertainment'};
      case IncomeCategory.expenseOther:
        return {Icons.monetization_on: 'Other'};
      default:
        return {Icons.monetization_on: 'Other'};
    }
  }

  Widget financeCard(FinancialItem item) {
    return Consumer<FinancialData>(
      builder: (context, financialData, child) {
        return Dismissible(
          key: Key(item.id),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: AlignmentDirectional.centerEnd,
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          onDismissed: (direction) {
            _removeItem(item);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Transaction deleted')),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.25),
                    offset: Offset(0, 4),
                    blurStyle: BlurStyle.normal,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(iconPicker(item).keys.first, color: Colors.black),
                        SizedBox(height: 4),
                        Text(
                          '${iconPicker(item).values.first}',
                          style: TextStyle(fontSize: 10),
                        ),
                        SizedBox(height: 4),
                        Text(
                          item.note.isNotEmpty ? item.note : 'No note',
                          style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${item.value.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "${item.timestamp.month}/${item.timestamp.day}/${item.timestamp.year}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget budgetCard(FinancialItem item) {
    return Consumer<FinancialData>(
      builder: (context, financialData, child) {
        double spent = financialData?.reportCategory(item.category) ?? 0.0;
        double budget = financialData?.getBudget(item.category) ?? 0.0;
        double percentageSpent = spent / budget;

        return Dismissible(
          key: Key(item.id),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: AlignmentDirectional.centerEnd,
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          onDismissed: (direction) {
            financialData?.removeItemById(item.id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Budget deleted')),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.25),
                    offset: Offset(0, 4),
                    blurStyle: BlurStyle.normal,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 64,
                          width: 64,
                          child: CircularProgressIndicator(
                            value:
                                percentageSpent > 1.0 ? 1.0 : percentageSpent,
                            backgroundColor: Colors.green,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.red),
                          ),
                        ),
                        Text(
                          "\$${spent.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: spent > budget ? Colors.red : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Budget: \$${budget.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          item.note,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildTabContent(List<FinancialItem> items) {
    if (items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Click the + on the menu bar to get started',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (selectedTabIndex == 2) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: items.map((item) => budgetCard(item)).toList(),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: items.map((item) => financeCard(item)).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FinancialData>(
        builder: (context, financialData, child) {
          double income = financialData.reportIncome();
          double expenses = financialData.reportExpenses();

          List<FinancialItem> sortedIncomeItems =
              List.from(financialData.IncomeItems);
          List<FinancialItem> sortedExpenseItems =
              List.from(financialData.ExpenseItems);

          _sortData(sortedIncomeItems);
          _sortData(sortedExpenseItems);

          List<FinancialItem> itemsToShow;

          if (selectedTabIndex == 0) {
            itemsToShow = sortedExpenseItems;
          } else if (selectedTabIndex == 1) {
            itemsToShow = sortedIncomeItems;
          } else {
            itemsToShow = financialData.getBudgetItems();
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset("lib/assets/background.png"),
                    Column(
                      children: [
                        SizedBox(height: 60),
                        Center(
                          child: CustomCircularIndicator(
                            greenPercentage:
                                _calculateGreenPercentage(income, expenses),
                            amount: _calculateNetTotal(income, expenses),
                            redPercentage:
                                _calculateRedPercentage(income, expenses),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, top: 215, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 125,
                            height: 64,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 108, 209, 1),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.15),
                                  offset: Offset(0, 4),
                                  blurStyle: BlurStyle.normal,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0, vertical: 8),
                              child: Column(
                                children: [
                                  Text("Total Income: ",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600)),
                                  Text("\$$income",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 125,
                            height: 64,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 108, 209, 1),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.15),
                                  offset: Offset(0, 4),
                                  blurStyle: BlurStyle.normal,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0, vertical: 8),
                              child: Column(
                                children: [
                                  Text("Total Expenses: ",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600)),
                                  Text("\$$expenses",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ToggleButtons(
                    borderRadius: BorderRadius.circular(20),
                    selectedColor: Colors.white,
                    fillColor: Color.fromRGBO(0, 108, 209, 1),
                    color: Colors.black,
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width / 3.5,
                      minHeight: 40,
                    ),
                    isSelected: [
                      selectedTabIndex == 0,
                      selectedTabIndex == 1,
                      selectedTabIndex == 2,
                    ],
                    onPressed: (int index) {
                      setState(() {
                        selectedTabIndex = index;
                      });
                    },
                    children: const [
                      Text("Expenses"),
                      Text("Incomes"),
                      Text("Budget"),
                    ],
                  ),
                ),
                buildTabContent(itemsToShow),
              ],
            ),
          );
        },
      ),
    );
  }
}
