import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/room.dart';
import '../repository/room_repository.dart';
import 'general_provider.dart';

final roomListProvider = StateNotifierProvider<RoomListNotifier, AsyncValue<List<Room>>>((ref) {
  final roomData = ref.read(roomRepository);
  return RoomListNotifier(roomData, ref);
});


class RoomListNotifier extends StateNotifier<AsyncValue<List<Room>>> {
  late final RoomRepository _repository;
  final ref;
  RoomListNotifier(this._repository, this.ref, [AsyncValue<List<Room>>? initState]) : super(AsyncValue.data([])){
    getAllRooms();
  }

  // 모든 방의 정보를 불러온다.
  Future<void> getAllRooms() async{
    state = const AsyncValue.loading();
    final allRooms = await _repository.loadAllRooms();
    print('$allRooms in getAllcharacter');
    if (mounted) {
      state = AsyncValue.data([...allRooms]);
      print(state);
    }
  }

  Future searchTheRoom() async{
    final rooms = await _repository.searchRoom();
    print('$rooms in searchTheRoom');
    return rooms;
  }
}