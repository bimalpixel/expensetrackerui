import 'package:expensetrackerui/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HomeDateRow extends StatelessWidget {
  const HomeDateRow({
    super.key,
    required this.date,
    required this.day,
    required this.expenses,
  });

  final String date;
  final String day;
  final String expenses;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFD6D6D6), width: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 4.0,
          bottom: 4.0,
        ),
        child: Row(
          spacing: 10,
          children: [
            Text(
              date,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              day,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: AppColors.textSecondary,
              ),
            ),
            Spacer(),
            Text(
              expenses,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
