import 'package:expensetrackerui/widgets/home/home_date_row.dart';
import 'package:expensetrackerui/widgets/home/home_item_row.dart';
import 'package:flutter/material.dart';

class HomeItemGroup extends StatelessWidget {
  const HomeItemGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Column(
        children: [
          HomeDateRow(
            date: 'May 16',
            day: 'Saturday',
            expenses: 'Expenses: 11,500',
          ),
          HomeItemRow(
            title: 'Chicken',
            amount: '-370',
            icon: Icons.restaurant,
            iconColor: Color(0xFF00D294),
          ),
          HomeItemRow(
            title: 'Ring',
            amount: '-4200',
            icon: Icons.group,
            iconColor: Color(0xFF00ADDD),
          ),
          HomeItemRow(
            title: 'Petrol',
            amount: '-515',
            icon: Icons.directions_bus_outlined,
            iconColor: Color(0xFFDC9483),
          ),
          HomeItemRow(
            title: 'Scooter repair',
            amount: '-6500',
            icon: Icons.directions_bus_outlined,
            iconColor: Color(0xFFDC9483),
          ),
          HomeItemRow(
            title: 'Food',
            amount: '-35',
            icon: Icons.restaurant,
            iconColor: Color(0xFF00D294),
            showBorder: false,
          ),
        ],
      ),
    );
  }
}
