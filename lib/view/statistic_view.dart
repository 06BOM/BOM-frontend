import 'package:flutter/material.dart';
import 'package:bom_front/model/statistic_model.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PlanChart {
  final List<BarChartData> data = [
    BarChartData(
      date: "월",
      time: 10000000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    BarChartData(
      date: "화",
      time: 11000000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    BarChartData(
      date: "수",
      time: 12000000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    BarChartData(
      date: "목",
      time: 10000000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    BarChartData(
      date: "금",
      time: 8500000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    BarChartData(
      date: "토",
      time: 7700000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
    BarChartData(
      date: "일",
      time: 7600000,
      barColor: charts.ColorUtil.fromDartColor(Colors.blue),
    ),
  ];
}
