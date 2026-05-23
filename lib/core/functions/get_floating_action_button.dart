import 'package:expensetrackerui/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

FloatingActionButton getFloatingActionButton({
  required VoidCallback onPressed,
}) {
  return FloatingActionButton(
    onPressed: onPressed,
    backgroundColor: AppColors.primary,
    elevation: 6,
    shape: const CircleBorder(),
    child: const Icon(Icons.add, size: 34, color: AppColors.textPrimary),
  );
}
