// A reusable stateless widget
import 'package:expensetrackerui/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ChartsAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const ChartsAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(120);

  @override
  State<ChartsAppBar> createState() => _ChartsAppBarState();
}

class _ChartsAppBarState extends State<ChartsAppBar> {
  int _selectedSegment = 0;
  static const _segmentLabels = ['Day', 'Week', 'Month'];

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      titleSpacing: 20,
      title: Text(widget.title),
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      leading: const Padding(
        padding: EdgeInsets.only(left: 12),
        child: Icon(Icons.menu),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: Icon(Icons.calendar_month_rounded, color: Colors.black),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.only(
            right: 27,
            left: 20,
            bottom: 20,
            top: 10,
          ),
          child: IntrinsicHeight(
            child: Row(
              spacing: 30,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        _segmentLabels.length,
                        (index) => _buildSegmentButton(index),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSegmentButton(int index) {
    final bool isSelected = _selectedSegment == index;
    final Color backgroundColor = isSelected ? Colors.black : AppColors.primary;
    final Color foregroundColor = isSelected ? AppColors.primary : Colors.black;
    final BorderRadius borderRadius;

    if (index == 0) {
      borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(7),
        bottomLeft: Radius.circular(7),
      );
    } else if (index == _segmentLabels.length - 1) {
      borderRadius = const BorderRadius.only(
        topRight: Radius.circular(7),
        bottomRight: Radius.circular(7),
      );
    } else {
      borderRadius = BorderRadius.zero;
    }

    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.black, width: index == 0 ? 1 : 0.5),
          right: BorderSide(color: Colors.black, width: index == 2 ? 1 : 0.5),
          top: BorderSide(color: Colors.black, width: 1),
          bottom: BorderSide(color: Colors.black, width: 1),
        ),
        borderRadius: borderRadius,
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            _selectedSegment = index;
          });
        },
        style: TextButton.styleFrom(
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 7),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          minimumSize: Size(10, 10),
        ),
        child: Text(_segmentLabels[index]),
      ),
    );
  }
}
