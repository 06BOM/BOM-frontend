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

class WaitingLobby extends ConsumerStatefulWidget {
  static String routeName = '/waiting-room';

  const WaitingLobby({Key? key}) : super(key: key);

  @override
  ConsumerState<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends ConsumerState<WaitingLobby>
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
    _socketMethods.displayScoreboardListener();
  }

  @override
  void didChangeDependencies() {
    _socketMethods.toggleTimerListener(ref, _controller);
    _socketMethods.exitRoomAnswerListener(context);
    super.didChangeDependencies();
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
    print(context);
    // _socketMethods.disconnect();
    _controller.dispose();
    roomIdController.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final clientStateProvider = Provider.of<ClientDataProvider>(context);
    // final roomName = ref.watch(roomDataProvider);
    // bool trigger = ref.watch(timerProvider.notifier).state;
    // print('time trigger => ${trigger}');

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
        body: Column(
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
            const SizedBox(height: 20),
            CustomTextField(
              controller: roomIdController,
              hintText: '',
              isReadOnly: true,
            ),
            const SizedBox(height: 20),
            GameReadyButton(
                controller: _controller,
                socketObj: _socketMethods),
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
        ),
      ),
    ));
  }
}
