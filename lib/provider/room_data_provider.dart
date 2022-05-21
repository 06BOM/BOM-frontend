// import 'package:hooks_riverpod/hooks_riverpod.dart';
// final roomNameProvider = StateProvider<String>((ref) => "");
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final roomDataProvider = StateNotifierProvider.autoDispose<RoomData, List<dynamic>>((ref) {
  return RoomData();
});

class RoomData extends StateNotifier<List<dynamic>> {
  // dynamic _roomData = '';
  // dynamic get roomData => _roomData;

  RoomData(): super([]);

  void updateRoomData(dynamic data) {
    // _roomData = GameRoomState.fromMap(data);
    // state = [...state, data];
    state = data;
  }
}