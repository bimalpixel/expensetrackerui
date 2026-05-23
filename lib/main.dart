import 'package:expensetrackerui/widgets/home/my_home_page.dart';
import 'package:expensetrackerui/widgets/charts/charts_page.dart';
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
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home':
            return PageRouteBuilder(
              settings: settings,
              transitionDuration: Duration.zero,
              pageBuilder: (_, _, _) =>
                  const MyHomePage(title: 'Expense Tracker'),
            );
          case '/charts':
            return PageRouteBuilder(
              settings: settings,
              transitionDuration: Duration.zero,
              pageBuilder: (_, _, _) => const ChartsPage(title: 'Expenses'),
            );
          default:
            return null;
        }
      },
    );
  }
}
