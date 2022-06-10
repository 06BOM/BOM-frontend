import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:bom_front/utils.dart';
import 'package:flutter/material.dart';

import '../../../provider/todo_provider.dart';
import '../../hom_view.dart';
import '../../home_detail_view.dart';

class BomCalendar extends ConsumerStatefulWidget {
  late CalendarFormat pageCalendarFormat;

  BomCalendar({Key? key, required this.pageCalendarFormat}) : super(key: key);

  @override
  ConsumerState<BomCalendar> createState() => _BomCalendarState();
}

class _BomCalendarState extends ConsumerState<BomCalendar>
    with TickerProviderStateMixin {
  DateTime _focusedDay = DateTime.now().add(const Duration(hours: 9));
  DateTime? _selectedDay;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = ref.watch(userDeviceHeight);
    final monthlyStars = ref.watch(montlyStarsProvider);

    return monthlyStars.when(
        data: (userMonthlyStars) => TableCalendar(
              locale: 'ko-KR',
              firstDay: kFirstDay,
              lastDay: kLastDay,
              currentDay: DateTime.now(),
              focusedDay: _focusedDay,
              calendarFormat: widget.pageCalendarFormat,
              availableCalendarFormats: const {
                CalendarFormat.month: '',
                CalendarFormat.week: ''
              },
              eventLoader: (day) {
                if (userMonthlyStars.isEmpty) {
                  // list의 인덱스 접근 불허
                  return [];
                }
                if (int.parse(
                        (userMonthlyStars[0].date)?.split('-')[1] ?? '13') ==
                    day.month) {
                  if (userMonthlyStars.length < day.day) {
                    // list의 인덱스 접근 불허
                    return [];
                  }
                  var starNum = userMonthlyStars[day.day - 1].obtainedStar;
                  if (starNum != 0) {
                    // userMonthlyStars의 각 객체들의 date를 비교해서 맞는 경우엔 return [1]
                    return [starNum];
                  } else {
                    return [];
                  }
                } else {
                  return [];
                }
              },
              // headerVisible:false,
              // daysOfWeekVisible: false,
              // rangeSelectionMode: RangeSelectionMode.disabled,
              rowHeight: deviceHeight > 1500.0 ? 42.0 : 28.0,
              daysOfWeekHeight: deviceHeight > 1500.0 ? 20.0 : 19.0,
              calendarStyle: CalendarStyle(
                // outsideDaysVisible: false,
                weekendTextStyle: const TextStyle()
                    .copyWith(color: Colors.red[800]), // 토, 일 따로 색 구분 불가
                holidayTextStyle:
                    const TextStyle().copyWith(color: Colors.red[800]),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekendStyle:
                    const TextStyle().copyWith(color: Colors.red[600]),
              ),
              headerStyle: HeaderStyle(
                titleTextStyle: deviceHeight > 1500.0
                    ? const TextStyle(fontSize: 17.0)
                    : const TextStyle(fontSize: 15.0),
                headerPadding: deviceHeight > 1500.0
                    ? const EdgeInsets.symmetric(vertical: 8.0)
                    : const EdgeInsets.symmetric(vertical: 0.0),
                titleCentered: true,
                formatButtonVisible: false,
              ),
              calendarBuilders:
                  CalendarBuilders(todayBuilder: (context, date, _) {
                return Container(
                    margin: const EdgeInsets.all(4.0),
                    // padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                    width: 100,
                    height: 100,
                    child: Image.asset('images/character.png'));
              }, markerBuilder: (context, day, events) {
                // 월 변경시 rebuild 된다.
                if (events.isNotEmpty) {
                  int starNum = events[0] as int;
                  return Align(
                    alignment: Alignment.centerLeft,
                    child:
                        Icon(Icons.star, size: 20.0, color: getColor(starNum)),
                  );
                }
                return null;
              }, selectedBuilder: (context, date, events) {
                    // print(date);
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  padding: const EdgeInsets.all(0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(50.0)),
                  child: Text(date.day.toString(),
                      style: const TextStyle(color: Colors.white)),
                );
              }),
              // 아래를 풀면 날짜 선택시 고정
              selectedDayPredicate: (day) {
                // Use `selectedDayPredicate` to determine which day is currently selected.
                // If this returns true, then `day` will be marked as selected.

                // Using `isSameDay` is recommended to disregard
                // the time-part of compared DateTime objects.
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  // Call `setState()` when updating the selected day
                  if(widget.pageCalendarFormat == CalendarFormat.week){
                    // print('this is week ${selectedDay.toString().split(' ')[0]}');
                    ref.read(selectedDate.notifier).state = selectedDay;
                  }else{
                    ref.read(selectedDate.notifier).state = selectedDay;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const HomeDetailScreen()));
                  }
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              onFormatChanged: (format) {
                format = widget.pageCalendarFormat;
                if (widget.pageCalendarFormat != format) {
                  // Call `setState()` when updating calendar format
                  setState(() {
                    widget.pageCalendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                // No need to call `setState()` here
                _focusedDay = focusedDay;
              },
            ),
        error: (e, stackTrace) => Text('Monthly Stars Load Error : $e'),
        loading: () => Container());
  }

  Color? getColor(int starNum) {
    if (starNum < 3) {
      return Colors.yellow[200];
    } else if (starNum < 6) {
      return Colors.yellow[300];
    } else if (starNum < 10) {
      return Colors.yellow[400];
    } else if (starNum < 14) {
      return Colors.yellow[500];
    } else if (starNum < 18) {
      return Colors.yellow[600];
    } else {
      return Colors.red[300];
    }
  }
}
