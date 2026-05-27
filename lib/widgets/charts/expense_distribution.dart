import 'package:expensetrackerui/core/components/charts/gradient_donut.dart';
import 'package:flutter/material.dart';

class ExpenseDistribution extends StatelessWidget {
  const ExpenseDistribution({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        spacing: 8,
        children: [
          expenseItem('Annaprasan', '48.89%', [Colors.blue, Colors.blueAccent]),
          expenseItem('Travel', '11.46%', [Colors.orange, Colors.orangeAccent]),
          expenseItem('Home', '10%', [Colors.purple, Colors.purpleAccent]),
          expenseItem('Education', '6.56%', [Colors.green, Colors.greenAccent]),
          expenseItem('Other', '22.95%', [Colors.red, Colors.redAccent]),
        ],
      ),
    );
  }

  Widget expenseItem(String text, String value, List<Color> sliceColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [expenseItemText(text, sliceColor), expenseItemValue(value)],
    );
  }

  Text expenseItemValue(String value) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.grey[700],
      ),
    );
  }

  Row expenseItemText(String text, List<Color> sliceColors) {
    return Row(
      spacing: 4,
      children: [
        SimpleGradientDonut(colors: sliceColors, size: 16, strokeWidth: 5),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
