import 'package:bom_front/provider/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/todo.dart';

class ShowDate extends StatefulWidget {
  final Todo? data;
  const ShowDate({Key? key, required this.data}) : super(key: key);

  @override
  State<ShowDate> createState() => _ShowDateState();
}

class _ShowDateState extends State<ShowDate> {
  DateTime? date;
  final today = DateTime.now().add(const Duration(hours: 9));

  String customDateFormat(DateTime date) =>
      '${date.year}/${date.month}/${date.day}';

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return DecoratedBox(
            child: TextButton(
              child: Text(
                  '${customDateFormat(today)} - ${date == null ? '\u221E' : customDateFormat(date!)}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400)),
              onPressed: () async {
                final result = await pickDate(context);
                ref.read(limitedDate.notifier).state = customDateFormat(date!);
                return result;
              },
            ),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ));
      },
    );
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now().add(const Duration(hours: 9));
    final newDate = await showDatePicker(
        locale: const Locale('ko', 'KR'),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        context: context,
        helpText: '',
        initialDate: initialDate,
        // date ?? initialDate,
        firstDate: DateTime(initialDate.year - 5),
        lastDate: DateTime(initialDate.year + 5),
        builder: (context, child) => Theme(
              data: ThemeData().copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xffA876DE),
                  onPrimary: Colors.white,
                  surface: Color(0xffA876DE),
                  onSurface: Colors.black,
                ),
                dialogTheme: const DialogTheme(),
              ),
              child: child!,
            ));
    if (newDate == null) return; // 취소 버튼 클릭

    setState(() {
      date = newDate;
    });
  }
}
