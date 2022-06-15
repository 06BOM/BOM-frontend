import 'package:bom_front/model/user.dart';
import 'package:bom_front/provider/general_provider.dart';
import 'package:bom_front/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/category.dart';

final userProvider = StateNotifierProvider<UserInfo, User>((ref) {
  final userData = ref.read(userRepository);
  return UserInfo(userData, ref);
});

class UserInfo extends StateNotifier<User> {
  late final UserRepository _repository;
  final ref;

  UserInfo(this._repository, this.ref, [User? initState]) : super(User()) {
    getUser();
  }

  Future<void> getUser() async {
    final user = await _repository
        .loadUser(); // final todos = await _repository!.loadTodos();
    if (mounted) {
      // check data
      state = user;
    }
  }

  Future editUserStar(int star) async {
    print('in editUserSTar');
    final flag = await _repository.editStar(star);
    return flag;
  }

  Future editCharacter(int id, int characterId) async {
    print('in editUserCharacter');
    final flag = await _repository.editCharacter(id, characterId);
    return flag;
  }
}

final categoryListProvider =
    StateNotifierProvider<CategoryList, AsyncValue<List<Category>>>((ref) {
  final categoryData = ref.read(userRepository);
  return CategoryList(categoryData, ref);
});

class CategoryList extends StateNotifier<AsyncValue<List<Category>>> {
  late final UserRepository _repository;
  final ref;

  CategoryList(this._repository, this.ref,
      [AsyncValue<List<Category>>? initState])
      : super(const AsyncValue.data([])) {
    getUserCategory();
  }

  Future<void> getUserCategory() async {
    state = const AsyncValue.loading();
    final category = await _repository
        .loadUserCategory(); // final todos = await _repository!.loadTodos();
    if (mounted) {
      // check data
      state = AsyncValue.data([...category]);
    }
  }

  Future createUserCategory(int? userId,
      {String? categoryName, String? color}) async {
    final category = await _repository.createCategory(userId,
        categoryName: categoryName, color: color);
    return category;
  }
}
