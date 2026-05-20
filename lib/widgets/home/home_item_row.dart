import 'package:expensetrackerui/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HomeItemRow extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;
  final Color iconColor;
  final bool showBorder;

  const HomeItemRow({
    super.key,
    required this.title,
    required this.amount,
    required this.icon,
    required this.iconColor,
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: showBorder
            ? Border(bottom: BorderSide(color: Color(0xFFF0F0F0), width: 0.5))
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 10.0,
          bottom: 10.0,
        ),
        child: Row(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: iconColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 25),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppColors.textPrimary,
              ),
            ),
            Spacer(),
            Text(
              amount,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
