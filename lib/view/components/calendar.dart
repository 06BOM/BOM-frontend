import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:bom_front/utils.dart';
import 'package:flutter/material.dart';

import '../hom_view.dart';

class BomCalendar extends ConsumerStatefulWidget {
  late CalendarFormat pageCalendarFormat;

  BomCalendar({Key? key, required this.pageCalendarFormat}) : super(key: key);

  @override
  ConsumerState<BomCalendar> createState() => _BomCalendarState();
}

class _BomCalendarState extends ConsumerState<BomCalendar>
    with TickerProviderStateMixin {
  DateTime _focusedDay = DateTime.now();
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
    return TableCalendar(
      locale: 'ko-KR',
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: _focusedDay,
      calendarFormat: widget.pageCalendarFormat,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: ''
      },
      // headerVisible:false,
      // daysOfWeekVisible: false,
      // rangeSelectionMode: RangeSelectionMode.disabled,
      rowHeight: deviceHeight > 2000.0 ? 42.0 : 28.0,
      daysOfWeekHeight: deviceHeight > 2000.0 ? 20.0 : 19.0,
      calendarStyle: CalendarStyle(
        // outsideDaysVisible: false,
        weekendTextStyle: const TextStyle().copyWith(color: Colors.red[800]), // 토, 일 따로 색 구분 불가
        holidayTextStyle: const TextStyle().copyWith(color: Colors.red[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: const TextStyle().copyWith(color: Colors.red[600]),
      ),
      headerStyle: HeaderStyle(
        titleTextStyle: deviceHeight > 2000.0 ? const TextStyle(fontSize: 17.0) : const TextStyle(fontSize: 15.0),
        headerPadding: deviceHeight > 2000.0 ? EdgeInsets.symmetric(vertical: 8.0) : EdgeInsets.symmetric(vertical: 0.0),
        titleCentered: true,
        formatButtonVisible: false,
      ),
      calendarBuilders: CalendarBuilders(
        todayBuilder: (context, date, _) {
          return Container(
              margin: const EdgeInsets.all(4.0),
              // padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              width: 100,
              height: 100,
              child: Image.asset('images/character.png'));
        },
      ),
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
    );
  }
}
