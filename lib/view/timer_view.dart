/* this is timer_model.dart */
import 'package:bom_front/model/todo.dart';
import 'package:bom_front/repository/timer_repository.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bom_front/view/components/timer_appbar.dart';

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'StopWatch', home: TimerPage());
  }
}

class TimerPage extends StatefulWidget {
  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late Timer _timer; //타이머
  var _time = 0; //실제 늘어난 시간
  var _isRunning = false; // 시작/정지의 상태

  Todo todo = new Todo();

  void initState() {
    final result = TimerRepository().getTimerData();
    print(result);
    super.initState();
    updateData();
    //해당 일정의 시간, 카테고리 색,일정 내용 가져와야함
  }

  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void updateData() {
    _time = todo.time ?? 0;
  }

  void _clickButton() {
    _isRunning = !_isRunning;

    if (_isRunning) {
      _start();
    } else {
      _pause();
    }
  }

  void _start() {
    int count = 0;
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _time++;
        count++;
        if (count == 30) {
          count = 0;
          TimerRepository()
              .postStarData(1); // 별개수 받아와야하는데 그거에 대해서 논의의          //별보내기
        }
      });
    });
  }

  void _pause() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TimerAppBar(),
      body: _buildbody(),
    );
  }

  Widget _buildbody() {
    var min = '${_time ~/ 6000}'.padLeft(2, '0');
    var sec = '${_time ~/ 100}'.padLeft(2, '0');
    var hundredth = '${_time % 100}'.padLeft(2, '0');

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                Container(
                  width: 360,
                  height: 360,
                  // color: Colors.grey,
                  decoration: BoxDecoration(
                    // color: '$color',
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black38,
                      width: 5,
                    ),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(10, 10),
                          color: Colors.black38,
                          blurRadius: 15),
                      BoxShadow(
                          offset: Offset(-10, -10),
                          color: Colors.white.withOpacity(0.5),
                          blurRadius: 15),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: -20,
              right: 110,
              child: Container(
                child: Image.asset(
                  'images/character.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            Positioned(
              top: 150,
              right: 30,
              child: Text(
                "$min:$sec:$hundredth",
                style: TextStyle(fontSize: 60, color: Colors.grey.shade900),
              ),
            ),
            Positioned(
              top: 100,
              right: 70,
              child: Container(
                child: Text(
                  "오늘은: 00:00:00",
                  style: TextStyle(fontSize: 20, color: Colors.grey.shade900),
                ),
              ),
            ),
            Positioned(
              top: 130,
              right: 80,
              child: TextButton(
                onPressed: () => setState(() {
                  _clickButton();
                }),
                child: _isRunning
                    ? Icon(
                        Icons.pause,
                        size: 100,
                      )
                    : Icon(
                        Icons.play_arrow,
                        size: 100,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
