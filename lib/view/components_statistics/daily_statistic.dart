import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../provider/todo_provider.dart';
import '../../utils.dart';

class DailyChart extends StatelessWidget {
  Map<String, double> dataMap = {
    "국어": 5,
    "수학": 3,
    "사회": 2,
    "과학": 2,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final todos = ref.watch(filteredTodos);
            return PieChart(
              chartType: ChartType.ring,
              ringStrokeWidth: 10,
              dataMap: dataMap,
              centerText: getSecToMinAnotherFormat(todos.fold(
                  0,
                      (previous, current) =>
                  previous +
                      current.time!)),
              centerTextStyle: const TextStyle(
                fontSize: 30,
                color: Colors.black,
              ),
              chartRadius: MediaQuery.of(context).size.width / 1.7,
              legendOptions: const LegendOptions(
                  legendPosition: LegendPosition.bottom,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle()),
              chartValuesOptions: const ChartValuesOptions(
                showChartValuesInPercentage: true,
                showChartValueBackground: false,
                showChartValues: false, // 값안보이게 하기
              ),
            );
          }
        ),
      ),
    );
  }
}
