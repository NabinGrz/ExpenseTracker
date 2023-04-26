import 'package:expensetracker/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_styles.dart';
import '../../../global_widgets/custom_container_like_card.dart';
import '../models/expense_model.dart';
import 'flChart_piechart.dart';

Widget pieChartTotalAmountWidget(List<ExpenseDataModel> todaysExpenseList,
    Map<String, List<ExpenseDataModel>> categoryGroupedExpensList) {
  return Stack(
    children: [
      flChartPieChart(categoryGroupedExpensList: categoryGroupedExpensList),
      Center(
        child: CustomShadowContainer(
            height: 75.h,
            width: 75.h,
            elevation: 100,
            minElevation: 15,
            maxElevation: 15,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Total",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontFamily: GoogleFonts.lato().fontFamily,
                        fontSize: AppFontSize.fontSize15,
                      )),
                  Text(
                      "${todaysExpenseList.map((e) => double.parse(e.amount)).toList().sumOfDoublesInList}",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.blueGrey,
                        fontFamily: GoogleFonts.lato().fontFamily,
                        fontSize: AppFontSize.fontSize16,
                      )),
                ],
              ),
            )),
      )
    ],
  );
}
