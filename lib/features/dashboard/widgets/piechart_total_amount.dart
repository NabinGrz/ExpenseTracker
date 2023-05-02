import 'package:expensetracker/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_styles.dart';
import '../models/expense_model.dart';
import 'flChart_piechart.dart';

Widget pieChartTotalAmountWidget(
    List<ExpenseDataModel> todaysExpenseList,
    BuildContext context,
    Map<String, List<ExpenseDataModel>> categoryGroupedExpensList) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // flChartPieChart(categoryGroupedExpensList: categoryGroupedExpensList),

        // expensePieChart(categoryGroupedExpensList: categoryGroupedExpensList),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("Total",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                  fontFamily: GoogleFonts.lato().fontFamily,
                  fontSize: AppFontSize.fontSize26,
                )),
            Text(
                "${todaysExpenseList.map((e) => double.parse(e.amount)).toList().sumOfDoublesInList}",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.blueGrey,
                  fontFamily: GoogleFonts.lato().fontFamily,
                  fontSize: AppFontSize.fontSize20,
                )),
          ],
        ),
        flChartBarChart(
            categoryGroupedExpensList: categoryGroupedExpensList,
            context: context),
      ],
    ),
  );
}
