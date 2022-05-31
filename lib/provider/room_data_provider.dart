import 'dart:convert';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// final roomDataProvider = StateNotifierProvider.autoDispose<RoomData, List<dynamic>>((ref) {
//   return RoomData(ref);
// });
final roomDataProvider = StateNotifierProvider<RoomData, List<dynamic>>((ref) {
  return RoomData(ref);
});

class RoomData extends StateNotifier<List<dynamic>> {
  final Ref ref;
  RoomData(this.ref) : super([]);

  void updateRoomData(List<dynamic> data) {
    List<dynamic> list = data.asMap().entries.map((entry) {
      int idx = entry.key;
      dynamic val = entry.value;
      return idx == 2 ? json.decode(val) : val;
    }).toList();

    state = list;
    // state = [...state, data];
    // ref.watch(roomUsersProvider.notifier).state = list;
  }
}

final roundDataProvider = StateNotifierProvider<RoundNotifier, List<dynamic>>((ref) {
  return RoundNotifier();
});

class RoundNotifier extends StateNotifier<List<dynamic>> {
  RoundNotifier() : super([]);

  void updateRoundData(List<dynamic> data) {
    state = data; // [과학문제1, 1]
  }
}

final answerProvider = StateNotifierProvider<AnswerNotifier, List<dynamic>>((ref) {
  return AnswerNotifier();
});

class AnswerNotifier extends StateNotifier<List<dynamic>> {
  AnswerNotifier() : super([]);

  void updateAnswerData(List<dynamic> data) {
    state = data; // [o, 설명1]
  }
}

final scoreProvider = StateNotifierProvider<ScoreNotifier, List<dynamic>>((ref) {
  return ScoreNotifier();
});

class ScoreNotifier extends StateNotifier<List<dynamic>> {
  ScoreNotifier() : super([]);

  void updateScore(List<dynamic> data){
    state = data;
  }
}

final roomMsgProvider = StateNotifierProvider<MsgNotifier, List<String>>((ref) {
  return MsgNotifier();
});

class MsgNotifier extends StateNotifier<List<String>> {
  MsgNotifier() : super([]);

  void updateMsg(String data){
    state = [...state, data];
  }
}

final readyDataProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

final timerProvider = StateProvider<bool>((ref) {
  return false;
});

final showAnswerProvider = StateProvider<bool>((ref){
  return false;
});

final roomUsersProvider = StateProvider<List<dynamic>>((ref){
  return [];
});