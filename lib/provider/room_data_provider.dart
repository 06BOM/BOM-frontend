// import 'package:hooks_riverpod/hooks_riverpod.dart';
// final roomNameProvider = StateProvider<String>((ref) => "");
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// final roomNameProvider = StateProvider.autoDispose<String>((ref) => "");

final roomDataProvider = StateNotifierProvider.autoDispose<RoomData, List<dynamic>>((ref) {
  return RoomData(ref);
});

class RoomData extends StateNotifier<List<dynamic>> {
  // dynamic _roomData = '';
  // dynamic get roomData => _roomData;
  final Ref ref;

  RoomData(this.ref): super([]);

  void updateRoomData(List<dynamic> data) {
    print('$data in updateRoomData (provider)');
    // _roomData = GameRoomState.fromMap(data);
    // state = [...state, data];
    state = data;
    // ref.read(roomNameProvider.notifier).state = data[0];
  }
}

final roundDataProvider = StateNotifierProvider<RoundNotifier, List<dynamic>>((ref) {
  return RoundNotifier();
});

class RoundNotifier extends StateNotifier<List<dynamic>> {
  RoundNotifier() : super([]);

  void updateRoundData(List<dynamic> data) {
    print('$data in updateRoundData (provider)');
    state = data; // [과학문제1, 1]
  }
}

final answerProvider = StateNotifierProvider<AnswerNotifier, List<dynamic>>((ref) {
  return AnswerNotifier();
});

class AnswerNotifier extends StateNotifier<List<dynamic>> {
  AnswerNotifier() : super([]);

  void updateAnswerData(List<dynamic> data) {
    print('$data in updateAnswerData (provider)');
    state = data; // [0, 설명1]
  }
}


final readyDataProvider = StateProvider<bool>((ref) {
  return false;
});

final timerProvider = StateProvider<bool>((ref) {
  return false;
});
