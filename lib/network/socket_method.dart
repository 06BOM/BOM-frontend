import 'package:bom_front/network/socket_client.dart';
import 'package:bom_front/view/wating_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'dart:convert';
import '../provider/room_data_provider.dart';
import '../utils/utils.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket;

  // 닉네임 제출은 의도 파악하고 적용하기
  void disconnect() {
    _socketClient.disconnect();
    print('wating dispose test in socketMethods');
  }

  void checkConnect() {
    print('connect');
  }

  // EMITS
  void createRoom(String nickname, String roomName, String grade, String subject) {
    print('userNickname : $nickname / roomName : $roomName');
    Map<String, dynamic> data = {
      "roomName": roomName,
      "kind": 0,
      "userId": 1, // 추후 변경하기
      "grade": int.parse(grade),
      "subject": subject,
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
        'userId': 2,
      });
    }
  }

  void handleRoomExit(BuildContext context, WidgetRef ref) {
    String roomName = ref.watch(roomDataProvider.notifier).state[0];
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

  void checkReadyListener(WidgetRef ref) {
    String roomName = ref.watch(roomDataProvider.notifier).state[0];
    _socketClient.on('ready check', (data) { // data 전달 안할 시 null
      _socketClient.emit('ready check', {
        "roomName": roomName,
      });
    });
  }

  void toggleReadyButton(WidgetRef ref) {
    String roomName = ref.watch(roomDataProvider.notifier).state[0];
    _socketClient.emit('ready', {
      "roomName": roomName,
    });
  }

  void startGame(WidgetRef ref) {
    String roomName = ref.watch(roomDataProvider.notifier).state[0];
    _socketClient.emit("gameStartFunction", {
      'roomName': roomName,
    });
  }

  void fetchQuestion(WidgetRef ref){
    String roomName = ref.watch(roomDataProvider.notifier).state[0];
    print('run fetchQuestion $roomName');
    _socketClient.emit("question", {
      'roomName': roomName,
    });
  }

  void answerQuestion(String roomName){
    print('run answerQuestion');
    _socketClient.emit("answer", {
      'roomName': roomName,
    });
  }

  void selectOX(String ox){
    _socketClient.emit("ox", {
      'userId': 1,
      'ox': ox,
    });
  }

  void scoreRound(String roomName, WidgetRef ref){
    print('run scoreRound ${ref.watch(roundDataProvider.notifier).state[1]}........ㅇㅋㅇㅋ.............ㅇㅋㅇㅋ..............ㅇㅋㅇㅋ..........................dzdzㅇㅋㅇㅋ');
    _socketClient.emit("score", {
      'index': ref.watch(roundDataProvider.notifier).state[1],
      'roomName': roomName
    });
  }

  void allRoundFinish(String roomName){
    print('finish all round');
    _socketClient.emit("all finish", {
      'roomName': roomName
    });
  }

  void sendMsg(String msg, WidgetRef ref){
    String room = ref.watch(roomDataProvider.notifier).state[0];
    print('sending message...');
    _socketClient.emit("new_message", {
      'msg': msg,
      'room': room
    });
  }

  void isCompleteReadyListener(WidgetRef ref) {
    _socketClient.on('ready', (data) {
      ref.watch(readyDataProvider.notifier).state = data; // data = true
      print('all user ready!');
    });
  }

  void createRoomSuccessListener(BuildContext context, WidgetRef ref) {
    print('listen createRoomSuccessListener in socket_methods');
    _socketClient.on('create_room', (roomData) {
      print('$roomData in createRoomSuccessListener function | context : $context'); // [테스트4, 1, 유저1, 0] -> [방이름, 현재인원, 닉네임, 0=> 방장]
      // List<dynamic> list = json.decode(roomData);
      // print(list);
      // ref.watch(roomDataProvider.notifier).updateRoomData(list);
      ref.read(roomDataProvider.notifier).updateRoomData(roomData);
      ref.watch(roomUsersProvider.notifier).state = json.decode(roomData[2]);
      print('createroom ref 이후...');
      toggleReadyButton(ref); // 방장은 미리 준비ㅇ
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
      print('$roomData in getJoinedUserName function | context : $context'); //
      // List<dynamic> list = json.decode(roomData);
      // print(list);
      // ref.watch(roomDataProvider.notifier).updateRoomData(list);
      ref.watch(roomUsersProvider.notifier).state = json.decode(roomData[2]);
      ref.read(roomDataProvider.notifier).updateRoomData(roomData);
      Navigator.pushNamed(context, WaitingLobby.routeName);
    });
  }

  void updatePlayersListener(WidgetRef ref){
    _socketClient.on('update_players', (users){
      ref.watch(roomUsersProvider.notifier).state = json.decode(users);
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

  void displayScoreboardListener(WidgetRef ref){
    _socketClient.on('scoreboard display', (users){
      List<dynamic> list = json.decode(users);
      print('${list} in displayScoreboardListener'); // "[["유저1",0],["유저2",0]]" -> users로 전역변수로 둬야함
      ref.watch(scoreProvider.notifier).updateScore(list);
    });
  }

  void showGameRoom(){
    _socketClient.on('showGameRoom', (data){
      print('$data in showGameRoom'); // null
    });
  }

  void toggleTimerListener(WidgetRef ref, AnimationController controller){
    _socketClient.on('timer', (toggle){ // true
      print('$toggle in toggleTimerListener');
      // ref.read(timerProvider.notifier).state = toggle; // 바뀌어도 rebuilding이 안됨.
      controller.forward();
    });
  }

  void createRoundListener(WidgetRef ref){
    _socketClient.on('round', (data){
      print('$data in createRoundListener');
      ref.watch(roundDataProvider.notifier).updateRoundData(data);
      ref.watch(showAnswerProvider.notifier).state = data[2]; // false
      // data[1]
    });
  }

  void getAnswerListener(WidgetRef ref){ // 굳이 따로 받는 것보다 위에서 부터 받는게 어떤가?
    _socketClient.on('answer', (data){
      print('$data in getAnswerListener');
      ref.watch(answerProvider.notifier).updateAnswerData(data);
      ref.watch(showAnswerProvider.notifier).state = data[2]; // true
    });
  }

  void oxListener(){ // 필요한지 의문
    _socketClient.on('ox', (data){
      print('$data in OXListener');
    });
  }

  void changeScoreListener(WidgetRef ref){
    _socketClient.on('score change', (data){
      List<dynamic> list = json.decode(data);
      print('................................$list in changeScoreListener...................................');
      ref.watch(scoreProvider.notifier).updateScore(list);
    });
  }

  void updateMsgListener(WidgetRef ref){
    _socketClient.on('new_message', (data){
      List<dynamic> list = json.decode(data);
      print('$list in updateMsgListener / ${list.runtimeType}');
      ref.read(roomMsgProvider.notifier).updateMsg(list[0]);
    });
  }
}
