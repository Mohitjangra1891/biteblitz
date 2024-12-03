
import 'package:flutter/material.dart';

import '../../../../res/colors.dart';



class Monthly_Revenue_Chart extends StatelessWidget {
  // Sample data for the chart
  final List<ExpenseData> data = [
    ExpenseData(month: 'JAN', expense: 52000, maxExpense: 65000),
    ExpenseData(month: 'FEB', expense: 42000, maxExpense: 65000),
    ExpenseData(month: 'MAR', expense: 39000, maxExpense: 65000),
    ExpenseData(month: 'APR', expense: 45000, maxExpense: 65000),
    ExpenseData(month: 'MAY', expense: 35000, maxExpense: 65000),
    ExpenseData(month: 'JUN', expense: 65000, maxExpense: 65000),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: data
            .map(
              (expenseData) => ExpenseBar(
            month: expenseData.month,
            expense: expenseData.expense,
            maxExpense: expenseData.maxExpense,
          ),
        )
            .toList(),
      ),
    );
  }
}

class ExpenseBar extends StatelessWidget {
  final String month;
  final double expense;
  final double maxExpense;

  const ExpenseBar({
    required this.month,
    required this.expense,
    required this.maxExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        children: [
          // Month Label
          SizedBox(
            width: 40,
            child: Text(
              month,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500 ,color: AppColors.dark_text_color),
              textAlign: TextAlign.left,
            ),
          ),
          // Expense Progress Bar
          Expanded(
            child: Stack(
              children: [
                // Background Bar
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                // Foreground Progress Bar
                FractionallySizedBox(
                  widthFactor: expense / maxExpense,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.primary_orange_color,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Expense Value Label
          SizedBox(
            width: 60,
            child: Text(
              '\$${expense.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 12, color: AppColors.dark_text_color,fontWeight: FontWeight.w500 ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

// Model class for holding expense data
class ExpenseData {
  final String month;
  final double expense;
  final double maxExpense;

  ExpenseData({required this.month, required this.expense, required this.maxExpense});
}

