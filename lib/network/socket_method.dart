import 'package:bom_front/network/socket_client.dart';
import 'package:bom_front/view/wating_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/src/consumer.dart';

import '../provider/room_data_provider.dart';
import '../utils/utils.dart';
import '../view/main_menu_screen.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;
  // dynamic _roomData = '';
  // dynamic get roomData async => await _roomData;
  // 닉네임 제출은 의도 파악하고 적용하기
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
      // BOM에서는 enter_room에서 create과 join 모두 처리해서 필요 x
      _socketClient.emit('join_room', {
        'nickname': nickname,
        'roomName': roomName,
      });
    }
  }

  void handleRoomExit(BuildContext context, String roomName) {
    if(roomName.isNotEmpty){
      _socketClient.emit('exit_room',{
        "roomName": roomName,
      });
    }
    // print('나가기'); // dispose -> autodispose x
    // //첫 페이지 위젯으로 이동하면서 연결된 모든 위젯을 트리에서 삭제
    // Navigator.pushNamedAndRemoveUntil(context, MainMenuScreen.routeName, (route) => false);
  }

  void createRoomSuccessListener(BuildContext context, WidgetRef ref) {
    print('listen createRoomSuccessListener in socket_methods');
    _socketClient.on('create_room', (roomData) {
      //[방이름, 참여인원]
      print('$roomData in createRoomSuccessListener function');
      // Provider.of<RoomDataProvider>(context, listen: false).updateRoomData(room);
      // _roomData = await room;
      ref.watch(roomDataProvider.notifier).updateRoomData(roomData);
      // Navigator.pushNamed(context, WaitingLobby.routeName);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WaitingLobby()),
      );
    });
  }

  void createRoomFailListener(BuildContext context){
    _socketClient.on('already exist', (data){
      print('error data => $data');
      showSnackBar(context, data);
    });
  }

  void getJoinedUserName(BuildContext context, WidgetRef ref){ // joinRoomSuccessListener
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

  void exitRoomAnswerListener(BuildContext context){
    print('나가기');
    _socketClient.on('bye', (data){
      print('${data[0]}님 퇴장 / 방이름: ${data[1]}, 참여인원 : ${data[2] ?? 0}명'); // dispose -> autodispose x
      //첫 페이지 위젯으로 이동하면서 연결된 모든 위젯을 트리에서 삭제
      Navigator.pushNamedAndRemoveUntil(context, MainMenuScreen.routeName, (route) => false);
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