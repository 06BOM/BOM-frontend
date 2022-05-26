// isPartyLeader : true일 경우 시작 -> 단, 플레이어가 2명 이상일경우 겜임시작 버튼 활성화
import 'package:bom_front/network/socket_method.dart';
import 'package:bom_front/provider/room_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'custom_button.dart';

class GameReadyButton extends ConsumerStatefulWidget {
  AnimationController controller;
  final gameRoomInfo;
  final SocketMethods socketObj;

  GameReadyButton(
      {Key? key,
      required this.controller,
      required this.gameRoomInfo,
      required this.socketObj})
      : super(key: key);

  @override
  ConsumerState<GameReadyButton> createState() => _GameReadyButtonState();
}

class _GameReadyButtonState extends ConsumerState<GameReadyButton> {
  // final SocketMethods _socketMethods = SocketMethods();
  var playerMe = null;
  bool isBtn = true;

  @override
  void initState() {
    widget.socketObj.checkReadyListener(widget.gameRoomInfo[0]);
    widget.socketObj.isCompleteReadyListener(ref);
    super.initState();
  }

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
  void toggleButton() {
    widget.socketObj.toggleReadyButton(widget.gameRoomInfo[0]);
    setState(() {
      isBtn = !isBtn;
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
    // if(ref.watch(timerProvider.notifier).state){ // 리렌더링시 주의
    //   widget.controller.forward();
    //   // ref.read(timerProvider.notifier).state = false;
    // }
    return widget.gameRoomInfo[3] != 0
        ? (isBtn
            ? CustomButton(
                onTap: () {
                  toggleButton();
                },
                title: '게임 준비')
            : CustomButton(
                onTap: () {
                  toggleButton();
                },
                title: '준비 취소'))
        : CustomButton(title: '게임 시작', onTap: () {
          if(ref.watch(readyDataProvider.notifier).state){
            widget.socketObj.startGame(widget.gameRoomInfo[0]);
            widget.socketObj.fetchQuestion(widget.gameRoomInfo[0]);
            print('in game ready button');
          }
    });
  }
}
