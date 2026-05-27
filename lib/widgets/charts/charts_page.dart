import 'package:expensetrackerui/core/components/charts/donut_chart.dart';
import 'package:expensetrackerui/core/components/date_pickers/models/week_selection.dart';
import 'package:expensetrackerui/core/components/date_pickers/week_picker_modal.dart';
import 'package:expensetrackerui/core/functions/get_bottom_app_bar.dart';
import 'package:expensetrackerui/core/functions/get_floating_action_button.dart';
import 'package:expensetrackerui/core/services/sound_service.dart';
import 'package:expensetrackerui/widgets/charts/charts_app_bar.dart';
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
  String _selectedFilter = 'this_week';
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 5,
                    ),
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

                          selected: {_selectedFilter},

                          onSelectionChanged: (value) {
                            setState(() {
                              _selectedFilter = value.first;
                            });
                          },

                          style: ButtonStyle(
                            //visualDensity: VisualDensity.compact,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            padding: WidgetStateProperty.all(
                              const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.resolveWith((
                              states,
                            ) {
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
                                  setState(() {
                                    _selectedWeek = weekSelection;
                                  });
                                },
                              ),
                            );
                          },

                          icon: const Icon(Icons.tune_rounded, size: 17),

                          label: Column(
                            children: [
                              Text(
                                _selectedWeek?.weekLabel ?? 'Custom',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                _selectedWeek?.rangeLabel ?? 'Select week',
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
                            backgroundColor: _selectedWeek != null
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
                  const Divider(
                    height: 12,
                    thickness: 0.5,
                    color: Color(0xFFCCCCCC),
                  ),
                  DonutChart(
                    size: 240,
                    thickness: 60,
                    separatorWidth: 6,
                    slices: const [
                      PieSlice(value: 40, color: Colors.blue, label: '40%'),
                      PieSlice(value: 30, color: Colors.orange, label: '30%'),
                      PieSlice(value: 15, color: Colors.purple, label: '15%'),
                      PieSlice(value: 15, color: Colors.green, label: '15%'),
                    ],
                    delay: const Duration(milliseconds: 200),
                  ),
                ],
              ),
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
}
