import 'package:flutter/material.dart';
import 'package:ignition_hacks/finance_data.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool showIncome = false; // Toggle between showing income or expenses

  @override
  void initState() {
    super.initState();
    // Debugging: Ensure the test data is loaded
    print("Initializing ExpenseTracker");
    financeTest();
  }

  void financeTest() {
    financialData.filterAi(); // Debugging: Just to see if it runs
  }

  void _removeItem(FinancialItem item) {
    setState(() {
      print("Removing item with id: ${item.id}");
      financialData.removeItemById(item.id);
      print(
          "Items after removal: ${financialData.IncomeItems.length} incomes, ${financialData.ExpenseItems.length} expenses");
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Building ExpenseTracker widget");

    return Scaffold(
      body: Consumer<FinancialData>(
        builder: (context, financialData, child) {
          print("Consumer rebuilding");

          // Recalculate income and expenses after each change
          double income = financialData.reportIncome();
          double expenses = financialData.reportExpenses();

          List<FinancialItem> itemsToShow = showIncome
              ? List.from(financialData.IncomeItems)
              : List.from(financialData.ExpenseItems);

          itemsToShow.sort((a, b) => b.timestamp.compareTo(a.timestamp));

          return ListView.builder(
            itemCount: itemsToShow.length,
            itemBuilder: (context, index) {
              final item = itemsToShow[index];
              return Dismissible(
                key: Key(item.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: AlignmentDirectional.centerEnd,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  _removeItem(item);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Transaction deleted')),
                  );
                },
                child: ListTile(
                  title: Text(
                    "${item.note.isEmpty ? 'No note' : item.note} - \$${item.value.toStringAsFixed(2)}",
                  ),
                  subtitle: Text(
                    "${item.timestamp.month}/${item.timestamp.day}/${item.timestamp.year}",
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            showIncome = !showIncome;
          });
        },
        child: Icon(showIncome ? Icons.money : Icons.money_off),
      ),
    );
  }
}
