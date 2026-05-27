import 'package:expensetrackerui/core/components/date_pickers/models/week_selection.dart';
import 'package:expensetrackerui/core/components/date_pickers/week_picker_modal.dart';
import 'package:flutter/material.dart';

class ChartFilters extends StatelessWidget {
  const ChartFilters({
    super.key,
    required this.selectedFilter,
    required this.selectedWeek,
    required this.onWeekSelected,
    required this.onFilterSelected,
  });
  final String selectedFilter;
  final WeekSelection? selectedWeek;
  final ValueChanged<WeekSelection>? onWeekSelected;
  final ValueChanged<String>? onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 12,
              children: [
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(
                      value: 'last_week',
                      label: Text('Last Week'),
                      icon: Icon(Icons.calendar_view_week_rounded),
                    ),
                  ],

                  selected: {selectedFilter},

                  onSelectionChanged: (value) {
                    onFilterSelected?.call(value.first);
                  },

                  style: ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    backgroundColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.blueAccent.withValues(alpha: 0.1);
                      }
                      return Colors.transparent;
                    }),
                  ),
                ),

                FilledButton.icon(
                  onPressed: () async {
                    await showDialog<WeekSelection>(
                      context: context,
                      barrierColor: Colors.black.withValues(alpha: 0.5),
                      builder: (_) => WeekPickerModal(
                        onSelected: (weekSelection) {
                          onWeekSelected?.call(weekSelection);
                        },
                      ),
                    );
                  },

                  icon: const Icon(Icons.tune_rounded, size: 17),

                  label: Column(
                    children: [
                      Text(
                        selectedWeek?.weekLabel ?? 'Custom',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        selectedWeek?.rangeLabel ?? 'Select week',
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  style: FilledButton.styleFrom(
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    backgroundColor: selectedWeek != null
                        ? Colors.blueAccent.withValues(alpha: 0.1)
                        : Colors.transparent,
                    side: BorderSide(
                      color: Colors.grey.withValues(alpha: 0.5),
                      width: 1,
                    ),
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
