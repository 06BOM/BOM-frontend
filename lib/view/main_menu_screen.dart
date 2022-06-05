import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../network/socket_method.dart';
import 'components/quiz/custom_button.dart';
import 'create_room_screen.dart';
import 'join_room_screen.dart';

class MainMenuScreen extends ConsumerStatefulWidget {
  static String routeName = '/main-menu';

  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends ConsumerState<MainMenuScreen> {
  final SocketMethods _socketMethods = SocketMethods(); // connect

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }
  @override
  void dispose() {
    print(context);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _socketMethods.checkConnect();
    print('context : $context in MainMenuScreen');
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