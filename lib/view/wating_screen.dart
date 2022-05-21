import 'package:bom_front/provider/room_data_provider.dart';
import 'package:bom_front/utils/colors.dart';
import 'package:bom_front/view/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;
import '../network/socket_method.dart';
import 'components/quiz/custom_textfield.dart';
import 'components/quiz/game_ready_button.dart';

class WaitingLobby extends StatefulWidget {
  static String routeName = '/waiting-room';

  const WaitingLobby({Key? key}) : super(key: key);

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby>
    with SingleTickerProviderStateMixin {
  final roomIdController = TextEditingController();
  late AnimationController _controller;
  final pageController = PageController(initialPage: 0);
  int watingTime = 5;

  // late Animation<double> animation;
  int _currentPage = 0;
  final SocketMethods _socketMethods = SocketMethods();

  // @override
  // void initState() {
  //   super.initState();
  //   _socketMethods.updateRoomListener(context);
  //   _socketMethods.startGameListener(context);
  //   _socketMethods.updatePlayersStateListener(context);
  //   _socketMethods.endGameListener(context);
  // }

  @override
  void initState() {
    super.initState();
    _socketMethods.exitRoomAnswerListener(context);
    _controller = new AnimationController(
        vsync: this, duration: Duration(seconds: watingTime));
    // animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.addListener(() async {
      print('addlistener');
      if (_controller.status == AnimationStatus.completed) {
        // _controller.reset(); // 0초가 되면 5로 되돌아옴
        print('_controller.status == AnimationStatus.completed');
        if (_currentPage < 1) {
          // if (_currentPage < 2) {
          _currentPage++;
          pageController.animateToPage(_currentPage,
              duration: Duration(milliseconds: 300), curve: Curves.easeInSine);
        } else {
          _currentPage = 0;
          print('페이지 이동하기 바로 전 로직');
          await Future.delayed(Duration(seconds: 1), () {
            // 안됨 ???
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => QuizScreen()));
          });
          print('3초 후 in 게임시작 화면 -> countdown 5초도 포함?');
        }
      }
    });
  }

  // final SocketMethods _socketMethods = SocketMethods();

  // @override
  // void initState() {
  //   super.initState();
  //   _socketMethods.updateReadyTimer(context);
  //   roomIdController = TextEditingController(
  //     text:
  //     Provider.of<RoomDataProvider>(context, listen: false).roomData['_id'],
  //   );
  // }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    roomIdController.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _controller.forward();
    // final clientStateProvider = Provider.of<ClientDataProvider>(context);
    // _controller.forward();
    print('wating sreen building...');
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
            child: Consumer(
              builder: (context, ref, child) {
                final roomName = ref.watch(roomDataProvider)[0];
                print('${roomName} in Consumer of wating sreen building...');
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    leading: GestureDetector(
                      child: Transform(
                          transform: Matrix4.rotationY(math.pi),
                          alignment: Alignment.center,
                          child: Icon(Icons.logout, color: Colors.white)),
                      onTap: () {
                        _socketMethods.handleRoomExit(context, roomName);
                        // Navigator.pop(context);
                      },
                    ),
                    actions: [
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.settings,
                        ),
                      ),
                    ],
                  ),
                  body: PageView.builder(
                    controller: pageController,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (value) {
                      _controller.forward();
                    },
                    itemBuilder: (BuildContext context, int index) {
                      print('$index');
                      return index == 0
                          ? Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return Text(
                                      // animation.value.toString(),
                                      '${5 - (_controller.value * 5).floor()}',
                                      style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    );
                                  }),
                            ],
                          ),
                          const Text('참여할 유저 대기 중...'),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: roomIdController,
                            hintText: '',
                            isReadOnly: true,
                          ),
                          const SizedBox(height: 20),
                          GameReadyButton(controller: _controller),
                          Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                // height: 200.0,
                                color: Colors.black.withOpacity(0.2),
                                margin: const EdgeInsets.only(
                                  top: 80.0,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('안녕하세요'),
                                  ],
                                ),
                              ))
                        ],
                      )
                          : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 150.0,
                            color: bgColor,
                            margin: const EdgeInsets.only(
                              top: 80.0,
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  children: <Widget>[
                                    Text(
                                      // index < 2 ? '준비':'시작',
                                      '시작',
                                      style: TextStyle(
                                          fontSize: 50,
                                          fontWeight: FontWeight.w500,
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = 3
                                            ..color = Colors.grey[300]!,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 25.0,
                                              color: Colors.black
                                                  .withOpacity(0.2),
                                              offset: Offset(5.0, 5.0),
                                            ),
                                          ],
                                          letterSpacing: 4.0),
                                    ),
                                    Text(
                                      // index < 2 ? '준비':'시작',
                                      '시작',
                                      style: TextStyle(
                                          fontSize: 50,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.yellow,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 2.0,
                                              color: Colors.black
                                                  .withOpacity(0.2),
                                              offset: Offset(5.0, 5.0),
                                            ),
                                          ],
                                          letterSpacing: 4.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
        ));
  }
}
