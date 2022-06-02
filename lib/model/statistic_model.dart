import 'package:flutter/material.dart';

@immutable
class Statistic {
  final int? stars;
  final int? averageTime;
  final int? time;

  const Statistic({this.stars, this.averageTime, this.time});

  factory Statistic.fromJson(Map<String, dynamic> json) {
    return Statistic(
      stars: json['stars'],
      averageTime: json['averageTime'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stars'] = stars;
    data['averageTime'] = averageTime;
    data['time'] = time;
    return data;
  }
}
