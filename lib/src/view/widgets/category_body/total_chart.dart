import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../data.dart';

class TotalChart extends StatefulWidget {
  const TotalChart({super.key});

  @override
  State<TotalChart> createState() => _TotalChartState();
}

class _TotalChartState extends State<TotalChart> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(builder: (_, categoryProvider, __) {
      var list = categoryProvider.categories;
      var totalExpense = categoryProvider.calculateTotalOperations();
      var totalIncome = categoryProvider.getIncome();
      return Row(
        children: [
          Expanded(
            flex: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  alignment: Alignment.center,
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Всего расходов: ${NumberFormat.currency(locale: 'ru_RU').format(totalExpense)}',
                    textScaler: const TextScaler.linear(1.5),
                    style: TextStyle(
                      color: Colors.red.withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FittedBox(
                  alignment: Alignment.center,
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Всего Доходов: ${NumberFormat.currency(locale: 'ru_RU').format(totalIncome)}',
                    textScaler: const TextScaler.linear(1.5),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.withOpacity(0.8),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                ...list.where((element) => element.title != "Доходы").map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          children: [
                            Container(
                              width: 8.0,
                              height: 8.0,
                              color: Colors.primaries[list.indexOf(e)],
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              e.title,
                            ),
                            const SizedBox(width: 5.0),
                            Text(totalExpense == 0
                                ? '0%'
                                : '${((e.totalAmount / totalExpense) * 100).toStringAsFixed(2)}%'),
                          ],
                        ),
                      ),
                    ),
              ],
            ),
          ),
          Expanded(
            flex: 40,
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 20.0,
                sections: totalExpense != 0
                    ? list
                        .where((element) => element.title != "Доходы")
                        .map(
                          (e) => PieChartSectionData(
                            showTitle: false,
                            value: e.totalAmount,
                            color: Colors.primaries[list.indexOf(e)],
                          ),
                        )
                        .toList()
                    : list
                        .where((element) => element.title != "Доходы")
                        .map(
                          (e) => PieChartSectionData(
                            showTitle: false,
                            color: Colors.primaries[list.indexOf(e)],
                          ),
                        )
                        .toList(),
              ),
            ),
          ),
        ],
      );
    });
  }
}
