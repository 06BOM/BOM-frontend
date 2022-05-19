// isPartyLeader : true일 경우 시작 -> 단, 플레이어가 2명 이상일경우 겜임시작 버튼 활성화
import 'package:flutter/material.dart';

import 'custom_button.dart';

class GameReadyButton extends StatefulWidget {
  AnimationController controller;
  GameReadyButton({Key? key, required this.controller}) : super(key: key);

  @override
  State<GameReadyButton> createState() => _GameReadyButtonState();
}

class _GameReadyButtonState extends State<GameReadyButton> {
  // final SocketMethods _socketMethods = SocketMethods();
  var playerMe = null;
  bool isBtn = true;

  // late RoomDataProvider game;

  // @override
  // void initState() {
  //   game = Provider.of<RoomDataProvider>(context, listen: false);
  //   print(game.roomData['players']);
  //   findPlayerMe(game);
  //   super.initState();
  // }

  // void findPlayerMe(RoomDataProvider roomDataProvider){
  //   game.roomData['players'].forEach((player) {
  //     if (player['socketID'] == SocketClient.instance.socket!.id) {
  //       playerMe = player;
  //     }
  //   });
  // }
  //
  // void handleStart(RoomDataProvider gameData){
  //   _socketMethods.startReadyTimer(gameData.roomData['_id'], playerMe['_id']);
  //   setState(() {
  //     isBtn = false;
  //   });
  // }
  void handleStart() {
    widget.controller.forward();
    setState(() {
      isBtn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final gameData = Provider.of<RoomDataProvider>(context); // build function 안에 있으므로 listen: false X 따라서 initState에서 해줬던 걸 다시 해줌 provider 단점..
    // 가정: 일단 유저는 들어오면 무조건 준비를 해야한다 (게임시작시 방장도 게임 준비로 버튼 변경)
    // return playerMe['isPartyLeader'] && isBtn
    //     ? CustomButton(onTap: () => /*handleStart(gameData)*/{}, title: '게임 시작')
    //     : CustomButton(
    //         onTap: () {
    //           print('게임 준비 클릭 -> 로직 작성하기');
    //         },
    //         title: '게임 준비');
    return isBtn
        ? CustomButton(onTap: () => handleStart(), title: '게임 시작')
        : CustomButton(
            onTap: () {
              print('게임 준비 클릭 -> 로직 작성하기');
            },
            title: '게임 준비');
  }
}
