import 'package:expensetrackerui/core/components/charts/donut_chart.dart';
import 'package:expensetrackerui/core/components/date_pickers/models/week_selection.dart';
import 'package:expensetrackerui/core/functions/get_bottom_app_bar.dart';
import 'package:expensetrackerui/core/functions/get_floating_action_button.dart';
import 'package:expensetrackerui/core/services/sound_service.dart';
import 'package:expensetrackerui/widgets/charts/chart_filters.dart';
import 'package:expensetrackerui/widgets/charts/charts_app_bar.dart';
import 'package:expensetrackerui/widgets/charts/expense_distribution.dart';
import 'package:expensetrackerui/widgets/common/custom_fav_location.dart';
import 'package:flutter/material.dart';

class ChartsPage extends StatefulWidget {
  const ChartsPage({super.key, required this.title});
  final String title;

  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  int _selectedIndex = 1; // 1 for Charts
  final soundService = SoundService();
  String _selectedFilter = 'last_week';
  WeekSelection? _selectedWeek;

  @override
  void initState() {
    super.initState();
    soundService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ChartsAppBar(title: widget.title),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  ChartFilters(
                    selectedFilter: _selectedFilter,
                    selectedWeek: _selectedWeek,
                    onWeekSelected: (weekSelection) {
                      setState(() {
                        _selectedWeek = weekSelection;
                      });
                    },
                    onFilterSelected: (filter) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                  ),
                  const Divider(
                    height: 14,
                    thickness: 0.2,
                    color: Color.fromARGB(255, 223, 222, 222),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 20,
                      bottom: 16,
                    ),
                    child: Row(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 10, child: getDonutChart()),
                        Expanded(flex: 13, child: ExpenseDistribution()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                dot(Colors.grey),
                const SizedBox(width: 4),
                dot(Colors.blue),
                const SizedBox(width: 4),
                dot(Colors.grey),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: getBottomAppBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          soundService.playTap2();
          if (index == 0) {
            setState(() {
              _selectedIndex = index;
            });
            Navigator.pushReplacementNamed(context, '/home');
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
      ),
      floatingActionButton: getFloatingActionButton(
        onPressed: soundService.playTap1,
      ),
      floatingActionButtonLocation: const CustomFabLocation(-10),
    );
  }

  DonutChart getDonutChart() {
    return DonutChart(
      size: 170,
      thickness: 30,
      separatorWidth: 2,
      slices: const [
        PieSlice(value: 40, color: Colors.blue, label: '40%'),
        PieSlice(value: 30, color: Colors.orange, label: '30%'),
        PieSlice(value: 15, color: Colors.purple, label: '15%'),
        PieSlice(value: 15, color: Colors.green, label: '15%'),
      ],
      delay: const Duration(milliseconds: 200),
      labelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      duration: const Duration(milliseconds: 500),
    );
  }

  Widget dot(Color color) {
    return Container(
      width: 5,
      height: 5,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
