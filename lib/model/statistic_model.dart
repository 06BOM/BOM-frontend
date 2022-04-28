import 'package:charts_flutter/flutter.dart' as charts;

class BarChartData {
  final String date;
  final int time;
  final charts.Color barColor;

  BarChartData(
      {required this.date, required this.time, required this.barColor});
}
