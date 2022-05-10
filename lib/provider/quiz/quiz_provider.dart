import 'package:bom_front/provider/quiz/quiz_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../model/question.dart';

final quizControllerProvider =
StateNotifierProvider.autoDispose<QuizController, QuizState>((ref) => QuizController());

class QuizController extends StateNotifier<QuizState> {
  QuizController() : super(QuizState.initial());

  void submitAnswer(Question currentQuestion, String answer) {
    print('Q: $currentQuestion, A: $answer');
    print(state.incorrect);
    print(state.answered);
    // We check if the current state is answered and return,
    // to prevent users from submitting answers multiple times.
    if (state.answered) return;
    if (currentQuestion.correctAnswer == answer) {
      state = state.copyWith(
          selectedAnswer: answer,
          correct: state.correct..add(currentQuestion),
          status: QuizStatus.correct);
    }else{
      state = state.copyWith(
          selectedAnswer: answer,
          incorrect: state.incorrect..add(currentQuestion),
          status: QuizStatus.incorrect
      );
    }
  }

  // when a user taps the NextQuestion or SeeResults button
  void nextQuestion(List<Question> questions, int currentIndex){
    state = state.copyWith(
      selectedAnswer: '',
      status: currentIndex + 1 < questions.length ? QuizStatus.initial : QuizStatus.complete,
    );
  }

  void reset(){
    state = QuizState.initial();
  }
}