import '../../enum/difficulty.dart';
import '../../model/question.dart';

abstract class BaseQuizRpository {
  Future<List<Question>> getQuestions({
    int numQuestions, // required빼도 됨
    int categoryId,
    Difficulty difficulty,
  });
}
