import 'package:bom_front/provider/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weekday_selector/weekday_selector.dart';

import '../../../model/todo.dart'; // 기본 내장

class WeekDaySelection extends StatefulWidget {
  final Todo? data;

  const WeekDaySelection({Key? key, required this.data}) : super(key: key);

  @override
  _WeekDaySelectionState createState() => _WeekDaySelectionState();
}

class _WeekDaySelectionState extends State<WeekDaySelection> {
  final values = <bool?>[
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ]; // 일 월 화 수 목 금 토

  // late List<bool> values; 서버에서 고쳐주면 적용하기
  //
  // @override
  // void initState() {
  //   values = [false,
  //     false,
  //     false,
  //     false,
  //     false,
  //     false,
  //     false];
  //
  //   for(var i = 0; i< values.length; i++){
  //    values[i] =
  //   }
  //   isSelected[widget.data?.repetitionType ?? 0] = true; // repetitionType이 3넘어갈 경우 에러 (오류 처리해주자)
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final userSelectedWeek = ref.watch(selectedWeek);
      print(userSelectedWeek);
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          WeekdaySelector(
            shortWeekdays: const ['일', '월', '화', '수', '목', '금', '토'],
            selectedColor: Colors.white,
            selectedFillColor: const Color(0xffA876DE),
            shape: CircleBorder(
              side: BorderSide(color: Colors.grey.withOpacity(0.5)),
            ),
            onChanged: (v) {
              setState(() {
                values[v % 7] = !values[v % 7]!;
              });
              // if(userSelectedWeek[v % 7] == 0){
              //
              // }
              userSelectedWeek[v % 7] == 0
                  ? ref.read(selectedWeek.notifier).state[v % 7] = 1
                  : ref.read(selectedWeek.notifier).state[v % 7] = 0;
              printIntAsDay(v);
            },
            values: values,
          ),
        ],
      );
    });
  }

  printIntAsDay(int day) {
    print(
        'Received integer: $day. Corresponds to day: ${intDayToEnglish(day)}. selection status : ${values[day]}');
  }

  String intDayToEnglish(int day) {
    if (day % 7 == DateTime.monday % 7) return 'Monday';
    if (day % 7 == DateTime.tuesday % 7) return 'Tueday';
    if (day % 7 == DateTime.wednesday % 7) return 'Wednesday';
    if (day % 7 == DateTime.thursday % 7) return 'Thursday';
    if (day % 7 == DateTime.friday % 7) return 'Friday';
    if (day % 7 == DateTime.saturday % 7) return 'Saturday';
    if (day % 7 == DateTime.sunday % 7) return 'Sunday';
    throw 'ERROR!: $day';
  }
}
