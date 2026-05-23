import 'package:expensetrackerui/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

BottomAppBar getBottomAppBar({
  required int selectedIndex,
  required ValueChanged<int> onItemSelected,
}) {
  return BottomAppBar(
    color: const Color(0xFFF3F4F6),
    elevation: 0,
    shadowColor: const Color.fromARGB(66, 255, 255, 255),
    shape: const CircularNotchedRectangle(),
    notchMargin: 8,
    child: SizedBox(
      height: 72,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _navItem(
            Icons.space_dashboard,
            'Home',
            0,
            selectedIndex,
            onItemSelected,
          ),
          _navItem(
            Icons.pie_chart_outline_rounded,
            'Charts',
            1,
            selectedIndex,
            onItemSelected,
          ),
          const SizedBox(width: 60), // smaller gap for FAB
          _navItem(
            Icons.analytics_outlined,
            'Reports',
            3,
            selectedIndex,
            onItemSelected,
          ),
          _navItem(
            Icons.person_outline,
            'Profile',
            4,
            selectedIndex,
            onItemSelected,
          ),
        ],
      ),
    ),
  );
}

Widget _navItem(
  IconData icon,
  String label,
  int index,
  int selectedIndex,
  ValueChanged<int> onItemSelected,
) {
  final bool isSelected = selectedIndex == index;

  return Expanded(
    child: InkWell(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      onTap: () {
        onItemSelected(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 25,
            color: isSelected ? AppColors.primary : AppColors.textSecondary,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    ),
  );
}
