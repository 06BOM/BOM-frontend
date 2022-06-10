import 'package:bom_front/repository/character_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/character.dart';
import 'general_provider.dart';

final characterListProvider = StateNotifierProvider<CharacterListNotifier, AsyncValue<List<Character>>>((ref) {
  final characterData = ref.read(characterRepository);
  return CharacterListNotifier(characterData, ref);
});

class CharacterListNotifier extends StateNotifier<AsyncValue<List<Character>>> {
  late final CharacterRepository _repository;
  final ref;
  CharacterListNotifier(this._repository, this.ref, [AsyncValue<List<Character>>? initState]) : super(const AsyncValue.data([])){
    getAllCharacter();
  }

  // 모든 캐릭터의 정보를 불러온다.
  Future<void> getAllCharacter() async{
    state = const AsyncValue.loading();
    final ownCharacters = await _repository.loadOwnedCharacter();
    // print('$ownCharacters in getAllcharacter');
    final Arr = ownCharacters.map<int>((character) => character.characterId!).toList();
    // print('${Arr.runtimeType} / $Arr');
    ref.read(userCharacterProvider.notifier).state = Arr;
    final notOwnedcharacters = await _repository.loadNotOwnedCharacter();
    // print('$notOwnedcharacters in getAllcharacter');
    if (mounted) {
      state = AsyncValue.data([...ownCharacters, ...notOwnedcharacters]);
      // print('state: $state in getAllCharacter');
    }
  }

  Future searchCharacter(String text) async{
    final searchedCharacter = await _repository.fetchSearchResult(text);
    // 좀 생각해봐야함
  }

  Future addCharacter(int id) async{
    final response = await _repository.addCharacterInCollection(id);
    return response;
  }
  Future deleteCharacter(int id) async{
    final response = await _repository.deleteCharacterInCollection(id);
    return response;
  }

}

final userCharacterProvider = StateProvider<List<int>>((ref) {
  return [];
});
