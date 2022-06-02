import 'package:flutter/material.dart';

@immutable
class Category {
  final int? categoryId;
  final String? categoryName;
  final String? color;
  final bool? type;
  final int? userId;

  const Category(
      {this.categoryId, this.categoryName, this.color, this.userId, this.type});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        categoryId: json['categoryId'],
        categoryName: json['categoryName'],
        color: json['color'],
        userId: json['userId'],
        type: json['type']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['color'] = color;
    data['type'] = type;
    data['userId'] = userId;
    return data;
  }
}
