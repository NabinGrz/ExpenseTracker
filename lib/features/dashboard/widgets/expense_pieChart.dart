import 'dart:math';

import 'package:expensetracker/core/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../models/expense_model.dart';

Widget expensePieChart(
    {required Map<String, List<ExpenseDataModel>> categoryGroupedExpensList}) {
  final total = categoryGroupedExpensList.values
      .reduce((value, element) => value + element)
      .map((e) => double.parse(e.amount))
      .toList()
      .sumOfDoublesInList;
  return CustomPaint(
    size: const Size.fromRadius(100),
    painter: PieChartPainter(categoryGroupedExpensList, total,
        _generateColors(categoryGroupedExpensList.length)),
  );
}

List<Color> _generateColors(int count) {
  final colors = <Color>[];
  final random = Random();
  for (var i = 0; i < count; i++) {
    colors.add(Color.fromRGBO(
        random.nextInt(256), random.nextInt(256), random.nextInt(256), 1));
  }
  return colors;
}

class PieChartPainter extends CustomPainter {
  final Map<String, List<ExpenseDataModel>> data;
  final double total;
  final List<Color> colors;

  PieChartPainter(this.data, this.total, this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 1.4, size.height / 1.4);
    const margin = 10.0; // Add a margin of 10 pixels between pie slices
    final rect = Rect.fromCircle(center: center, radius: radius - margin);

    var startAngle = 0.0;
    var endAngle = 0.0;

    data.forEach((key, value) {
      final sweepAngle = (value
                  .map((e) => double.parse(e.amount))
                  .toList()
                  .sumOfDoublesInList /
              total) *
          2 *
          pi;
      endAngle = startAngle + sweepAngle;

      final path = Path()
        ..moveTo(center.dx, center.dy)
        ..arcTo(rect, startAngle, sweepAngle, false)
        ..close();

      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = colors[data.keys.toList().indexOf(key)];

      canvas.drawPath(path, paint);

      startAngle = endAngle;
    });
  }

  @override
  bool shouldRepaint(PieChartPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(PieChartPainter oldDelegate) => false;
}
