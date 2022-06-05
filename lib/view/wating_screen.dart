import 'package:bom_front/utils/colors.dart';
import 'package:bom_front/view/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;
import '../network/socket_method.dart';
import '../provider/room_data_provider.dart';
import 'components/quiz/game_ready_button.dart';

class WaitingLobby extends ConsumerStatefulWidget {
  static String routeName = '/waiting-room';

  const WaitingLobby({Key? key}) : super(key: key);

  @override
  ConsumerState<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends ConsumerState<WaitingLobby>
    with SingleTickerProviderStateMixin {
  final roomMsgController = TextEditingController();
  late AnimationController _controller;
  final pageController = PageController(initialPage: 0);
  int watingTime = 5;
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        vsync: this, duration: Duration(seconds: watingTime));
    // animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.addListener(() async {
      print(
          '...${_controller.value} on controller listening'); // _controller의 5 -> 4-> 3 -> 2 때문에 출력
      if (_controller.status == AnimationStatus.completed) {
        // _controller.reset(); // 0초가 되면 5로 되돌아옴
        Navigator.pushNamed(
            context,
            QuizScreen
                .routeName); // Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen()));
        print('successfully move');
      }
    });
    _socketMethods.showGameRoom();
  }

  @override
  void didChangeDependencies() {
    _socketMethods.toggleTimerListener(ref, _controller);
    _socketMethods.displayScoreboardListener(ref);
    _socketMethods.updatePlayersListener(ref);
    _socketMethods.updateMsgListener(ref);
    _socketMethods.exitRoomAnswerListener(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    print(context);
    // _socketMethods.disconnect();
    _controller.dispose();
    roomMsgController.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List<dynamic> roomUsers = ref.watch(roomDataProvider.notifier).state;
    List<dynamic> roomUsers = ref.watch(roomUsersProvider);
    print('$roomUsers in waitingScreen');
    // List<String> roomMsgs = ref.watch(roomMsgProvider.notifier).state;
    // List<String> roomMsgs = ref.watch(roomMsgProvider);
    //
    // print('$roomUsers $roomMsgs in watinglobby building...');
    return SafeArea(
        child: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('images/background.png'), // 배경 이미지
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: GestureDetector(
            child: Transform(
                transform: Matrix4.rotationY(math.pi),
                alignment: Alignment.center,
                child: Icon(Icons.logout, color: Colors.white)),
            onTap: () {
              _socketMethods.handleRoomExit(context, ref);
              // Navigator.pop(context);
            },
          ),
          actions: [
            GestureDetector(
              onTap: () {},
              child: Icon(Icons.settings, color: Colors.white),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Chip(
                    label: Text(
                      '게임을 준비하고 있습니다...',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                      animation: _controller,
                      builder: (BuildContext context, Widget? child) {
                        return Text(
                          // animation.value.toString(),
                          '${5 - (_controller.value * 5).floor()}',
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        );
                      }),
                ],
              ),
              const Text('참여할 유저 대기 중...'),
              // const SizedBox(height: 20),
              // CustomTextField(
              //   controller: roomIdController,
              //   hintText: '',
              //   isReadOnly: true,
              // ),
              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (var i = 0; i < roomUsers.length; i++)
                        Column(
                          children: [
                             Image.network('https://bom-mocktest.s3.ap-northeast-2.amazonaws.com/dog.png', height: 60, fit: BoxFit.fill),
                            Stack(
                              children: <Widget>[
                                Text(
                                  roomUsers[i],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..style = PaintingStyle.stroke
                                        ..strokeWidth = 3
                                        ..color = Colors.grey[300]!,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 30.0,
                                          color: Colors.blue,
                                          offset: Offset(2.0, 2.0),
                                        ),
                                      ]
                                  ),
                                ),
                                Text(
                                  roomUsers[i],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.yellow,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 30.0,
                                          color: Colors.blue,
                                          offset: Offset(2.0, 2.0),
                                        ),
                                      ]
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GameReadyButton(controller: _controller, socketObj: _socketMethods),
              Expanded(
                  flex: 2,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    // height: 200.0,
                    color: Colors.black.withOpacity(0.2),
                    margin: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  // for (var msg in roomMsgs)
                                  //   Container(
                                  // constraints: BoxConstraints(
                                  //   maxWidth: MediaQuery.of(context).size.width * 0.80,
                                  // ),
                                  // padding: EdgeInsets.all(10),
                                  // margin: EdgeInsets.symmetric(vertical: 10),
                                  //     alignment: Alignment.topLeft,
                                  //     child: Text(msg),
                                  //   )
                                  Text('hi')
                                ],
                              );
                            },
                          ),
                        ),
                        sendMessageArea(roomMsgController, _socketMethods, ref)
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}

Widget sendMessageArea(TextEditingController roomMsgController, SocketMethods socketMethods, WidgetRef ref) {
  return Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          height: 70,
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: roomMsgController,
                  decoration: InputDecoration.collapsed(
                    hintText: '메시지를 입력해주세요',
                  ),
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                iconSize: 25,
                color: bgColor,
                onPressed: () {
                  socketMethods.sendMsg(roomMsgController.text, ref);
                },
              ),
            ],
          ),
        );
}
