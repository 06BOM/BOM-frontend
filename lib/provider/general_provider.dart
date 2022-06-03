import 'package:bom_front/repository/room_repository.dart';
import 'package:bom_front/repository/statistic_repo.dart';
import 'package:bom_front/repository/timer_repository.dart';
import 'package:bom_front/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/character_repository.dart';
import '../repository/plan_repository.dart';

final todoRepository = Provider.family<TodoRepository, DateTime>(
    (_, day) => TodoRepository((day)));
final statisticRepository = Provider((_) => StatisticRepository());
final timerRepository = Provider((_) => TimerRepository());
final userRepository = Provider((_) => UserRepository());
final characterRepository = Provider((_) => CharacterRepository());
final roomRepository = Provider((_) => RoomRepository());
