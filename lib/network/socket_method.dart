import 'package:bom_front/network/socket_client.dart';
import 'package:bom_front/view/create_room_screen.dart';
import 'package:bom_front/view/forRoute.dart';
import 'package:bom_front/view/wating_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/src/consumer.dart';

import '../provider/room_data_provider.dart';
import '../utils/utils.dart';
import '../view/main_menu_screen.dart';

class SocketMethods {
  // final _socketClient = SocketClient.instance.socket != null ? SocketClient.instance.socket : throw new Error();
  final _socketClient = SocketClient.instance.socket;

  // dynamic _roomData = '';
  // dynamic get roomData async => await _roomData;
  // 닉네임 제출은 의도 파악하고 적용하기
  void disconnect() {
    _socketClient.disconnect();
    print('wating dispose test in socketMethods');
  }

  void checkConnect() {
    print('connect');
  }

  // EMITS
  void createRoom(String nickname, String roomName) {
    Map<String, dynamic> data = {
      "roomName": roomName,
      "kind": 0,
      "userId": 1, // 추후 변경하기
      "grade": 3,
      "subject": "과학",
      "secretMode": false,
      "password": null,
      "participantsNum": 0
    };
    if (nickname.isNotEmpty && roomName.isNotEmpty) {
      _socketClient.emit('create_room', {
        'nickname': nickname,
        'payload': data,
      });
    }
  }

  void joinRoom(String nickname, String roomName) {
    if (nickname.isNotEmpty && roomName.isNotEmpty) {
      _socketClient.emit('join_room', {
        'nickname': nickname,
        'roomName': roomName,
      });
    }
  }

  void handleRoomExit(BuildContext context, String roomName) {
    print(roomName);
    if (roomName != "") {
      _socketClient.emit('exit_room', {
        "roomName": roomName,
      });
    }
  }

  void checkReady(String roomName) {
    _socketClient.emit('ready check', {
      "roomName": roomName,
    });
  }

  void checkReadyListener(String roomName) {
    _socketClient.on('ready check', (data) { // data 전달 안할 시 null
      _socketClient.emit('ready check', {
        "roomName": roomName,
      });
    });
  }

  void toggleReadyButton(String roomName) {
    _socketClient.emit('ready', {
      "roomName": roomName,
    });
  }

  void startGame(String roomName) {
    _socketClient.emit("gameStartFunction", {
      'roomName': roomName,
    });
  }

  void isCompleteReadyListener(WidgetRef ref) {
    _socketClient.on('ready', (data) {
      ref.read(readyDataProvider.notifier).state = data; // data = true
      print('all user ready!');
    });
  }

  void createRoomSuccessListener(BuildContext context, WidgetRef ref) {
    print('listen createRoomSuccessListener in socket_methods');
    _socketClient.on('create_room', (roomData) {
      //[방이름, 참여인원]
      print('$roomData in createRoomSuccessListener function | context : $context');
      // Provider.of<RoomDataProvider>(context, listen: false).updateRoomData(room);
      // _roomData = await room;
      ref.watch(roomDataProvider.notifier).updateRoomData(roomData);
      toggleReadyButton(roomData[0]); // 방장은 미리 준비ㅇ
      Navigator.pushNamed(context, WaitingLobby.routeName);
    });
  }

  void createRoomFailListener(BuildContext context) {
    _socketClient.on('already exist', (data) {
      print('error data => $data');
      showSnackBar(context, data);
    });
  }

  void getJoinedUserName(BuildContext context, WidgetRef ref) {
    // joinRoomSuccessListener
    print('listen getJoinedUserName in socket_methods');
    // room -> [유저이름, 방이름, 2(참여인원)] (채팅방에 들어온 유저 표시 위함)
    // -> 이후 첫번째, 두번째 사람들 waiting 방으로 -> 바꾸자
    _socketClient.on('welcome', (roomData) {
      // 전역적인 배열에 넣어서 채팅방에 업데이트하기
      ref.watch(roomDataProvider.notifier).updateRoomData(roomData);
      Navigator.pushNamed(context, WaitingLobby.routeName);
    });
  }

  void joinRoomFailListener(BuildContext context) {
    // server 내용 초기화하고 push하기 (code review에 나기기)
    _socketClient.on('already start', (data) {
      print('error data => $data');
      showSnackBar(context, data);
    });
  }

  void exitRoomAnswerListener(BuildContext context) {
    _socketClient.on('bye', (data) {
      print(
          '${data[0]}님 퇴장 / 방이름: ${data[1]}, 참여인원 : ${data[2] ?? 0}명'); // dispose -> autodispose x
      //첫 페이지 위젯으로 이동하면서 연결된 모든 위젯을 트리에서 삭제
      print('context : $context in exitRoomAnswerListener');
      Navigator.popUntil(context, (route) => route.isFirst); // 안됨.. 비동기 처리 전에 삭제해서 그런듯? 아니면 다른 방 나갔을 때, 함께 닫히는 문제도 고려
      // Navigator.pushNamedAndRemoveUntil(context, ForRoute.routeName, (route) => false);
    });
  }

  void displayScoreboardListener(){
    _socketClient.on('scoreboard display', (users){
      print(users); // [["유저1",0],["유저2",0]] -> users로 전역변수로 둬야함
    });
  }

  void showGameRoom(){
    _socketClient.on('showGameRoom', (data){
      print(data); // null
    });
  }

  void toggleTimerListener(WidgetRef ref, AnimationController controller){
    _socketClient.on('timer', (toggle){ // true
      ref.read(timerProvider.notifier).state = toggle; // 바뀌어도 rebuilding이 안됨.
      controller.forward();
    });
  }

// void updateRoomListener(BuildContext context) {
//   _socketClient.on('createRoomSuccess', (room) {
//     // Provider.of<RoomDataProvider>(context, listen: false)
//     //     .updateRoomData(room);
//   });
// }
// 사용x
// void joinRoomSuccessListener(BuildContext context) {
//   _socketClient.on('joinRoomSuccess', (room) {
//     // Provider.of<RoomDataProvider>(context, listen: false)
//     //     .updateRoomData(room);
//     Navigator.pushNamed(context, WaitingLobby.routeName);
//   });
// }
}
