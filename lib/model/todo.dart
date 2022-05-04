import 'package:flutter/material.dart';

@immutable
class Todo {
  final int? planId;
  final String? planName;
  final int? time;
  final bool? check;
  final int? repetitionType;
  final int? dailyId;
  final int? categoryId;
  final String? categoryName;
  final String? color;
  final bool? type;
  final int? userId;

  const Todo({
    this.planId,
    this.time,
    this.check,
    this.repetitionType,
    this.planName,
    this.dailyId,
    this.categoryId,
    this.categoryName,
    this.color,
    this.type,
    this.userId,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      planId: json['planId'],
      planName: json['planName'],
      time: json['time'],
      check: json['check'],
      repetitionType: json['repetitionType'],
      dailyId: json['dailyId'],
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      color: json['color'],
      type: json['type'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['planId'] = planId;
    data['planName'] = planName;
    data['time'] = time;
    data['check'] = check;
    data['repetitionType'] = repetitionType;
    data['dailyId'] = dailyId;
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['color'] = color;
    data['type'] = type;
    data['userId'] = userId;
    return data;
  }
}
