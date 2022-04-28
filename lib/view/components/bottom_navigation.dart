// navigation bar는 임시이므로 riverpod로 구현할 것
import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  int index;

  BottomNavigationBarWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<BottomNavigationBarWidget> createState() =>
      BottomNavigationBarWidgetState();
}

class BottomNavigationBarWidgetState
    extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.group), label: "커뮤니티"),
        BottomNavigationBarItem(icon: Icon(Icons.sports_esports), label: "게임"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
        BottomNavigationBarItem(icon: Icon(Icons.work_outline), label: "캐릭터"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: "마이페이지"),
      ],
      currentIndex: widget.index,
      onTap: (int index) => setState(() => widget.index = index),
      selectedItemColor: Colors.deepPurple,
    );
  }
}