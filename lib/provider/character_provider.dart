import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/character.dart';

final characterListProvider = StateNotifierProvider<CharacterListNotifier, List<Character>>((ref) {
  return CharacterListNotifier();
});

class CharacterListNotifier extends StateNotifier<List<Character>> {
  CharacterListNotifier() : super([]);


}
