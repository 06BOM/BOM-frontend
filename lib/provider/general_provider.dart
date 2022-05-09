import 'package:bom_front/repository/statistic_repo.dart';
import 'package:bom_front/repository/timer_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/plan_repository.dart';

final todoRepository = Provider((_) => TodoRepository());
final statisticRepository = Provider((_) => StatisticRepository());
final timerRepository = Provider((_) => TimerRepository());
