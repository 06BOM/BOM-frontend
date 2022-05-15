import 'dart:collection';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    kToday: [
      const Event('Today\'s Event 1'),
      const Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
        (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now().add(const Duration(hours: 9));
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

String getToday(){
  final now = DateTime.now().add(const Duration(hours: 9)); // kr: utc + 9
  return getBasicDateFormat(now);
}

String getBasicDateFormat<DateTiem>(day){
  return DateFormat('yyyy-MM-dd', 'ko_KR').format(day).toString();
}


String changeDateFormat<DateTime>(day){
  return DateFormat('yyy.MM.dd EEE', 'ko_KR')
      .format(day).toString();
}

String getTodayKoreanFormat<DateTime>(day){
  return DateFormat('yyy년MM월dd일', 'ko_KR')
      .format(day).toString();
}

String secToMin(int num) {
  int hours = (num ~/ 3600).truncate();
  int minutes = (num ~/ 60).truncate();
  int seconds = (num).truncate();

  var hour = (hours % 60).toString().padLeft(2, '0');
  var min = (minutes % 60).toString().padLeft(2, '0');
  var sec = (seconds % 60).toString().padLeft(2, '0');
  return "${hour}:${min}:${sec}";
}

bool isToday(DateTime other) {
  final now = DateTime.now().add(const Duration(hours: 9));
  final year = now.year;
  final month = now.month;
  final day = now.day;
  return year == other.year && month == other.month
      && day == other.day;
}

String getSecToMinAnotherFormat(int num){
  int hour = (num ~/ 3600).truncate();
  int minute = (num ~/ 60).truncate();
  int second = (num).truncate();

  return "${hour}시간 ${minute}분";
}
