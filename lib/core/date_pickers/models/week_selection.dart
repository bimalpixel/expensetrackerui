class WeekSelection {
  final int year;
  final int weekNumber;
  final String weekLabel; // W23
  final String rangeLabel; // Jan 26 - Feb 5
  final DateTime startDate; // selected week start date
  final DateTime endDate; // selected week end date

  const WeekSelection({
    required this.year,
    required this.weekNumber,
    required this.weekLabel,
    required this.rangeLabel,
    required this.startDate,
    required this.endDate,
  });
}
