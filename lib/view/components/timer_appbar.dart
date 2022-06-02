import 'package:flutter/material.dart';


class TimerAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TimerAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  State<TimerAppBar> createState() => _TimerAppBarState();

  @override
  final Size preferredSize; // default is 56.0
}

class _TimerAppBarState extends State<TimerAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xffC9A0F5),
      title: const Text(
        "plan",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ), // 나중에 과목api 받아오기
      centerTitle: true,
      elevation: 0.0,
      leading: IconButton(
        //뒤로가기 버튼
        icon: const Icon(Icons.arrow_back),
        tooltip: "Back page",
        onPressed: () {
          Navigator.pop(context); // 뒤로가기
        },
      ),
    );
  }
}
