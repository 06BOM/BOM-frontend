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

final roundDataProvider = StateNotifierProvider<roundNotifier, List<dynamic>>((ref) {
  return roundNotifier();
});

class roundNotifier extends StateNotifier<List<dynamic>> {
  roundNotifier() : super([]);

  void updateRoundData(List<dynamic> data) {
    print('$data in updateRoundData (provider)');
    // _roomData = GameRoomState.fromMap(data);
    // state = [...state, data];
    state = data;
    // ref.read(roomNameProvider.notifier).state = data[0];
  }
}

// final readyDataProvider = StateNotifierProvider<ReadyData, List<dynamic>>((ref) {
//   return ReadyData();
// });
//
// class ReadyData extends StateNotifier<List<dynamic>>{
//   ReadyData(): super([]);
//   void updateReadyData(List<dynamic> data){
//     state = data;
//   }
// }

final readyDataProvider = StateProvider<bool>((ref) {
  return false;
});

final timerProvider = StateProvider<bool>((ref) {
  return false;
});
