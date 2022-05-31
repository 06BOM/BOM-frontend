// navigation bar는 임시이므로 riverpod로 구현할 것
import 'package:bom_front/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarWidget> createState() =>
      BottomNavigationBarWidgetState();
}

class BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final buttonIndex = ref.watch(bottomNavigationBarIndex.notifier).state;
      print('buttonIndex: $buttonIndex in BottomNavigationBarWidget');
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "커뮤니티"),
          BottomNavigationBarItem(
              icon: Icon(Icons.sports_esports), label: "게임"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.work_outline), label: "캐릭터"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "마이페이지"),
        ],
        currentIndex: buttonIndex,
        onTap: (int index) =>
            {ref.read(bottomNavigationBarIndex.notifier).state = index},
        selectedItemColor: Colors.deepPurple,
      );
    });
  }
}
