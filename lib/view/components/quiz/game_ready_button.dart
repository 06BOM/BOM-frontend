// isPartyLeader : true일 경우 시작 -> 단, 플레이어가 2명 이상일경우 겜임시작 버튼 활성화
import 'package:bom_front/network/socket_method.dart';
import 'package:bom_front/provider/room_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'custom_button.dart';

class GameReadyButton extends ConsumerStatefulWidget {
  AnimationController controller;
  final SocketMethods socketObj;

  GameReadyButton(
      {Key? key,
      required this.controller,
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
    // widget.socketObj.checkReadyListener(ref);
    // widget.socketObj.isCompleteReadyListener(ref);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    widget.socketObj.checkReadyListener(ref);
    widget.socketObj.isCompleteReadyListener(ref);
    super.didChangeDependencies();
  }
  void toggleButton() {
    widget.socketObj.toggleReadyButton(ref);
    setState(() {
      isBtn = !isBtn;
    });
  }

  @override
  Widget build(BuildContext context) {
    int isRoomHost = ref.watch(roomDataProvider.notifier).state[3];
    return isRoomHost != 0
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
            widget.socketObj.startGame(ref);
            print('in game ready button');
          }
    });
  }
}
