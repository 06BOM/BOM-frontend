import 'package:bom_front/view/create_room_screen.dart';
import 'package:bom_front/view/join_room_screen.dart';
import 'package:bom_front/view/main_menu_screen.dart';
import 'package:bom_front/view/quiz_screen.dart';
import 'package:bom_front/view/wating_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() => runApp(
  ProviderScope(
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: Colors.transparent),
      ),
      routes: {
        MainMenuScreen.routeName: (context) => const MainMenuScreen(),
        JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
        CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
        WaitingLobby.routeName: (context) => const WaitingLobby(),
        QuizScreen.routeName: (context) => const QuizScreen(),
      },
      initialRoute: MainMenuScreen.routeName,
      // home: MainMenuScreen(), // initialRoute때문에 두개가 잡힘
    ),
  )
);