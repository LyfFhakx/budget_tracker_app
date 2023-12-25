import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../data.dart';

class OperationChart extends StatefulWidget {
  final String category;

  const OperationChart(this.category, {super.key});

  @override
  State<OperationChart> createState() => _OperationChartState();
}

class _OperationChartState extends State<OperationChart> {
  @override
  Widget build(BuildContext context) {
    return Consumer<OperationsProvider>(builder: (_, db, __) {
      var maxY = db.calculateEntriesAndAmount(widget.category)['Всего'];
      var list = db
          .calculateWeekOperations()
          .reversed
          .toList();
      return BarChart(
        BarChartData(
          minY: 0,
          maxY: maxY,
          barGroups: [
            ...list.map(
                  (e) =>
                  BarChartGroupData(
                    x: list.indexOf(e),
                    barRods: [
                      BarChartRodData(
                        toY: e['amount'],
                        width: 20.0,
                        borderRadius: BorderRadius.zero,
                      ),
                    ],
                  ),
            ),
          ],
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              drawBelowEverything: true,
            ),
            leftTitles: const AxisTitles(
              drawBelowEverything: true,
            ),
            rightTitles: const AxisTitles(
              drawBelowEverything: true,
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) =>
                    Text(DateFormat
                        .E()
                        .format(list[value.toInt()]['day']),),
              ),
            ),
          ),
        ),
      );
    });
  }
}
