import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/room.dart';
import '../repository/room_repository.dart';
import 'general_provider.dart';

final roomListProvider = StateNotifierProvider<RoomListNotifier, List<Room>>((ref) {
  final roomData = ref.read(roomRepository);
  return RoomListNotifier(roomData, ref);
});


class RoomListNotifier extends StateNotifier<List<Room>> {
  late final RoomRepository _repository;
  final ref;
  RoomListNotifier(this._repository, this.ref, [List<Room>? initState]) : super([]){
    getAllRooms();
  }

  // 모든 방의 정보를 불러온다.
  Future<void> getAllRooms() async{
    final allRooms = await _repository.loadAllRooms();
    print('$allRooms in getAllcharacter');
    if (mounted) {
      state = [...allRooms];
      print(state);
    }
  }

  Future searchTheRoom() async{
    final rooms = await _repository.searchRoom();
    print('$rooms in searchTheRoom');
    return rooms;
  }
}