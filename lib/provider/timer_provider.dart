import 'package:bom_front/provider/todo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimerNotifier extends StateNotifier<TimerModel> {
  final ref;
  final id;
  final Ticker _ticker = Ticker();
  StreamSubscription<int>? _tickerSubscription;
  late final int initialTime;
  late final initialState;

  TimerNotifier(this.ref, this.id, [TimerModel? initState]) : super(const TimerModel()){
    initTimer(); // 플랜을 한번씩 누를 때만 호출 됨. 이후는 x
  }

  void initTimer(){
    initialTime = ref.watch(todoListProvider).where((el) => el.planId == id).toList()[0].time;
    initialState = TimerModel(_durationString(initialTime), ButtonState.initial);
    print('컨스트럭트 안 $initialTime / ${ref.watch(todoListProvider).where((el) => el.planId == id).toList()[0].time}');
    state = initialState;
  }

  // final _initialState = TimerModel(
  //   _durationString(_initialTime),
  //   ButtonState.initial,
  // );

  String _durationString(int duration) {
    if (duration % 30 == 0 && duration != 0) {
      // TimerRepository().postStarData(); // opcode 1로 뜸
    } //30분마다 전송
    final hour =
        (((duration / 60) / 60) % 60).floor().toString().padLeft(2, '0');
    final minutes = ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final seconds = (duration % 60).floor().toString().padLeft(2, '0');
    print('$hour:$minutes:$seconds');
    return '$hour:$minutes:$seconds';
  }

  void start() {
    if (state.buttonState == ButtonState.paused) {
      _restartTimer();
    } else {
      _startTimer();
    }
  }

  void _restartTimer() {
    _tickerSubscription?.resume();
    // _sendStar();
    state = TimerModel(state.timeLeft, ButtonState.started);
  }

  void _startTimer() {
    _tickerSubscription?.cancel();
    print(state.timeLeft);
    // _sendStar();
    _tickerSubscription = _ticker.tick(ticks: initialTime).listen((duration) {
      // 한계가 이정도다
      state = TimerModel(_durationString(duration), ButtonState.started);
    });

    _tickerSubscription?.onDone(() {
      state = TimerModel(state.timeLeft, ButtonState.finished);
    });

    state = TimerModel(_durationString(initialTime), ButtonState.started);
  }

  void pause() {
    _tickerSubscription?.pause();
    state = TimerModel(state.timeLeft, ButtonState.paused);
  }

  void reset() {
    _tickerSubscription?.cancel();
    state = initialState;
  }

  @override
  void dispose() {
    _tickerSubscription?.cancel();
    super.dispose();
  }
}

class Ticker {
  static const int _initialDuration = 85999;
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(
      const Duration(seconds: 1),
      (x) => ticks + x + 1,
    ).take(_initialDuration);
  }
}

class TimerModel {
  const TimerModel([this.timeLeft, this.buttonState]);
  final String? timeLeft;
  final ButtonState? buttonState;
}

enum ButtonState {
  initial,
  started,
  paused,
  finished,
}

// in initState
// final userTimeLeftProvider =
//     FutureProvider<int>((ref) => ref.read(timerRepository).getTimeData());
