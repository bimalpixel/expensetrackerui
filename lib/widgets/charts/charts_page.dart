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
            Row(
              children: [
                Text(
                  'This Month',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Export', style: TextStyle(fontSize: 16)),
                ),
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
}
