import 'package:expensetrackerui/core/functions/get_bottom_app_bar.dart';
import 'package:expensetrackerui/core/functions/get_floating_action_button.dart';
import 'package:expensetrackerui/core/services/sound_service.dart';
import 'package:expensetrackerui/widgets/common/custom_fav_location.dart';
import 'package:expensetrackerui/widgets/home/home_app_bar.dart';
import 'package:expensetrackerui/widgets/home/home_item_group.dart';
import 'package:expensetrackerui/widgets/home/home_prev_next_nav.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
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
      appBar: HomeAppBar(title: widget.title),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HomeItemGroup(),
            HomeItemGroup(),
            HomeItemGroup(),
            HomePrevNextNav(),
          ],
        ),
      ),
      bottomNavigationBar: getBottomAppBar(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          soundService.playTap2();
          if (index == 1) {
            Navigator.pushReplacementNamed(context, '/charts');
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
