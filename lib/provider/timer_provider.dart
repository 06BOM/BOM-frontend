import 'package:bom_front/view/timer_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bom_front/model/todo.dart';
import '../repository/timer_repository.dart';
import 'general_provider.dart';
import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimerNotifier extends StateNotifier<TimerModel> {

  TimerNotifier() : super(_initialState);

  static int _initialTime = 0;

  static final _initialState = TimerModel(
    _durationString(_initialTime),
    ButtonState.initial,
  );

  final Ticker _ticker = Ticker();
  StreamSubscription<int>? _tickerSubscription;

  static String _durationString(int duration) {
    if (duration % 30 == 0 && duration != 0) {
      TimerRepository().postStarData();
    } //30분마다 전송
    final hour =
        (((duration / 60) / 60) % 60).floor().toString().padLeft(2, '0');
    final minutes = ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final seconds = (duration % 60).floor().toString().padLeft(2, '0');
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
    _tickerSubscription = _ticker.tick(ticks: _initialTime).listen((duration) {
      // 한계가 이정도다
      state = TimerModel(_durationString(duration), ButtonState.started);
    });

    _tickerSubscription?.onDone(() {
      state = TimerModel(state.timeLeft, ButtonState.finished);
    });

    state = TimerModel(_durationString(_initialTime), ButtonState.started);
  }

  void pause() {
    _tickerSubscription?.pause();
    state = TimerModel(state.timeLeft, ButtonState.paused);
  }

  void reset() {
    _tickerSubscription?.cancel();
    state = _initialState;
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
      Duration(seconds: 1),
      (x) => ticks + x + 1,
    ).take(_initialDuration);
  }
}

class TimerModel {
  const TimerModel(this.timeLeft, this.buttonState);
  final String timeLeft;
  final ButtonState buttonState;
}

enum ButtonState {
  initial,
  started,
  paused,
  finished,
}

final userTimeLeftProvider =
    FutureProvider<int>((ref) => ref.read(timerRepository).getTimeData());
