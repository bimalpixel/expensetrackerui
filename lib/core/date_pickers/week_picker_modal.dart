import 'package:expensetrackerui/core/date_pickers/models/week_selection.dart';
import 'package:flutter/material.dart';

/// A centered ISO-8601 week picker dialog.
///
/// ISO 8601 rules used here:
/// - Weeks start on Monday.
/// - Week 1 is the week that contains the first Thursday of the ISO year.
/// - An ISO year can have 52 or 53 weeks.
/// - Week ranges can cross year boundaries.
class WeekPickerModal extends StatefulWidget {
  const WeekPickerModal({super.key, this.initialDate, this.onSelected});

  final DateTime? initialDate;
  final ValueChanged<WeekSelection>? onSelected;

  @override
  State<WeekPickerModal> createState() => _WeekPickerModalState();
}

class _WeekPickerModalState extends State<WeekPickerModal> {
  late int _selectedYear;
  int? _selectedWeekIndex;

  final ScrollController _weekScrollController = ScrollController();

  static const List<String> _monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  @override
  void initState() {
    super.initState();
    final now = widget.initialDate ?? DateTime.now();
    _selectedYear = _isoYear(now);
    _selectedWeekIndex = _isoWeekNumber(now);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedWeek();
    });
  }

  @override
  void dispose() {
    _weekScrollController.dispose();
    super.dispose();
  }

  DateTime _startOfIsoWeek1(int year) {
    final jan4 = DateTime(year, 1, 4);
    return jan4.subtract(Duration(days: jan4.weekday - DateTime.monday));
  }

  DateTime _startOfIsoWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - DateTime.monday));
  }

  DateTime _thursdayOfIsoWeek(DateTime date) {
    return date.add(Duration(days: DateTime.thursday - date.weekday));
  }

  int _isoYear(DateTime date) {
    return _thursdayOfIsoWeek(date).year;
  }

  int _isoWeekNumber(DateTime date) {
    final isoYear = _isoYear(date);
    final week1Start = _startOfIsoWeek1(isoYear);
    final weekStart = _startOfIsoWeek(date);
    return 1 + weekStart.difference(week1Start).inDays ~/ 7;
  }

  int _weeksInIsoYear(int year) {
    return _isoWeekNumber(DateTime(year, 12, 28));
  }

  List<int> _visibleIsoWeeksForYear(int year) {
    final totalWeeks = _weeksInIsoYear(year);
    final weeks = <int>[];

    for (var week = 1; week <= totalWeeks; week++) {
      final startDate = _isoWeekStartDate(year, week);
      if (startDate.year == year) {
        weeks.add(week);
      }
    }

    return weeks;
  }

  DateTime _isoWeekStartDate(int isoYear, int weekIndex) {
    return _startOfIsoWeek1(isoYear).add(Duration(days: (weekIndex - 1) * 7));
  }

  DateTime _isoWeekEndDate(int isoYear, int weekIndex) {
    return _isoWeekStartDate(isoYear, weekIndex).add(const Duration(days: 6));
  }

  String _weekRangeLabel(int weekIndex) {
    final start = _isoWeekStartDate(_selectedYear, weekIndex);
    final end = _isoWeekEndDate(_selectedYear, weekIndex);
    return '${start.day} ${_monthNames[start.month - 1]} - ${end.day} ${_monthNames[end.month - 1]}';
  }

  void _handleYearChanged(int value) {
    setState(() {
      _selectedYear = value;
      _selectedWeekIndex = null; // clear selection when year changes
    });
  }

  void _handleWeekChanged(int value) {
    setState(() {
      _selectedWeekIndex = value;
    });
  }

  void _scrollToSelectedWeek() {
    if (!_weekScrollController.hasClients || _selectedWeekIndex == null) {
      return;
    }

    final visibleWeeks = _visibleIsoWeeksForYear(_selectedYear);
    final index = visibleWeeks.indexOf(_selectedWeekIndex!);

    if (index < 0) return;

    const double itemWidth = 112;
    const double previewOffset = 80;
    final targetOffset = ((index / 3) * itemWidth) - previewOffset;

    _weekScrollController.jumpTo(
      targetOffset.clamp(0.0, _weekScrollController.position.maxScrollExtent),
    );
  }

  void _scrollWeeksLeft() {
    if (!_weekScrollController.hasClients) return;
    final newOffset = (_weekScrollController.offset - 220).clamp(
      0.0,
      _weekScrollController.position.maxScrollExtent,
    );
    _weekScrollController.animateTo(
      newOffset,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
    );
  }

  void _scrollWeeksRight() {
    if (!_weekScrollController.hasClients) return;
    final newOffset = (_weekScrollController.offset + 220).clamp(
      0.0,
      _weekScrollController.position.maxScrollExtent,
    );
    _weekScrollController.animateTo(
      newOffset,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
    );
  }

  void _handleOk() {
    final week = _selectedWeekIndex;
    if (week == null) {
      Navigator.of(context).pop(null);
      return;
    }

    final start = _isoWeekStartDate(_selectedYear, week);
    final end = _isoWeekEndDate(_selectedYear, week);

    final result = WeekSelection(
      year: _selectedYear,
      weekNumber: week,
      weekLabel: 'W$week',
      rangeLabel: _weekRangeLabel(week),
      startDate: start,
      endDate: end,
    );

    widget.onSelected?.call(result);
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final yearItems = List<int>.generate(
      15,
      (index) => _selectedYear - 7 + index,
    );
    final visibleWeeks = _visibleIsoWeeksForYear(_selectedYear);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Padding(
          padding: EdgeInsets.only(
            left: 18,
            right: 18,
            top: 18,
            bottom: 18 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Select Week',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                initialValue: _selectedYear,
                isDense: true,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: 'Year',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: yearItems
                    .map(
                      (item) => DropdownMenuItem<int>(
                        value: item,
                        child: Text('$item'),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  _handleYearChanged(value);
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: _scrollWeeksLeft,
                      icon: const Icon(Icons.keyboard_arrow_left_rounded),
                      tooltip: 'Scroll weeks left',
                    ),
                  ),
                  const SizedBox(width: 4),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: _scrollWeeksRight,
                      icon: const Icon(Icons.keyboard_arrow_right_rounded),
                      tooltip: 'Scroll weeks right',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              SizedBox(
                height: 240,
                child: GridView.builder(
                  controller: _weekScrollController,
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 104,
                  ),
                  itemCount: visibleWeeks.length,
                  itemBuilder: (context, index) {
                    final week = visibleWeeks[index];
                    final selected = week == _selectedWeekIndex;

                    return GestureDetector(
                      onTap: () => _handleWeekChanged(week),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: selected
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey.shade300,
                          ),
                          boxShadow: selected
                              ? [
                                  BoxShadow(
                                    color: Theme.of(context).colorScheme.primary
                                        .withValues(alpha: 0.18),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'W$week',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: selected
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _weekRangeLabel(week),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10,
                                color: selected
                                    ? Theme.of(context).colorScheme.onPrimary
                                          .withValues(alpha: 0.85)
                                    : Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(46),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: _handleOk,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(46),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('OK'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
