import 'dart:io';

import 'package:bom_front/repository/quiz/base_quiz_repository.dart';
import 'package:dio/dio.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../enum/difficulty.dart';
import '../../model/failure.dart';
import '../../model/question.dart';

final dioProvider = Provider<Dio>((ref) => Dio());
// To access this QuizRepository anywhere in the app, we should declare quizRepositoryProvider,
// providing our QuizRepository and passing in ref.read as the Reader.
final quizRepositoryProvider = Provider<QuizRepository>((ref) => QuizRepository(ref.read));

class QuizRepository extends BaseQuizRpository {
  // QuizRepository has a dependency on Reader from Riverpod.
  // Reader allows the QuizRepository to read other providers in the app.
  final Reader _read;

  QuizRepository(this._read);

  @override
  Future<List<Question>> getQuestions({
    int? numQuestions, // @required int numQuestions, ...
    int? categoryId,
    Difficulty? difficulty,
  })async{
    try{
      final queryParameters = {
        'type': 'multiple',
        'amount': numQuestions,
        'category': categoryId,
      };

      if (difficulty != Difficulty.any) {
        queryParameters.addAll(
          {'difficulty': EnumToString.convertToString(difficulty)},
        );
      }

      final response = await _read(dioProvider).get(
        'https://opentdb.com/api.php',
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.data);
        final results = List<Map<String, dynamic>>.from(data['results'] ?? []);
        if (results.isNotEmpty) {
          return results.map((e) => Question.fromMap(e)).toList();
        }
      }
      return [];
    } on DioError catch (err) {
      print(err);
      throw Failure(
        message: err.response?.statusMessage ?? 'Something went wrong!',
      );
    }on SocketException catch (err) {
      print(err);
      throw const Failure(message: 'Please check your connection.');
    }
  }
}