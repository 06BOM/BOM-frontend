import 'package:bom_front/network/socket_client.dart';
import 'package:bom_front/view/wating_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/utils.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  // 닉네임 제출은 의도 파악하고 적용하기
  // EMITS
  void createRoom(String nickname, String roomName) {
    if (nickname.isNotEmpty && roomName.isNotEmpty) {
      _socketClient.emit('enter_room', { // createRoom -> enter_room
        'nickname': nickname,
        'roomName': roomName,
      });
    }
  }

  void joinRoom(String nickname, String roomName) {
    if (nickname.isNotEmpty && roomName.isNotEmpty) {
  // BOM에서는 enter_room에서 create과 join 모두 처리해서 필요 x
  //     _socketClient.emit('joinRoom', {
      _socketClient.emit('enter_room', {
        'nickname': nickname,
        'roomName': roomName,
      });
    }
  }

  void createRoomSuccessListener(BuildContext context) {
    print('listen createRoomSuccessListener in socket_methods');
    _socketClient.on('welcome', (room) {
      // room -> [유저2, 들어오세용, 2] -> 즉, 다른 한명이 들어와야 welcom을 받음 -> 이후 첫번째, 두번째 사람들 waiting 방으로 -> 바꾸자
      print('$room in createRoomSuccessListener function');
      // Provider.of<RoomDataProvider>(context, listen: false)
      //     .updateRoomData(room);
      Navigator.pushNamed(context, WaitingLobby.routeName);
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on('joinRoomSuccess', (room) {
      // Provider.of<RoomDataProvider>(context, listen: false)
      //     .updateRoomData(room);
      Navigator.pushNamed(context, WaitingLobby.routeName);
    });
  }

  void errorOccuredListener(BuildContext context) { // server 내용 초기화하고 push하기 (code review에 나기기)
    _socketClient.on('message specific user', (data){
      print('error data => $data');
      showSnackBar(context, data);
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on('createRoomSuccess', (room) {
      // Provider.of<RoomDataProvider>(context, listen: false)
      //     .updateRoomData(room);
    });
  }
}