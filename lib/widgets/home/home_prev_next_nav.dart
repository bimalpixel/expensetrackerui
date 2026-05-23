import 'package:expensetrackerui/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HomePrevNextNav extends StatelessWidget {
  const HomePrevNextNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 200.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              side: const BorderSide(
                color: Color.fromARGB(255, 218, 218, 218),
                width: 1,
              ),
              elevation: 0,
              shadowColor: Colors.transparent,
              backgroundColor: Colors.white,
              foregroundColor: AppColors.textPrimary,
            ),
            onPressed: () {},
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("June 2026"),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              side: const BorderSide(
                color: Color.fromARGB(255, 218, 218, 218),
                width: 1,
              ),
              elevation: 0,
              shadowColor: Colors.transparent,
              backgroundColor: Colors.white,
              foregroundColor: AppColors.textPrimary,
            ),
            onPressed: () {},
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("June 2026"),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
