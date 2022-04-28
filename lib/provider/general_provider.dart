import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/plan_repository.dart';

final todoRepository = Provider((_) => TodoRepository());