import 'package:bom_front/view/hom_view.dart';
import 'package:bom_front/view/timer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

final addTodoKey = UniqueKey();
final activeFilterKey = UniqueKey();
final completedFilterKey = UniqueKey();
final allFilterKey = UniqueKey();

void main() {
  initializeDateFormatting('ko_KR', null)
      .then((_) => runApp(const ProviderScope(child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Team BOM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimerApp(),
    );
  }
}
