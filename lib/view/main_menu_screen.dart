import 'package:flutter/material.dart';

import 'components/quiz/custom_button.dart';
import 'create_room_screen.dart';
import 'join_room_screen.dart';

class MainMenuScreen extends StatelessWidget {
  static String routeName = '/main-menu';

  const MainMenuScreen({Key? key}) : super(key: key);

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(onTap: () => createRoom(context), title: '방 생성'),
                const SizedBox(height: 20.0),
                CustomButton(onTap: () => joinRoom(context), title: '방 참여'),
              ],
            ),
          ));
  }
}