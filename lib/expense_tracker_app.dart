import 'package:expensetracker/features/dashboard/screen/dashboard_screen.dart';
import 'package:flutter/src/widgets/framework.dart';

class ExpenseTrackerApp extends StatefulWidget {
  const ExpenseTrackerApp({super.key});

  @override
  State<ExpenseTrackerApp> createState() => _ExpenseTrackerAppState();
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
  @override
  Widget build(BuildContext context) {
    return const DashboardScreen();
  }
}
