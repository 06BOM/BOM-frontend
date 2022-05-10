import 'package:bom_front/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:bom_front/provider/timer_provider.dart';
import '../provider/todo_provider.dart';

final timerProvider = StateNotifierProvider.family<TimerNotifier, TimerModel, int>((ref, id){
  // ref.watch(todoListProvider).where((el) => el.planId == id).toList()[0].time;
  return TimerNotifier(ref, id);
},);

class TimerPage extends ConsumerWidget {
  Todo todo;
  TimerPage(this.todo);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(timerProvider(todo.planId!));
    print('planItem ${todo.planId} ${todo.planName} rebuilding... in timer_view');
    return Scaffold(
      backgroundColor: Color(0xffC9A0F5),
      appBar: AppBar(
          title: Text('${todo.planName}'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          foregroundColor: Colors.white,
      ),
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
                    child: ButtonsContainer(todo.planId),
                    top: -30,
                    right: -30,
                  ),
                  Positioned(
                    child: TimerTextWidget(todo.planId),
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

class TimerTextWidget extends HookConsumerWidget {
  final planId;
  const TimerTextWidget(this.planId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeLeft = ref.watch(timerProvider(planId)).timeLeft;
    print('building TimerTextWidget $timeLeft');
    return Text(
      timeLeft ?? 'Error',
      style: TextStyle(fontSize: 80, color: Colors.white),
      textAlign: TextAlign.center,
    );
  }
}

class ButtonsContainer extends HookConsumerWidget {
  final planId;
  const ButtonsContainer(this.planId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('building ButtonsContainer');

    final state = ref.watch(timerProvider(planId)).buttonState;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (state == ButtonState.initial) ...[
          StartButton(planId),
        ],
        if (state == ButtonState.started) ...[
          PauseButton(planId),
        ],
        if (state == ButtonState.paused) ...[
          StartButton(planId),
        ],
      ],
    );
  }
}

class StartButton extends ConsumerWidget {
  final planId;
  const StartButton(this.planId, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        ref.read(timerProvider(planId).notifier).start();
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
  final planId;
  const PauseButton(this.planId,{Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        ref.read(timerProvider(planId).notifier).pause();
        print("stop pressed");
      },
      icon: Icon(Icons.pause, color: Color(0xff9747FF)),
      iconSize: 400,
    );
  }
}

// int initState() {
//   int initialTime = 0;
//   var ref;
//   AsyncValue<int> user_time = ref.watch(userTimeLeftProvider);
//   user_time.when(
//       data: ((data) => initialTime = data),
//       error: (err, stack) => Text("Error: $err"),
//       loading: () => Container());
//
//   return initialTime;
// }