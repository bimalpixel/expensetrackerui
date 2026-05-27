import 'package:flutter/material.dart';

class ExpenseDistribution extends StatelessWidget {
  const ExpenseDistribution({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        expenseItem('Annaprasan', '48.89%'),
        expenseItem('Travel', '11.46%'),
        expenseItem('Home', '10%'),
        expenseItem('Education', '6.56%'),
        expenseItem('Other', '22.95%'),
      ],
    );
  }

  Widget expenseItem(String text, String value) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [expenseItemText(text), expenseItemValue(value)],
    );
  }

  Text expenseItemValue(String value) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.grey[700],
      ),
    );
  }

  Text expenseItemText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.grey[700],
      ),
    );
  }
}
