import 'dart:math';

import 'package:expensetracker/core/utils/extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_styles.dart';
import '../models/expense_model.dart';

Widget flChartPieChart(
    {required Map<String, List<ExpenseDataModel>> categoryGroupedExpensList}) {
  var generatedColor = Random().nextInt(Colors.primaries.length);
  Colors.primaries[generatedColor];
  List<PieChartSectionData>? sections = [];
  List<ExpenseDataModel>? expenses = [];
  List<Color> pieColors = [];
  List<String> pieNames = [];
  List<double> totalAmounts = [];
  pieNames.clear();
  totalAmounts.clear();
  pieColors.clear();
  for (var element in categoryGroupedExpensList.keys) {
    pieNames.add(element);
  }

  for (int i = 0; i < categoryGroupedExpensList.length; i++) {
    pieColors.add(Colors.primaries[i]);
    var pieTitles = categoryGroupedExpensList[pieNames[i]];
    sections.add(PieChartSectionData(
      value: pieTitles?.length.toDouble(),
      title:
          "${pieNames[i].capitialize}\n${categoryGroupedExpensList[pieNames[i]]?.map((e) => double.parse(e.amount)).toList().sumOfDoublesInList}",
      color: Colors.primaries[i],
      radius: 100,
      titleStyle: TextStyle(
          fontSize: AppFontSize.fontSize12,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff)),
    ));
  }
  return PieChart(PieChartData(centerSpaceRadius: 30, sections: sections));
}
