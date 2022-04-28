import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:bom_front/model/statistic_model.dart';

class statistic_chart extends StatelessWidget {
  final List<BarChartData> data;

  statistic_chart({required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<BarChartData, String>> datas = [
      charts.Series(
          id: "Subscribers",
          data: data,
          domainFn: (BarChartData datas, _) => datas.date,
          measureFn: (BarChartData datas, _) => datas.time,
          colorFn: (BarChartData datas, _) => datas.barColor)
    ];

    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                "이번주 공부한 시간",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Expanded(
                child: charts.BarChart(datas, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}
