import 'package:bom_front/provider/general_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userWeekStarProvider =
    FutureProvider<int>((ref) => ref.read(statisticRepository).getWeekStar());

final userMonthStarProvider =
    FutureProvider<int>((ref) => ref.read(statisticRepository).getMonthstar());

final userWeekTimeProvider = FutureProvider<int>(
    (ref) => ref.read(statisticRepository).getWeekTime());

final userMonthTimeProvider = FutureProvider<int>(
    (ref) => ref.read(statisticRepository).getMonthTime());

final userWeekTimeListProvider = FutureProvider<List<int>>(
    (ref) => ref.read(statisticRepository).getWeekTimeChart());

final userMonthTimeListProvider = FutureProvider<List<int>>(
    (ref) => ref.read(statisticRepository).getMonthTimeChart());
