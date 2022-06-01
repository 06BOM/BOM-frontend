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
  CharacterListNotifier(this._repository, this.ref, [List<Character>? initState]) : super([]){
    getAllCharacter();
  }

  Future<void> getAllCharacter() async{
    final ownCharacters = await _repository.loadOwnedCharacter();
    print('$ownCharacters in getAllcharacter');
    final notOwnedcharacters = await _repository.loadNotOwnedCharacter();
    print('$notOwnedcharacters in getAllcharacter');
    if (mounted) {
      state = [...ownCharacters, ...notOwnedcharacters];
      print(state);
    }
  }


}
