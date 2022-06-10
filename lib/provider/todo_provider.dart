import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bom_front/model/todo.dart';
import '../repository/plan_repository.dart';
import 'general_provider.dart';

enum TodoListFilter { all, completed, active }

final todoListFilter = StateProvider((ref) => TodoListFilter.all);
final lastPlanId = StateProvider((ref) => 0);

final todoListProvider = StateNotifierProvider<TodoList, List<Todo>>((ref) {
  final day = ref.watch(selectedDate);
  final todoData = ref.read(todoRepository(day));
  return TodoList(todoData, ref);
});

class TodoList extends StateNotifier<List<Todo>> {
  late final TodoRepository _repository; // final TodoRepository? _repository;
  final ref;

  TodoList(this._repository, this.ref, [List<Todo>? initState]) : super([]) {
    getReadTodo();
  }

  Future<void> getReadTodo() async {
    final todos = await _repository
        .loadTodos(); // final todos = await _repository!.loadTodos();
    if (mounted) {
      // check data
      state = [...todos];
      ref.read(lastPlanId.notifier).state = todos.length;
    }
  }

  Future createReadTodo(Todo todo, String userSlectedDate) async {
    final plans = await _repository.createTodo(todo,
        userSlectedDate); // final plans = await _repository!.createTodo(plan);
    return plans;
  }

  Future editReadTodo(int? planId, {bool? check, String? planName, int? repetitionType, int? categoryId, String? userSelectedDate, List<int>? userSelectedWeek}) async {
    print('in editReadTodo');
    final plans = await _repository.editTodo(planId, check: check, planName: planName, repetitionType: repetitionType, categoryId: categoryId, userSelectedDate: userSelectedDate, userSelectedWeek: userSelectedWeek);
    return plans;
  }

  Future deleteReadTodo(int id) async {
    final response = await _repository.deleteTodo(id);
    return response;
  }

  void add(String planName, int dailyId, int categoryId,
      [int repetitionType = 0]) {
    // 추후 수정
    ref.read(lastPlanId.notifier).state + 1;
    final lastId = ref.watch(lastPlanId);
    print('마지막 아이디 = $lastId in todo_provider.dart');
    state = [
      ...state,
      Todo(
        planId: lastId,
        planName: planName,
        time: 0,
        repetitionType: repetitionType,
        dailyId: dailyId,
        categoryId: categoryId,
        check: false,
      )
    ];
  }

  void toggle(int? id) {
    state = [
      for (final todo in state) //
        if (todo.planId == id)
          Todo(
              planId: todo.planId,
              planName: todo.planName,
              check: !todo.check!,
              categoryId: todo.categoryId,
              dailyId: todo.dailyId,
              repetitionType: todo.repetitionType,
              time: todo.time,
              categoryName: todo.categoryName,
              color: todo.color,
              type: todo.type,
              userId: todo.userId)
        else
          todo,
    ];
  }

  void timeEdit({required int id, required int userTime}) {
    state = [
      for (final todo in state)
        if (todo.planId == id)
          Todo(
              planId: todo.planId,
              planName: todo.planName,
              check: todo.check,
              categoryId: todo.categoryId,
              dailyId: todo.dailyId,
              repetitionType: todo.repetitionType,
              time: userTime,
              categoryName: todo.categoryName,
              color: todo.color,
              type: todo.type,
              userId: todo.userId
          )
        else
          todo,
    ];
  }

  void remove(Todo target) {
    state = state.where((todo) => todo.planId != target.planId).toList();
  }
}

final filteredTodos = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoListFilter);
  final plans = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.all:
      return plans;
    case TodoListFilter.active:
      return plans.where((plan) => !plan.check!).toList(); //
    case TodoListFilter.completed:
      return plans.where((plan) => plan.check!).toList();
    // default:
    //   return todos;
  }
});

final currentTodo = Provider<Todo>((ref) {
  // 나중에 받을 것
  return throw UnimplementedError();
});

final dailyUserStars = FutureProvider.autoDispose<int>(
    (ref) => ref.read(todoRepository(ref.watch(selectedDate))).loadStars());

final loadDailyTotalTimes = FutureProvider.autoDispose<int>((ref) =>
    ref.read(todoRepository(ref.watch(selectedDate))).loadDailyTotalTimes());

final categoryIdToCreate = StateProvider((ref) => 1);
final repetitionTypeToCreate = StateProvider((ref) => 0);
final limitedDate = StateProvider((ref) => '');
final selectedWeek = StateProvider<List<int>>((ref) => [0, 0, 0, 0, 0, 0, 0]);
final selectedDate = StateProvider<DateTime>(
    (ref) => DateTime.now());

final montlyStarsProvider = FutureProvider.autoDispose<List<MonthlyStars>>(
    (ref) =>
        ref.watch(todoRepository(ref.watch(selectedDate))).loadMonthlyStars());
