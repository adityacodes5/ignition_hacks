import 'package:flutter/material.dart';
import 'package:ignition_hacks/finance_data.dart';
import 'package:ignition_hacks/screens/expense_tracker.dart';
import 'package:ignition_hacks/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<FinancialItem> items;

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

  const Chart({super.key, required this.items});

  List<FinancialItem> get sortedItems {
    Map<IncomeCategory, double> categoryTotals = {};

    for (var item in items) {
      categoryTotals[item.category] =
          (categoryTotals[item.category] ?? 0) + item.value;
    }

    return categoryTotals.entries
        .map((entry) => FinancialItem(
              entry.key,
              entry.value,
              timestamp:
                  DateTime.now(), // Arbitrary timestamp since it's not needed
              note: '',
            ))
        .toList();
  }

  double get maxValue {
    return sortedItems
        .map((item) => item.value)
        .reduce((a, b) => a > b ? a : b);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: sortedItems.map((item) {
                final double fill = item.value / maxValue;
                return ChartBar(
                  fill: fill,
                  categoryIcon: iconPicker(item).keys.first,
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: sortedItems.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(
                  iconPicker(item).keys.first,
                  color: isDarkMode
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary.withOpacity(0.7),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
