import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:bom_front/provider/timer_provider.dart';

import '../provider/todo_provider.dart';

// class TimerApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: TimerPage(),
//     );
//   }
// }

class TimerPage extends ConsumerWidget {
  TimerPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(timerProvider);
    print('building TimerPage =>>> ');
    return Scaffold(
      backgroundColor: Color(0xffC9A0F5),
      appBar: AppBar(title: Text('My Timer App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 360,
              height: 360,
              decoration: BoxDecoration(
                color: Color(0xffA876DE),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white60,
                  width: 5,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: ButtonsContainer(),
                    top: -30,
                    right: -30,
                  ),
                  Positioned(
                    child: TimerTextWidget(),
                    top: 120,
                    right: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, TimerModel>(
  (ref){
    return TimerNotifier();
  },
);

final _timeLeftProvider = Provider<String>((ref) {
  return ref.watch(timerProvider).timeLeft;
});

final timeLeftProvider = Provider<String>((ref) {
  return ref.watch(_timeLeftProvider);
});

class TimerTextWidget extends HookConsumerWidget {
  const TimerTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeLeft = ref.watch(timeLeftProvider);
    print('building TimerTextWidget $timeLeft');
    return Text(
      timeLeft,
      style: TextStyle(fontSize: 80, color: Colors.white),
      textAlign: TextAlign.center,
    );
  }
}

int initState() {
  int initialTime = 0;
  var ref;
  AsyncValue<int> user_time = ref.watch(userTimeLeftProvider);
  user_time.when(
      data: ((data) => initialTime = data),
      error: (err, stack) => Text("Error: $err"),
      loading: () => Container());

  return initialTime;
}

final _buttonState = Provider<ButtonState>((ref) {
  return ref.watch(timerProvider).buttonState;
});

final buttonProvider = Provider<ButtonState>((ref) {
  return ref.watch(_buttonState);
});

class ButtonsContainer extends HookConsumerWidget {
  const ButtonsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('building ButtonsContainer');

    final state = ref.watch(buttonProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (state == ButtonState.initial) ...[
          StartButton(),
        ],
        if (state == ButtonState.started) ...[
          PauseButton(),
        ],
        if (state == ButtonState.paused) ...[
          StartButton(),
        ],
      ],
    );
  }
}

class StartButton extends ConsumerWidget {
  const StartButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        ref.read(timerProvider.notifier).start();
        print("start pressed");
      },
      icon: Icon(
        Icons.play_arrow,
        color: Color(0xff9747FF),
      ),
      iconSize: 400,
    );
  }
}

class PauseButton extends ConsumerWidget {
  const PauseButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        ref.read(timerProvider.notifier).pause();
        print("stop pressed");
      },
      icon: Icon(Icons.pause, color: Color(0xff9747FF)),
      iconSize: 400,
    );
  }
}
