import 'package:bom_front/provider/user_privider.dart';
import 'package:bom_front/repository/character_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/character.dart';
import 'general_provider.dart';

final characterListProvider = StateNotifierProvider<CharacterListNotifier, List<Character>>((ref) {
  final characterData = ref.read(characterRepository);
  return CharacterListNotifier(characterData, ref);
});

class CharacterListNotifier extends StateNotifier<List<Character>> {
  late final CharacterRepository _repository;
  final ref;
  CharacterListNotifier(this._repository, this.ref, [List<Character>? initState]) : super(const []){
    getAllCharacter();
  }

  // 모든 캐릭터의 정보를 불러온다.
  Future<void> getAllCharacter() async{
    final ownCharacters = await _repository.loadOwnedCharacter(); // 캐릭터 구매시 프로파이더 따로 만들어서 엮기 (근데 또 캐릭터 구매시 업데이트가 잘 되네????)
    // print('$ownCharacters in getAllcharacter');
    final Arr = ownCharacters.map<int>((character) => character.characterId!).toList();
    // print('${Arr.runtimeType} / $Arr');
    ref.read(userCharacterProvider.notifier).state = Arr;
    final notOwnedcharacters = await _repository.loadNotOwnedCharacter();
    // print('$notOwnedcharacters in getAllcharacter');
    if (mounted) {
      state = [...ownCharacters, ...notOwnedcharacters];
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
  Future<String> getCharacterUrl(int id) async{
    final response = await _repository.fetchCharacterImageUrl(id);
    return response;
  }
}

final userCharacterProvider = StateProvider<List<int>>((ref) {
  return [];
});

final userCharacterUrlProvider = FutureProvider<String>((ref) {
  return ref.read(characterListProvider.notifier).getCharacterUrl(ref.watch(userProvider).characterId!);
});
