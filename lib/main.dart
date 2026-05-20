import 'package:expensetrackerui/core/services/sound_service.dart';
import 'package:expensetrackerui/widgets/home/home_app_bar.dart';
import 'package:expensetrackerui/widgets/home/home_item_group.dart';
import 'package:flutter/material.dart';

import 'core/theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MyHomePage(title: 'Expense Tracker'),
    );
  }
}

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
            Padding(
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: getBottomAppBar(),
      floatingActionButton: getFloatingActionButton(),
      floatingActionButtonLocation: const _CustomFabLocation(-10),
    );
  }

  FloatingActionButton getFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        soundService.playTap1();
      },
      backgroundColor: AppColors.primary,
      elevation: 6,
      shape: const CircleBorder(),
      child: const Icon(Icons.add, size: 34, color: AppColors.textPrimary),
    );
  }

  BottomAppBar getBottomAppBar() {
    return BottomAppBar(
      color: const Color(0xFFF3F4F6),
      elevation: 0,
      shadowColor: const Color.fromARGB(66, 255, 255, 255),
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 72,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _navItem(Icons.space_dashboard, 'Home', 0),
            _navItem(Icons.pie_chart_outline_rounded, 'Charts', 1),
            const SizedBox(width: 60), // smaller gap for FAB
            _navItem(Icons.analytics_outlined, 'Reports', 3),
            _navItem(Icons.person_outline, 'Profile', 4),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final bool isSelected = _selectedIndex == index;

    return Expanded(
      child: InkWell(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        onTap: () {
          soundService.playTap2();
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 25,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomFabLocation extends FloatingActionButtonLocation {
  final double offset;

  const _CustomFabLocation(this.offset);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX =
        (scaffoldGeometry.scaffoldSize.width -
            scaffoldGeometry.floatingActionButtonSize.width) /
        2;

    final double fabY =
        scaffoldGeometry.contentBottom -
        scaffoldGeometry.floatingActionButtonSize.height / 2 -
        offset;

    return Offset(fabX, fabY);
  }
}
